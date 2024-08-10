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
    var typeWarningLabel = "typeWarningLabel".localized()
    var amountWarningLabel = "amountWarningLabel".localized()
    var dateWarningLabel = "dateWarningLabel".localized()
    var notesWarningLabel = "notesWarningLabel".localized()
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
        checkAndSaveInputs()
    }
    @IBAction func datePicker_Action(_ sender: Any) {
        inputDateValue()
    }
    
    // MARK: - Methods
    
    private func initViews() {
        addNavBar()
        setUpTransactionType()
        setLangValue()
        
        typeSection_BV.applyShadow(cornerRadius: 13.0)
        typeSelector_BV.applyShadow()
        amountSection_BV.applyShadow(cornerRadius: 13.0)
        dateSection_BV.applyShadow(cornerRadius: 13.0)
        noteSection_BV.applyShadow(cornerRadius: 13.0)
        saveBtnBackgroundView.applyShadow(cornerRadius: 18.0)
    }
    
    private func addNavBar() {
        title = navTitle
        let ic_back = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: ic_back, style: .plain, target: self, action: #selector(backTapped))
    }
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func checkAndSaveInputs() {
        guard let type = typeSelectorIndicator.text else {
            warningLabel.isHidden = false
            warningLabel.text = typeWarningLabel
            return
        }
        guard let amount = amountTextField.text, !amount.isEmpty else {
            warningLabel.isHidden = false
            warningLabel.text = amountWarningLabel
            return
        }
        guard let date = dateInputLabel.text, date != setDate else {
            warningLabel.isHidden = false
            warningLabel.text = dateWarningLabel
            return
        }
        guard let notes = notesLabel.text, !notes.isEmpty else {
            warningLabel.isHidden = false
            warningLabel.text = notesWarningLabel
            return
        }
        warningLabel.isHidden = true
        
        //Calculation Stuff...
        var totalBalance = Int(defaults.getCashBalance()!)
        var income = Int(defaults.getIncome()!)
        var expense = Int(defaults.getExpense()!)
        
        if type == (expenseL + " ▼") {
            totalBalance = totalBalance! - Int(amount)!
            defaults.saveCashBalance(balance: String(totalBalance!))
            expense = expense! + Int(amount)!
            defaults.saveExpense(expense: String(expense!))
        } else if type == (incomeL + " ▼") {
            totalBalance = totalBalance! + Int(amount)!
            defaults.saveCashBalance(balance: String(totalBalance!))
            income = income! + Int(amount)!
            defaults.saveIncome(income: String(income!))
        }

        coreDB.saveTransaction(
            type: type,
            amount: amount,
            date: date,
            notes: notes)
        callHomeScreen()
    }
    
    private func inputDateValue() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateInputLabel.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    private func callHomeScreen() {
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
//        self.present(nv, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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
//End.
}
