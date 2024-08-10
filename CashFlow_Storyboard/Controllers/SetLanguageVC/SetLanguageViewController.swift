//
//  SetLanguageViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev.
//

import UIKit

class SetLanguageViewController: UIViewController {
    
    @IBOutlet var title_label: UILabel!
    @IBOutlet var description_label: UILabel!
    
    @IBOutlet var baseLanguage_BV: UIView!
    @IBOutlet var bakgroundView: UIView!
    @IBOutlet var baseLanguage_: UILabel!
    @IBOutlet var languageRange: UIView!
    @IBOutlet var rangeBackground: UIStackView!
    @IBOutlet var nextBtn_BV: UIView!
    
    
    @IBOutlet var _ENG: UILabel!
    @IBOutlet var _KOR: UILabel!
    @IBOutlet var _RUS: UILabel!
    
    
    var title0 = "title0".localized()
    var description0 = "description0".localized()
    var langLabel = "LangLabel".localized()
    
    let defaults = DefaultsOfUser()
    let notificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    // MARK: - Actions
    
    @IBAction func nextBtn_Action(_ sender: Any) {
        defaults.saveLanguage(baseLanguage: baseLanguage_.text!)
        callBaseCurrencyScreen()
    }
    
    // MARK: - Methods
    
    private func initViews() {
        setLangValue()
        setupLabelTap()
        baseLanguage_BV.applyCornerRadius(13.0)
        rangeBackground.applyShadow(cornerRadius: 13.0)
        languageRange.applyCornerRadius(13.0)
        bakgroundView.applyCornerRadius(13.0)
        baseLanguage_.applyCornerRadius(13.0)
        nextBtn_BV.applyShadow(cornerRadius: 13.0)
    }
    
    private func callBaseCurrencyScreen() {
        let vc = SetBaseCurrencyViewController(nibName: "SetBaseCurrencyViewController", bundle: nil)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func callSetLanguageScreen() {
        let vc = SetLanguageViewController(nibName: "SetLanguageViewController", bundle: nil)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setLangValue() {
        title_label.text = title0
        description_label.text = description0
        baseLanguage_.text = langLabel
    }
    
    func setupLabelTap() {

        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped))
        self.baseLanguage_.isUserInteractionEnabled = true
        self.baseLanguage_.addGestureRecognizer(labelTap)
    }

    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        languageRange.isHidden.toggle()
        _ENG_Tapped()
        _KOR_Tapped()
        _RUS_Tapped()
    }
    
    func _ENG_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.engTapped))
        self._ENG.isUserInteractionEnabled = true
        self._ENG.addGestureRecognizer(labelTap)
    }

    @objc func engTapped(_ sender: UITapGestureRecognizer) {
        let newLanguage = "ENG"
        let newLanguageText = "English"
        let currentLanguage = defaults.getLanguage()
        
        if currentLanguage != newLanguage {
            defaults.saveLanguage(baseLanguage: newLanguage)
            baseLanguage_.text = newLanguageText
            Bundle.setLanguage(lang: "en")
            languageRange.isHidden.toggle()
            callSetLanguageScreen()
        }
        languageRange.isHidden.toggle()
    }
    
    func _KOR_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.korTapped))
        self._KOR.isUserInteractionEnabled = true
        self._KOR.addGestureRecognizer(labelTap)
        }

    @objc func korTapped(_ sender: UITapGestureRecognizer) {
        let newLanguage = "한"
        let newLanguageText = "한국어"
        let currentLanguage = defaults.getLanguage()

        if currentLanguage != newLanguage {
            defaults.saveLanguage(baseLanguage: newLanguage)
            baseLanguage_.text = newLanguageText
            Bundle.setLanguage(lang: "ko")
            callSetLanguageScreen()
        }
        languageRange.isHidden.toggle()
        
    }
    
    func _RUS_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.rusTapped))
        self._RUS.isUserInteractionEnabled = true
        self._RUS.addGestureRecognizer(labelTap)
        }

    @objc func rusTapped(_ sender: UITapGestureRecognizer) {
        let newLanguage = "RU"
        let newLanguageText = "русский"
        let currentLanguage = defaults.getLanguage()

        if currentLanguage != newLanguage {
            defaults.saveLanguage(baseLanguage: newLanguage)
            baseLanguage_.text = newLanguageText
            Bundle.setLanguage(lang: "ru")
            callSetLanguageScreen()
        }
        
        languageRange.isHidden.toggle()
    }

}
