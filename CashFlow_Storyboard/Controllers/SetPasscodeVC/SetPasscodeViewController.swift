//
//  SetPasscodeViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev.
//

import UIKit

class SetPasscodeViewController: UIViewController {
    
    @IBOutlet var title_label: UILabel!
    @IBOutlet var headline_label: UILabel!
    @IBOutlet var enter_pw: UILabel!
    @IBOutlet var confirm_pw: UILabel!
    @IBOutlet var description_label: UILabel!
    
    @IBOutlet var newPasscode: UITextField!
    @IBOutlet var confirmedPasscode: UITextField!
    @IBOutlet var warningLabel: UILabel!
    @IBOutlet var nextBtn_Action: UIView!
    @IBOutlet var backgroundView: UIView!
    
    var title3 = "title3".localized()
    var errorLabel = "errorLabel".localized()
    var headline = "headline".localized()
    var enterPassword = "enterPassword".localized()
    var confirmPassword = "confirmPassword".localized()
    var description3 = "description3".localized()
    var digits = "digits".localized()
    
    let defaults = DefaultsOfUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        initViews()
    }
    
    // MARK: - Actions
    
    @IBAction func nextBtnAction(_ sender: Any) {
        saveAndcallOTPScreen()
    }
    
    // MARK: - Methods
    
    private func initViews() {
        setLangValue()
        
        nextBtn_Action.layer.cornerRadius = 18.0
        modifierUI(ui: nextBtn_Action)
        backgroundView.layer.cornerRadius = 13.0
        
        setUp_texField()
    }
    
    private func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 10
    }
    
    private func setLangValue() {
        title_label.text = title3
        description_label.text = description3
        headline_label.text = headline
        enter_pw.text = enterPassword
        confirm_pw.text = confirmPassword
        warningLabel.text = errorLabel
        newPasscode.placeholder = digits
        confirmedPasscode.placeholder = digits
    }
    
    private func setUp_texField() {
        self.newPasscode.delegate = self
        self.confirmedPasscode.delegate = self
    
        self.newPasscode.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
        self.confirmedPasscode.addTarget(self, action: #selector(self.changeCharacter), for: .editingChanged)
    }
    
    @objc func changeCharacter() {
        warningLabel.isHidden = true
    }
    
    private func callOTPScreen() {
        let vc = OTPScreenViewController(nibName: "OTPScreenViewController", bundle: nil)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func saveAndcallOTPScreen() {
        if newPasscode.text?.utf8.count == 4 && confirmedPasscode.text?.utf8.count == 4 {
            if newPasscode.text == confirmedPasscode.text {
                if !newPasscode.text!.isEmpty || !confirmedPasscode.text!.isEmpty {
                    defaults.savePasscode(password: newPasscode.text!)
                    callOTPScreen()
                }
            } else {
                warningLabel.text = "Passwords don't match. Please try again."
                warningLabel.isHidden = false
            }
        } else {
            warningLabel.text = "Please enter only 4 digits password."
            warningLabel.isHidden = false
        }
        
        
    }
  
}
