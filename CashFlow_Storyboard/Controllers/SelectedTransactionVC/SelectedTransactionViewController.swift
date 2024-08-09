//
//  SelectedTransactionViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev.
//

import UIKit

class SelectedTransactionViewController: UIViewController {
    
    @IBOutlet weak var typeSection_BV: UIView!
    @IBOutlet weak var typeSelectorLabel: UILabel!
    
    
    @IBOutlet weak var amountSection_BV: UIView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var dateSection_BV: UIView!
    @IBOutlet weak var dateInputLabel: UILabel!
    
    @IBOutlet weak var noteSection_BV: UIView!
    @IBOutlet weak var noteInputValue: UILabel!

    let defaults = DefaultsOfUser()
    let coreDB = TransactionService.shared
    
    var selectedTransacion = Transaction()
    var type: String?
    var amount: String?
    var date: String?
    var note: String?
    
    //Sections' labels
    @IBOutlet weak var type_label: UILabel!
    @IBOutlet weak var amount_label: UILabel!
    @IBOutlet weak var date_label: UILabel!
    @IBOutlet weak var notes_label: UILabel!
    
    var title5 = "title6".localized()
    var type1 = "type".localized()
    var typeLabel = "typeLabel".localized()
    var amount1 = "amount".localized()
    var date1 = "date".localized()
    var setDate = "setDate".localized()
    var notes = "notes".localized()
    var notePlaceholder = "notePlaceholder".localized()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }


    // MARK: - Methods
    
    private func initViews() {
        setLangValue()
        addNavBar()
        
        currencyLabel.text = defaults.getCurrency()
        typeSelectorLabel.text = type
        amountTextField.text = amount
        dateInputLabel.text = date
        noteInputValue.text = note
                
        typeSection_BV.applyShadow(cornerRadius: 13.0)
        amountSection_BV.applyShadow(cornerRadius: 13.0)
        dateSection_BV.applyShadow(cornerRadius: 13.0)
        noteSection_BV.applyShadow(cornerRadius: 13.0)
    }
    
    private func setLangValue() {
        type_label.text = type1
        amount_label.text = amount1
        date_label.text = date1
        dateInputLabel.text = setDate
        notes_label.text = notes
    }
    
    private func addNavBar() {
        title = title5
        let ic_back = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: ic_back, style: .plain, target: self, action: #selector(backTapped))
    }
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    

}
