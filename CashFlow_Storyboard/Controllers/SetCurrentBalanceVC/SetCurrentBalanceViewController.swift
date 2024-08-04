//
//  SetCurrentBalanceViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev.

import UIKit

class SetCurrentBalanceViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var title_label: UILabel!
    @IBOutlet var description_label: UILabel!
    
    @IBOutlet var baseCurrency: UILabel!
    @IBOutlet var cashBalance: UITextField!
    @IBOutlet var nextBtnBackgroundView: UIView!
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    var title2 = "title2".localized()
    var description2 = "description2".localized()
    var currencyLabel = "currencyLabel".localized()
    var warningLabel2 = "warningLabel2".localized()
    
    let defaults = DefaultsOfUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        initViews()
    }

    //MARK: - Actions

    @IBAction func NextBtn_Action(_ sender: Any) {
        
        if !cashBalance.text!.isEmpty {
            defaults.saveCashBalance(balance: cashBalance.text!)
            defaults.saveIncome(income: "0")
            defaults.saveExpense(expense: "0")
            callSetOTPScreen()
        } else {
            warningLabel.isHidden = false
        }
        
    }
    
    //MARK: - Methods
    
    private func initViews() {
        setLangValue()
        baseCurrency.text = defaults.getCurrency()
        nextBtnBackgroundView.layer.cornerRadius = 18.0
        modifierUI(ui: nextBtnBackgroundView)
        backgroundView.layer.cornerRadius = 13.0
        
        setUp_texField()
    }
    
    private func setUp_texField() {
        self.cashBalance.delegate = self
        self.cashBalance.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
    }
    
    @objc func changeCharacter() {
        warningLabel.isHidden = true
    }
    
    private func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 10
    }
    
    private func setLangValue() {
        title_label.text = title2
        description_label.text = description2
        baseCurrency.text = currencyLabel
        warningLabel.text = warningLabel2
    }
    
    private func callSetOTPScreen() {
        let vc = SetPasscodeViewController(nibName: "SetPasscodeViewController", bundle: nil)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//End.
}
