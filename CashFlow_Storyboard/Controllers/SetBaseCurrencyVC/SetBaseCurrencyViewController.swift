//
//  SetBaseCurrencyViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev.
//

import UIKit

class SetBaseCurrencyViewController: UIViewController {
    
    @IBOutlet var title_label: UILabel!
    @IBOutlet var description_label: UILabel!
    
    @IBOutlet var baseCurrency_BV: UIView!
    @IBOutlet var baseCurrency_: UILabel!
    @IBOutlet var nextBtnBackgroundView: UIView!
    @IBOutlet var bakgroundView: UIView!

    @IBOutlet var currencyRange: UIView!
    
    @IBOutlet var _USD: UILabel!
    @IBOutlet var _WON: UILabel!
    @IBOutlet var _UZD: UILabel!
    
    @IBOutlet var rangeBackground: UIStackView!
    
    
    var title1 = "title1".localized()
    var description1 = "description1".localized()
    var currencyLabel = "currencyLabel".localized()
    var usd = "USD".localized()
    var won = "KRW".localized()
    var uzs = "UZS".localized()
    
    let defaults = DefaultsOfUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    //MARK: - Actions

    @IBAction func nextBtn_Action(_ sender: Any) {
        defaults.saveCurrency(baseCurrency: baseCurrency_.text!)
        callCurrentBalanceScreen()
    }
   
    //MARK: - Methods...
    
    func initViews() {
        setLangValue()
        setupLabelTap()
        
        baseCurrency_BV.applyCornerRadius(13.0)
        rangeBackground.applyShadow(cornerRadius: 13.0)
        currencyRange.applyCornerRadius(13.0)
        bakgroundView.applyCornerRadius(13.0)
        baseCurrency_.applyCornerRadius(13.0)
        nextBtnBackgroundView.applyShadow(cornerRadius: 18.0)
    }
    
    func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 10
    }
    
    func setLangValue() {
        title_label.text = title1
        description_label.text = description1
        baseCurrency_.text = currencyLabel
        _USD.text = usd
        _WON.text = won
        _UZD.text = uzs
    }
    
    func setupLabelTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped))
        self.baseCurrency_.isUserInteractionEnabled = true
        self.baseCurrency_.addGestureRecognizer(labelTap)
        }

    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        currencyRange.isHidden.toggle()
        _USD_Tapped()
        _WON_Tapped()
        _UZD_Tapped()
    }
    

    
    func _USD_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.USDTapped))
        self._USD.isUserInteractionEnabled = true
        self._USD.addGestureRecognizer(labelTap)
        }

    @objc func USDTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveCurrency(baseCurrency: _USD.text!)
        baseCurrency_.text = _USD.text
        currencyRange.isHidden.toggle()
    }
    
    func _WON_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.WONTapped))
        self._WON.isUserInteractionEnabled = true
        self._WON.addGestureRecognizer(labelTap)
        }

    @objc func WONTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveCurrency(baseCurrency: _WON.text!)
        baseCurrency_.text = _WON.text
        currencyRange.isHidden.toggle()
    }
    
    func _UZD_Tapped() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.UZDTapped))
        self._UZD.isUserInteractionEnabled = true
        self._UZD.addGestureRecognizer(labelTap)
        }

    @objc func UZDTapped(_ sender: UITapGestureRecognizer) {
        defaults.saveCurrency(baseCurrency: _UZD.text!)
        baseCurrency_.text = _UZD.text
        currencyRange.isHidden.toggle()
    }
    
    
    private func callCurrentBalanceScreen() {
        let vc = SetCurrentBalanceViewController(nibName: "SetCurrentBalanceViewController", bundle: nil)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
