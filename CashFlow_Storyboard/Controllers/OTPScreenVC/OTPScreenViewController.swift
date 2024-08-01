//
//  OTPScreenViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev
//

import UIKit

class OTPScreenViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var tf4: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.hideKeyboardWhenTappedAround()
        initViews()
        warningLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tf1.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction func btnTapped(_ sender: UIButton) {
        guard let digit = sender.title(for: .normal) else { return }
        addDigitToCurrentTextField(digit)
    }
    
    @IBAction func deleteBtn_Tapped(_ sender: Any) {
        deleteLastDigit()
    }
    
    // MARK: - Helper Methods
    
    private func initViews() {
        tf1.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        tf2.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        tf3.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        tf4.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func textDidChange(_ textField: UITextField) {
            let text = textField.text ?? ""
            if text.count == 1 {
                switch textField {
                case tf1:
                    tf2.becomeFirstResponder()
                case tf2:
                    tf3.becomeFirstResponder()
                case tf3:
                    tf4.becomeFirstResponder()
                case tf4:
                    tf4.resignFirstResponder()
                    validateOTP()
                default:
                    break
                }
            }
        }
    
    private func callHomeScreen() {
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func validateOTP() {
            let enteredOTP = (tf1.text ?? "") + (tf2.text ?? "") + (tf3.text ?? "") + (tf4.text ?? "")
            let storedPasscode = UserDefaults.standard.string(forKey: "passcode") ?? ""
            if enteredOTP == storedPasscode {
                showWarning(message: "OTP matched!", isError: false)
                callHomeScreen()
            } else {
                showWarning(message: "OTP did not match.", isError: true)
                print("PW: \(storedPasscode)")
            }
        }
    
    private func showWarning(message: String, isError: Bool) {
            warningLabel.text = message
            warningLabel.textColor = isError ? .red : .green
            warningLabel.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.warningLabel.isHidden = true
            }
        }
    
    private func addDigitToCurrentTextField(_ digit: String) {
            if tf1.isFirstResponder {
                tf1.text = digit
                tf2.becomeFirstResponder()
            } else if tf2.isFirstResponder {
                tf2.text = digit
                tf3.becomeFirstResponder()
            } else if tf3.isFirstResponder {
                tf3.text = digit
                tf4.becomeFirstResponder()
            } else if tf4.isFirstResponder {
                tf4.text = digit
                tf4.resignFirstResponder()
                validateOTP()
            }
        }
    
    private func deleteLastDigit() {
            if tf4.isFirstResponder && !tf4.text!.isEmpty {
                tf4.text = ""
            } else if tf3.isFirstResponder && !tf3.text!.isEmpty {
                tf3.text = ""
            } else if tf2.isFirstResponder && !tf2.text!.isEmpty {
                tf2.text = ""
            } else if tf1.isFirstResponder && !tf1.text!.isEmpty {
                tf1.text = ""
            } else {
                if tf4.isFirstResponder {
                    tf3.becomeFirstResponder()
                    tf4.text = ""
                } else if tf3.isFirstResponder {
                    tf2.becomeFirstResponder()
                    tf3.text = ""
                } else if tf2.isFirstResponder {
                    tf1.becomeFirstResponder()
                    tf2.text = ""
                }
            }
        }
  //End
}
