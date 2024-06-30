//
//  HomeViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev
//
// BV = Background View
// ic = Icon
// img = Image View



import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func didButtonTapped(index: Int) {
    }
    
    
    
    @IBOutlet weak var totalBalance_BV: UIView!
    @IBOutlet weak var table_View: UITableView!
    
    
    @IBOutlet var totalBalance_BIV: UIImageView!
    
    @IBOutlet var totalBalance_title: UILabel!
    @IBOutlet var totalBalance: UILabel!
    @IBOutlet var baseCurrency: UILabel!
    @IBOutlet var incomeTitle: UILabel!
    @IBOutlet var incomeLabel: UILabel!
    @IBOutlet var expenseLabel: UILabel!
    @IBOutlet var expenseTitle: UILabel!
    
    
    @IBOutlet var transactions_BViewImage: UIImageView!
    @IBOutlet var transactions_BView: UIView!
    
    @IBOutlet var exp_profit_Btn: UIButton!
    @IBOutlet var transactions_Btn: UIButton!
    @IBOutlet var exp_cost_Btn: UIButton!
    
    @IBOutlet var exp_cost_BViewImage: UIImageView!
    @IBOutlet var exp_profit_BViewImage: UIImageView!
    @IBOutlet var exp_profit_BView: UIView!
    @IBOutlet var exp_cost_BView: UIView!
    
    @IBOutlet var lastTran: UILabel!
    @IBOutlet var viewAll_Btn: UIButton!
    @IBOutlet var today_label: UILabel!
    @IBOutlet var addnewTran_lebel: UILabel!
    @IBOutlet var bottomSide_View: UIView!
    
    @IBOutlet weak var bottomSidesItemView: UIView!
    @IBOutlet weak var rightBtnBackgroundView: UIView!
    @IBOutlet weak var centerBtnBackgroundView: UIView!
    @IBOutlet weak var leftBtnBackgroundView: UIView!
    
    
    @IBOutlet var noTransactionsView: UIView!
    
    var total_Balance = "totalBalance".localized()
    var income = "income".localized()
    var expense = "expense".localized()
    var typeLabel = "typeLabel".localized()
    var expProfit = "expProfit".localized()
    var transaction = "transaction".localized()
    var expCost = "expCost".localized()
    var lastTranLabel = "lastTranLabel".localized()
    var viewAll = "viewAll".localized()
    var todayLabel = "todayLabel".localized()
    var addNewTranLabel = "addNewTranLabel".localized()
    var lang = "LangLabel".localized()
    
    let defaults1 = UserDefaults.standard
    let defaults = DefaultsOfUser()
    let coreDB = TransactionService.shared
    
    var transactions: [Transaction] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        initviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animatedTableView()
    }
    
    
    @IBAction func expectingProfitBtn_Action(_ sender: Any) {
        setSelectedProfitBtn()
    }
    @IBAction func lastTrasactionsBtn_Action(_ sender: Any) {
        setSelectedTransactionBtn()
    }
    @IBAction func expectingCostBtn_Action(_ sender: Any) {
        setSelectedCostBtn()
    }
    
    @IBAction func addNewTrnBtn(_ sender: Any) {
        callAddNewTrnScreen()
    }
    
    
    //...Set up selectedbutton background view
    func setSelectedProfitBtn() {
        exp_profit_BViewImage.image = UIImage(named: "gradiantBV")
        transactions_BViewImage.image = UIImage(named: "")
        exp_cost_BViewImage.image = UIImage(named: "")
        
        exp_profit_Btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        exp_cost_Btn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        transactions_Btn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        
        transactions = TransactionService.shared.fetchTransactions()
        table_View.reloadData()
    }
    func setSelectedTransactionBtn() {
        exp_profit_BViewImage.image = UIImage(named: "")
        transactions_BViewImage.image = UIImage(named: "gradiantBV")
        exp_cost_BViewImage.image = UIImage(named: "")
        
        transactions_Btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        exp_cost_Btn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        exp_profit_Btn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        
        transactions = TransactionService.shared.fetchTransactions()
        table_View.reloadData()
    }
    func setSelectedCostBtn() {
        exp_profit_BViewImage.image = UIImage(named: "")
        transactions_BViewImage.image = UIImage(named: "")
        exp_cost_BViewImage.image = UIImage(named: "gradiantBV")
        
        exp_cost_Btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        transactions_Btn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        exp_profit_Btn.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        
        transactions = TransactionService.shared.fetchTransactions()
        table_View.reloadData()
    }



    // MARK: - Methods
    
    private func initviews() {
        addNavigationbar()
        getModifiedViews()
        setLangValue()
        
        table_View.dataSource = self
        table_View.delegate = self
        
        transactions = coreDB.fetchTransactions()
        table_View.reloadData()
    }
    
    private func setLangValue() {
//        localizationBtn.setTitle(lang, for: .normal)
        totalBalance_title.text = total_Balance
        incomeTitle.text = income
        expenseTitle.text = expense
        exp_profit_Btn.setTitle(expProfit, for: .normal)
        transactions_Btn.setTitle(transaction, for: .normal)
        exp_cost_Btn.setTitle(expCost, for: .normal)
        lastTran.text = lastTranLabel
        viewAll_Btn.setTitle(viewAll, for: .normal)
        today_label.text = todayLabel
        addnewTran_lebel.text = addNewTranLabel
    }

    private func getModifiedViews() {
        
        totalBalance_BV.layer.cornerRadius = 22.0
        modifierUI(ui: totalBalance_BV)
        
//        notificationCenter.delegate = self
        
//        let img = defaults.getProfileImage()
//        
//        if img != nil && img != ""{
//            main_img.image = defaults.getProfileImage()?.toImage()
//        }
//        localizationBtn.setTitle(defaults.getLanguage(), for: .normal)
        
        
        
//        modifierUI(ui: navigationBarBackgroundView)
//        main_img.layer.cornerRadius = 22.0
//        localizationBtn.layer.cornerRadius = 8.0
//        totalMoney_view.layer.cornerRadius = 22.0
        
        totalBalance.text = Int(defaults.getCashBalance()!)?.formattedWithSeparator
        baseCurrency.text = defaults.getCurrency()
        incomeLabel.text = Int(defaults.getIncome()!)?.formattedWithSeparator
        expenseLabel.text = Int(defaults.getExpense()!)?.formattedWithSeparator
        
        totalBalance_BIV.layer.cornerRadius = 22.0
        totalBalance_BV.layer.cornerRadius = 22.0
        modifierUI(ui: totalBalance_BV)
        exp_profit_BViewImage.layer.cornerRadius = 18.0
        exp_profit_BView.layer.cornerRadius = 18.0
        modifierUI(ui: exp_profit_BView)
        transactions_BViewImage.layer.cornerRadius = 18.0
        transactions_BView.layer.cornerRadius = 18.0
        modifierUI(ui: transactions_BView)
        exp_cost_BViewImage.layer.cornerRadius = 18.0
        exp_cost_BView.layer.cornerRadius = 18.0
        modifierUI(ui: exp_cost_BView)
        bottomSide_View.layer.cornerRadius = 22.0
        modifierUI(ui: bottomSide_View)
        bottomSidesItemView.layer.cornerRadius = 18.0
        modifierUI(ui: bottomSidesItemView)
        rightBtnBackgroundView.layer.cornerRadius = 13.0
        centerBtnBackgroundView.layer.cornerRadius = 13.0
        leftBtnBackgroundView.layer.cornerRadius = 13.0
        
    }
    
    private func addNavigationbar() {
        let titleLabel = UILabel()
        titleLabel.textColor = #colorLiteral(red: 0.3058553934, green: 0.8274359107, blue: 0.9806613326, alpha: 1)
        titleLabel.text = "Cash Flow"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        let rightNavBtn = UIImage(systemName: "folder.badge.gearshape")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightNavBtn, style: .plain, target: self, action: #selector(rightNavBarBtn))
    }
    
    @objc private func leftNavBarBtn() {
        callAddNewTrnScreen()
    }
    
    @objc private func rightNavBarBtn() {
        callAddNewTrnScreen()
    }
    
  
    func callHomeScreen() {
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
//        self.present(nv, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func callAddNewTrnScreen() {
        let vc = NewTransactionViewController(nibName: "NewTransactionViewController", bundle: nil)
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
//        self.present(nv, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5.0
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
        if transactions.count == 0 {
            table_View.isHidden = true
            noTransactionsView.isHidden = false
//            setupAnimation()
        } else {
            table_View.isHidden = false
            noTransactionsView.isHidden = true
            noTransactionsView.isUserInteractionEnabled = true
        }

        if transactions.count >= 8 {
            return 8
        } else {
            return transactions.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Current date
//        let currentDate = Date()
//        let calendar = Calendar.current
//        let currentDay = calendar.component(.day, from: currentDate)
        
        let cell = Bundle.main.loadNibNamed("LastTransactionTableViewCell", owner: self, options: nil)?.first as! LastTransactionTableViewCell
        let lastTransaction = transactions[indexPath.row]
        

        if lastTransaction.type == "Expense ▼" || lastTransaction.type == "Income ▼" {
            cell.amout.text = Double(lastTransaction.amount ?? "0.0")?.currencyUS
        } else if lastTransaction.type == "경비 ▼" || lastTransaction.type == "수입 ▼" {
            cell.amout.text = Double(lastTransaction.amount ?? "0.0")?.currencyKR
        } else if lastTransaction.type == "Chiqim ▼" || lastTransaction.type == "Kirim ▼" {
            cell.amout.text = Double(lastTransaction.amount ?? "0.0")?.currencyUZ
        }


        if lastTransaction.type == "Expense ▼" || lastTransaction.type == "Chiqim ▼" || lastTransaction.type == "경비 ▼" {
            print("TEST_______>>>> \(String(describing: lastTransaction.type))")
            cell.amout.textColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        } else {
            cell.amout.textColor = #colorLiteral(red: 0.4696043647, green: 0.8248788522, blue: 0.006127688114, alpha: 1)
        }
        
        cell.amout.text = lastTransaction.amount
        cell.notes.text = lastTransaction.notes
        cell.date.text = lastTransaction.date
        
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let lastTransaction = transactions[indexPath.row]
//
//        let vc = self.storyboard?.instantiateViewController(identifier: "SelectedTransaction_VC") as! SelectedTransaction_ViewController
//
//        vc.selectedTransacion = lastTransaction
//        vc.amount = lastTransaction.amount
//        vc.categoryImg = lastTransaction.icon
//        vc.category_Label = lastTransaction.category
//        vc.type = lastTransaction.type
//        vc.date = lastTransaction.date
//        vc.note = lastTransaction.notes
//
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let lastTransaction = self.transactions[indexPath.row]
        
        let expenseL = "expenseL".localized()
        let incomeL = "incomeL".localized()
        let actionSheetTitle = "actionSheetTitle".localized()
        let actionSheetDeleteTitle = "actionSheetDeleteTitle".localized()
        let actionSheetCancelTitle = "actionSheetCancelTitle".localized()
        
        var totalBalance = Int(defaults.getCashBalance() ?? "0")
        var income = Int(defaults.getIncome() ?? "0")
        var expense = Int(defaults.getExpense() ?? "0")
        
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
                self.transactions = TransactionService.shared.fetchTransactions()
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

//End.
}



extension Formatter {
    static let number = NumberFormatter()
}
extension Locale {
    static let englishUS: Locale = .init(identifier: "en_US")
    static let koreaKR: Locale = .init(identifier: "ko_KR")
    static let uzbek: Locale = .init(identifier: "uz_Latn_UZ")
    static let russianRU: Locale = .init(identifier: "ru_RU")
    // ... and so on
}
extension Numeric {
    func formatted(with groupingSeparator: String? = nil, style: NumberFormatter.Style, locale: Locale = .current) -> String {
        Formatter.number.locale = locale
        Formatter.number.numberStyle = style
        if let groupingSeparator = groupingSeparator {
            Formatter.number.groupingSeparator = groupingSeparator
        }
        return Formatter.number.string(for: self) ?? ""
    }
    // Localized
    var currency:   String { formatted(style: .currency) }
    // Fixed locales
    var currencyUS: String { formatted(style: .currency, locale: .englishUS) }
    var currencyKR: String { formatted(style: .currency, locale: .koreaKR) }
    var currencyUZ: String { formatted(style: .currency, locale: .uzbek) }
    var currencyRU: String { formatted(style: .currency, locale: .russianRU) }

}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}
extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

