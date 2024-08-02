//
//  NewTransactionViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev.
//

import UIKit

class NewTransactionViewController: UIViewController {
    
    
    @IBOutlet var mainBackgroundView: UIScrollView!
    @IBOutlet var warningLabel: UILabel!
    
    @IBOutlet weak var typeSection_BV: UIView!
    @IBOutlet weak var typeSelectorIndicator: UILabel!
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var notesLabel: UITextField!
    @IBOutlet weak var expenseSelectLabel: UILabel!
    @IBOutlet weak var incomeSelectLabel: UILabel!
    @IBOutlet weak var typeSelector_BV: UIView!
    
    
    @IBOutlet weak var amountSection_BV: UIView!
    @IBOutlet weak var dateSection_BV: UIView!
    @IBOutlet weak var noteSection_BV: UIView!
    
    
    @IBOutlet var saveBtnBackgroundView: UIView!
    @IBOutlet var dateInputLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var type_label: UILabel!
    @IBOutlet var amount_label: UILabel!
    @IBOutlet var date_label: UILabel!
    @IBOutlet var notes_label: UILabel!
    @IBOutlet var saveBtn: UIButton!
    
    
    var navTitle = "title5".localized()
    var type = "type".localized()
    var typeLabel = "typeLabel".localized()
    var expenseL = "expenseL".localized()
    var incomeL = "incomeL".localized()
    var amount = "amount".localized()
    var date = "date".localized()
    var setDate = "setDate".localized()
    var notes = "notes".localized()
    var notePlaceholder = "notePlaceholder".localized()
    var errorLabel = "error".localized()
    var saveBtn_label = "saveBtn".localized()
    
    
    let defaults1 = UserDefaults.standard
    let defaults = DefaultsOfUser()
    let coreDB = TransactionService.shared
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        self.hideKeyboardWhenTappedAround()
    }

    // MARK: - Actions
    @IBAction func saveNewTrnBtn(_ sender: Any) {
        
        guard let type = typeSelectorIndicator.text else {
            warningLabel.isHidden = false
            warningLabel.text = "Select type please"
            return
        }
        guard let amount = amountTextField.text, amountTextField.text != ""  else {
            warningLabel.isHidden = false
            warningLabel.text = "Insert amount please"
            return
        }
        guard let date =  dateInputLabel.text, dateInputLabel.text != "" else {
            warningLabel.isHidden = false
            warningLabel.text = "Select date please"
            return
        }
        guard let notes = notesLabel.text, notesLabel.text != "" else {
            warningLabel.isHidden = false
            warningLabel.text = "Insert notes please"
            return
        }
        
        //Calculation Stuff...
        var totalBalance = Int(defaults.getCashBalance()!)
        var income = Int(defaults.getIncome()!)
        var expense = Int(defaults.getExpense()!)
        
        if type == (expenseL + " ▼") {
            totalBalance = totalBalance! - Int(amount)!
            defaults.saveCashBalance(balance: String(totalBalance!))
            expense = expense! + Int(amount)!
            defaults.saveExpense(expense: String(expense!))
            print("Expense")
        } else if type == (incomeL + " ▼") {
            totalBalance = totalBalance! + Int(amount)!
            defaults.saveCashBalance(balance: String(totalBalance!))
            income = income! + Int(amount)!
            defaults.saveIncome(income: String(income!))
            print("Income")
        }

        coreDB.saveTransaction(
            type: type,
            amount: amount,
            date: date,
            notes: notes)
        
        callHomeScreen()
    }
    @IBAction func datePicker_Action(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateInputLabel.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        print(datePicker.date)
    }
    
    // MARK: - Methods
    
    private func initViews() {
        addNavBar()
        setUpTransactionType()
        setLangValue()
        
        typeSection_BV.layer.cornerRadius = 13.0
        modifierUI(ui: typeSection_BV)
        modifierUI(ui: typeSelector_BV)
        amountSection_BV.layer.cornerRadius = 13.0
        modifierUI(ui: amountSection_BV)
        dateSection_BV.layer.cornerRadius = 13.0
        modifierUI(ui: dateSection_BV)
        noteSection_BV.layer.cornerRadius = 13.0
        modifierUI(ui: noteSection_BV)
        saveBtnBackgroundView.layer.cornerRadius = 18.0
        modifierUI(ui: saveBtnBackgroundView)
    }
    
    private func addNavBar() {
        title = navTitle
        let ic_back = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: ic_back, style: .plain, target: self, action: #selector(backTapped))
    }
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func callHomeScreen() {
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
        //        self.present(nv, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5.0
    }
    
    private func setLangValue() {
        currencyLabel.text = defaults.getCurrency()
        
        type_label.text = type
        typeSelectorIndicator.text = typeLabel
        expenseSelectLabel.text = expenseL
        incomeSelectLabel.text = incomeL
        amount_label.text = amount
        date_label.text = date
        dateInputLabel.text = setDate
        notes_label.text = notes
        notesLabel.placeholder = notePlaceholder
        warningLabel.text = errorLabel
        saveBtn.setTitle(saveBtn_label, for: .normal)
        
    }
    
    //Type of Transaction...
    
    var income = "income".localized()
    var expense = "expense".localized()
    
    func setUpTransactionType() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped))
        self.typeSelectorIndicator.isUserInteractionEnabled = true
        self.typeSelectorIndicator.addGestureRecognizer(labelTap)
        }

    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        typeSelector_BV.isHidden.toggle()
        expanseTapped()
        incomeTapped()
    }

    func expanseTapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.expenseSelected))
        self.expenseSelectLabel.isUserInteractionEnabled = true
        self.expenseSelectLabel.addGestureRecognizer(labelTap)
        }

    @objc func expenseSelected(_ sender: UITapGestureRecognizer) {
        typeSelectorIndicator.text = expense + " ▼"
        typeSelector_BV.isHidden.toggle()
    }

    func incomeTapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.incomeSelected))
        self.incomeSelectLabel.isUserInteractionEnabled = true
        self.incomeSelectLabel.addGestureRecognizer(labelTap)
        }

    @objc func incomeSelected(_ sender: UITapGestureRecognizer) {
        typeSelectorIndicator.text = income + " ▼"
        typeSelector_BV.isHidden.toggle()
    }
    
    func getCurrentDate() -> Date{
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return currentDate
    }

    func showUpTrn_AlertAction(body: String, object: Transaction) {
        let alert = UIAlertController(title: "Hi, Boss", message: body, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
//            self.realmDB.deleteTransaction(object: object)
//            self.openScreen(vc: "Home_VC")
            self.callHomeScreen()
        }))
        alert.addAction(UIAlertAction(title: "Not", style: .cancel, handler: { action in
//            self.openScreen(vc: "Home_VC")
            self.callHomeScreen()
        }))
    }


}
