
//  LaunchViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev
//

import UIKit

class LaunchViewController: UIViewController {
    
    @IBOutlet weak var launchingLabel: UILabel!
    
    var launching = "launching".localized()
    public let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }


 
    // MARK: - Methods...
    
    func initViews() {
        launchingLabel.text = launching

        getPermissonOfNC()
    }
    
    func getPermissonOfNC() {
       let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { [self] (granted, error)in
           
           DispatchQueue.main.async { [self] in
               
               let language = userDefaults.string(forKey: "language")
               let cashBalance = userDefaults.string(forKey: "cashBalance")
               let baseCurrency = userDefaults.string(forKey: "currency")
               let passcode = userDefaults.string(forKey: "passcode")
               
               if language != nil && language != "" {
                   if baseCurrency != nil && baseCurrency != "" {
                       if cashBalance != nil && cashBalance != "" {
                           if passcode != nil && passcode != "" {
                               callOTPScreen()
                           } else {
                               callSetOTPScreen()
                           }
//                           callHomeScreen()
                       } else {
                           callCurrentBalanceScreen()
                       }
                   } else {
                       callBaseCurrencyScreen()
                   }
               } else {
                   callSetLanguageScreen()
               }
           }
           
       }
   }
    
    
    private func callHomeScreen() {
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
//        self.present(nv, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func callOTPScreen() {
        let vc = OTPScreenViewController(nibName: "OTPScreenViewController", bundle: nil)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func callSetLanguageScreen() {
        let vc = SetLanguageViewController(nibName: "SetLanguageViewController", bundle: nil)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func callBaseCurrencyScreen() {
        let vc = SetBaseCurrencyViewController(nibName: "SetBaseCurrencyViewController", bundle: nil)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func callCurrentBalanceScreen() {
        let vc = SetCurrentBalanceViewController(nibName: "SetCurrentBalanceViewController", bundle: nil)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func callSetOTPScreen() {
        let vc = SetPasscodeViewController(nibName: "SetPasscodeViewController", bundle: nil)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

//End.
}

// Put this piece of code anywhere you like to hide default keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
