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
    @IBOutlet var uzbek: UILabel!
    
    
    @IBOutlet var languageRange_BV: UIView!
    @IBOutlet var eng_BV: UIView!
    @IBOutlet var kor_BV: UIView!
    @IBOutlet var uz_BV: UIView!
    
    let defaults = DefaultsOfUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        let blur = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blur)
        view.addSubview(visualEffectView)
    }
    
    //MARK: - Actions
    
    @IBAction func closeViewBtn_Action(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Methods
    
    private func initViews() {
        setupLabelTap()
        languageRange_BV.layer.cornerRadius = 13.0
        modifierUI(ui: languageRange_BV)
        eng_BV.layer.cornerRadius = 18.0
        kor_BV.layer.cornerRadius = 18.0
        uz_BV.layer.cornerRadius = 18.0
    }
    
    private func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5.0
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
        _UZB_Tapped()
        }

    
    private func _ENG_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.engTapped))
        self.english.isUserInteractionEnabled = true
        self.english.addGestureRecognizer(labelTap)
        }

    @objc func engTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveLanguage(baseLanguage: "ENG")
        Bundle.setLanguage(lang: "en")
        callHomeScreen()
    }
    
    private func _KOR_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.korTapped))
        self.korean.isUserInteractionEnabled = true
        self.korean.addGestureRecognizer(labelTap)
        }

    @objc func korTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveLanguage(baseLanguage: "한국어")
        Bundle.setLanguage(lang: "ko")
        callHomeScreen()
    }
    
    private func _UZB_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.uzbTapped))
        self.uzbek.isUserInteractionEnabled = true
        self.uzbek.addGestureRecognizer(labelTap)
        }

    @objc func uzbTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveLanguage(baseLanguage: "RU")
        Bundle.setLanguage(lang: "ru")
        callHomeScreen()
    }

}
