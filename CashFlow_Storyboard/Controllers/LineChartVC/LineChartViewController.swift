//
//  LineChartViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev.
//

import UIKit
import SwiftUI
import SnapKit

class LineChartViewController: UIViewController {
    
    @IBOutlet weak var subView_BV: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }


    // MARK: - Methods
    
    private func initViews() {
        subView_BV.layer.cornerRadius = 13.0
        modifierUI(ui: subView_BV)
        subView_BV.isHidden = true
        
        let controller = UIHostingController(rootView: SavingsHistory())
        guard let savingsView = controller.view else {
            return
        }
        
        view.addSubview(savingsView)
        
        savingsView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(500)
        }
    }
    
    private func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5.0
    }


}

