//
//  LineChartViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev.
//

import UIKit
//import Charts
//import DGCharts

class LineChartViewController: UIViewController {
    
    @IBOutlet weak var subView_BV: UIView!
    
//    lazy var lineChartView: LineChartView = {
//        let chartView = LineChartView()
//        chartView.backgroundColor = .systemGray5
//        return chartView
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }


    // MARK: - Methods
    
    private func initViews() {
        subView_BV.layer.cornerRadius = 13.0
        modifierUI(ui: subView_BV)
        
//        subView_BV.addSubview(lineChartView)
//
//        lineChartView.topAnchor.constraint(equalTo: subView_BV.topAnchor).isActive = true
//        lineChartView.rightAnchor.constraint(equalTo: subView_BV.rightAnchor).isActive = true
//        lineChartView.leftAnchor.constraint(equalTo: subView_BV.leftAnchor).isActive = true
//        lineChartView.bottomAnchor.constraint(equalTo: subView_BV.bottomAnchor).isActive = true
    }
    
    private func modifierUI(ui: UIView) {
        ui.layer.shadowColor = UIColor.black.cgColor
        ui.layer.shadowOpacity = 0.5
        ui.layer.shadowOffset = .zero
        ui.layer.shadowRadius = 5.0
    }


}

