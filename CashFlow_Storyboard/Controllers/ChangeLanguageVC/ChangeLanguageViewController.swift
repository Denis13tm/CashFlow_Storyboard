//
//  ChangeLanguageViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev.
//

import UIKit

class ChangeLanguageViewController: UIViewController {
    
    @IBOutlet var english: UILabel!
    @IBOutlet var korean: UILabel!
    @IBOutlet var russian: UILabel!
    
    @IBOutlet var languageRange_BV: UIView!
    @IBOutlet var eng_BV: UIView!
    @IBOutlet var kor_BV: UIView!
    @IBOutlet var rus_BV: UIView!
    
    let defaults = DefaultsOfUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    //MARK: - Actions
    
    @IBAction func closeViewBtn_Action(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
    
    private func initViews() {
        setupLabelTap()
        languageRange_BV.applyShadow(cornerRadius: 13.0)
        eng_BV.applyShadow(cornerRadius: 18.0)
        kor_BV.applyShadow(cornerRadius: 18.0)
        rus_BV.applyShadow(cornerRadius: 18.0)
    }
    
    private func callHomeScreen() {
        let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let nv = UINavigationController(rootViewController: vc)
        nv.modalPresentationStyle = .fullScreen
        self.present(nv, animated: true, completion: nil)
    }
    
    
    private func setupLabelTap() {
        _ENG_Tapped()
        _KOR_Tapped()
        _RUS_Tapped()
        }

    
    private func _ENG_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.engTapped))
        self.english.isUserInteractionEnabled = true
        self.english.addGestureRecognizer(labelTap)
        }

    @objc func engTapped(_ sender: UITapGestureRecognizer) {
        let newLanguage = "ENG"
        let newLanguageText = "English"
        let currentLanguage = defaults.getLanguage()
        
        if currentLanguage != newLanguage {
            defaults.saveLanguage(baseLanguage: newLanguage)
            english.text = newLanguageText
            Bundle.setLanguage(lang: "en")
            callHomeScreen()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func _KOR_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.korTapped))
        self.korean.isUserInteractionEnabled = true
        self.korean.addGestureRecognizer(labelTap)
        }

    @objc func korTapped(_ sender: UITapGestureRecognizer) {
        let newLanguage = "한"
        let newLanguageText = "한국어"
        let currentLanguage = defaults.getLanguage()
        
        if currentLanguage != newLanguage {
            defaults.saveLanguage(baseLanguage: newLanguage)
            korean.text = newLanguageText
            Bundle.setLanguage(lang: "ko")
            callHomeScreen()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func _RUS_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.rusTapped))
        self.russian.isUserInteractionEnabled = true
        self.russian.addGestureRecognizer(labelTap)
        }

    @objc func rusTapped(_ sender: UITapGestureRecognizer) {
        let newLanguage = "RU"
        let newLanguageText = "Русский"
        let currentLanguage = defaults.getLanguage()

        if currentLanguage != newLanguage {
            defaults.saveLanguage(baseLanguage: newLanguage)
            russian.text = newLanguageText
            Bundle.setLanguage(lang: "ru")
            callHomeScreen()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
