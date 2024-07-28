//
//  AllTransactionsViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev on 16/05/2024.
//

import UIKit
import Lottie

class AllTransactionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var noTransactionsView: UIView!
    @IBOutlet var table_View: UITableView!
    @IBOutlet var noTranLabel: UILabel!
    
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
    
    func initMethods() {
        addNavBar()
        allTransactions = coreDB.fetchTransactions()
        noTranLabel.text = noTran
        table_View.dataSource = self
        table_View.delegate = self
    }
    
    private func addNavBar() {
        title = title7
        let ic_back = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: ic_back, style: .plain, target: self, action: #selector(backTapped))
    }
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 10
    }
    
    private func setupAnimation() {
        animationView.animation = .named("data-scanning")
        animationView.frame = noTransactionsView.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        noTransactionsView.addSubview(animationView)
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
    func callHomeScreen() {
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
//        self.present(nv, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        if lastTransaction.type == "Expense ▼" || lastTransaction.type == "Income ▼" {
            cell.amout.text = Double(lastTransaction.amount ?? "0.0")?.currencyUS
        } else if lastTransaction.type == "경비 ▼" || lastTransaction.type == "수입 ▼" {
            cell.amout.text = Double(lastTransaction.amount ?? "0.0")?.currencyKR
        } else if lastTransaction.type == "Chiqim ▼" || lastTransaction.type == "Kirim ▼" {
            cell.amout.text = Double(lastTransaction.amount ?? "0.0")?.currencyUZ
        }
        
        if lastTransaction.type == "Expense ▼" || lastTransaction.type == "Chiqim ▼" || lastTransaction.type == "경비 ▼" {
            cell.amout.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            cell.amout.textColor = #colorLiteral(red: 0.4696043647, green: 0.8248788522, blue: 0.006127688114, alpha: 1)
        }
        cell.notes.text = lastTransaction.notes
        cell.date.text = lastTransaction.date
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
                    self.table_View.reloadData()
                    callHomeScreen()
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
