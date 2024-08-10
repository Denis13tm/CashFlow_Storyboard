
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
    let defaults = DefaultsOfUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
 
    // MARK: - Methods
    
    private func initViews() {
        launchingLabel.text = launching

        getPermissonOfNC()
    }
    
    private func getPermissonOfNC() {
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
        defaults.saveLanguage(baseLanguage: "ENG")
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
