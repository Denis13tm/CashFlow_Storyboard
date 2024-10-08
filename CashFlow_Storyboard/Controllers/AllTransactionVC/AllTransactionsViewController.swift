//
//  AllTransactionsViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev.
//

import UIKit
import Lottie

class AllTransactionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var noTransactionsView: UIView!
    @IBOutlet weak var table_View: UITableView!
    @IBOutlet weak var noTranLabel: UILabel!
    @IBOutlet weak var noTrnsViewAnimatio_BV: UIStackView!
    
    let title7 = "title7".localized()
    let noTran = "noTran".localized()
    let expenseL = "expenseL".localized()
    let incomeL = "incomeL".localized()
    
    
    let defaults = DefaultsOfUser()
    let coreDB = TransactionService.shared
    var allTransactions = [Transaction]()
    let animationView = LottieAnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        initMethods()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animatedTableView()
    }

    // MARK: - Methods
    
    private func initMethods() {
        identifyUIDevice()
        addNavBar()
        allTransactions = coreDB.fetchTransactions()
        noTranLabel.text = noTran
        table_View.dataSource = self
        table_View.delegate = self
        table_View.reloadData()
    }
    
    private func identifyUIDevice() {
        noTrnsViewAnimatio_BV.translatesAutoresizingMaskIntoConstraints = false
        if UIDevice.current.userInterfaceIdiom == .phone {
            NSLayoutConstraint.activate([
                noTrnsViewAnimatio_BV.heightAnchor.constraint(equalToConstant: 350)
            ])
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            NSLayoutConstraint.activate([
                noTrnsViewAnimatio_BV.heightAnchor.constraint(equalToConstant: 700)
            ])
        }
    }
    
    private func addNavBar() {
        title = title7
        let ic_back = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: ic_back, style: .plain, target: self, action: #selector(backTapped))
    }
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupAnimation() {
        animationView.animation = .named("data-scanning")
        animationView.frame = noTrnsViewAnimatio_BV.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        noTrnsViewAnimatio_BV.addSubview(animationView)
    }
    
    public func animatedTableView() {
        table_View.reloadData()
        let cells = table_View.visibleCells
        let tableViewHeight = table_View.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    
    //MARK: - Table View...
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allTransactions.count == 0 {
            table_View.isHidden = true
            noTransactionsView.isHidden = false
            setupAnimation()
        } else {
            table_View.isHidden = false
            noTransactionsView.isHidden = true
        }
        return allTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("LastTransactionTableViewCell", owner: self, options: nil)?.first as! LastTransactionTableViewCell
        let lastTransaction = allTransactions[indexPath.row]
        
        if defaults.getCurrency() == "USD" {
            cell.amout.text = Double(lastTransaction.amount ?? "0.0")?.currencyUS
        } else if defaults.getCurrency() == "WON" || defaults.getCurrency() == "원" || defaults.getCurrency() == "вон" {
            cell.amout.text = Double(lastTransaction.amount ?? "0.0")?.currencyKR
        } else if defaults.getCurrency() == "SUM" || defaults.getCurrency() == "сум" {
            cell.amout.text = Double(lastTransaction.amount ?? "0.0")?.currencyUZ
        }
        
        if lastTransaction.type == "Expense ▼" || lastTransaction.type == "Расход ▼" || lastTransaction.type == "경비 ▼" {
            cell.amout.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            cell.amout.textColor = #colorLiteral(red: 0.4696043647, green: 0.8248788522, blue: 0.006127688114, alpha: 1)
        }
        
        cell.notes.text = lastTransaction.notes
        cell.date.text = lastTransaction.date
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let actionSheetTitle = "actionSheetTitle".localized()
        let actionSheetDeleteTitle = "actionSheetDeleteTitle".localized()
        let actionSheetCancelTitle = "actionSheetCancelTitle".localized()

        if editingStyle == .delete {

            let lastTransaction = allTransactions[indexPath.row]
            
            var totalBalance = Int(defaults.getCashBalance()!)
            var income = Int(defaults.getIncome()!)
            var expense = Int(defaults.getExpense()!)
            
            func showActionSheet() {
                let actionsheet = UIAlertController(title: actionSheetTitle, message: nil, preferredStyle: .actionSheet)
                actionsheet.addAction(UIAlertAction(title: actionSheetDeleteTitle, style: .destructive, handler: { [self] _ in
                    
                    if lastTransaction.type == (expenseL + " ▼") {
                        totalBalance = totalBalance! + Int(lastTransaction.amount ?? "0")!
                        self.defaults.saveCashBalance(balance: String(totalBalance!))
                        if expense! >= 0 {
                            expense = expense! - Int(lastTransaction.amount ?? "0")!
                            self.defaults.saveExpense(expense: String(expense!))
                        }
                    } else if lastTransaction.type == (incomeL + " ▼") {
                        totalBalance = totalBalance! - Int(lastTransaction.amount ?? "0")!
                        self.defaults.saveCashBalance(balance: String(totalBalance!))
                        if income! >= 0 {
                            income = income! - Int(lastTransaction.amount ?? "0")!
                            self.defaults.saveIncome(income: String(income!))
                        }
                    }
                    
                    TransactionService.shared.deleteTransaction(transaction: lastTransaction)
                    self.allTransactions = TransactionService.shared.fetchTransactions()
                    NotificationCenter.default.post(name: .singleTrnDidDeleted, object: nil)
                    self.table_View.reloadData()
                }))
                actionsheet.addAction(UIAlertAction(title: actionSheetCancelTitle, style: .default, handler: { _ in
                }))
                present(actionsheet, animated: true)
            }
            
            if editingStyle == .delete {
                showActionSheet()
            }
        }
    }


}
