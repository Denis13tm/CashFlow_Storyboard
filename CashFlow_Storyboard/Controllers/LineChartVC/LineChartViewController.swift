//
//  LineChartViewController.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev.
//

import UIKit
import DGCharts



class LineChartViewController: UIViewController {
    
    
    
    @IBOutlet weak var pieChart: PieChartView!
    
    let coreDB = TransactionService.shared
    
    var allProfits = PieChartDataEntry(value: 0)
    var allExpense = PieChartDataEntry(value: 0)
    
    var profits = [Transaction]()
    var expense = [Transaction]()
    
    var sumOfProfits: Double?
    var sumOfExp: Double?

    var numberOfDataEntry = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }


    // MARK: - Methods
    
    private func initViews() {
        
//        pieChart.layer.cornerRadius = 13.0
//        modifierUI(ui: pieChart)
//
//
//
//        profits = coreDB.fetchIncomeTransactions()
//        let sum = profits.compactMap { Double($0.amount!) }.reduce(0, +)
//        allProfits.label = "Profits"
//        allProfits.value = sum
//
//        expense = coreDB.fetchExpenseTransactions()
//        let sum2 = expense.compactMap { Double($0.amount!) }.reduce(0, +)
//        allExpense.label = "Expense"
//        allProfits.value = sum2
//
//
//        numberOfDataEntry = [allProfits, allExpense]
//
//        updateChartData()
        
    }
    
//    private func updateChartData() {
//        let chartDataSet  = PieChartDataSet(entries: numberOfDataEntry, label: "")
//        let chartData = PieChartData(dataSet: chartDataSet)
//        let colors = [UIColor(named: "profitColor"), UIColor(named: "expColor")]
////        chartDataSet.colors = colors as! [NSUIColor]
//        pieChart.data = chartData
//    }
    
//    private func modifierUI(ui: UIView) {
//        ui.layer.shadowColor = UIColor.black.cgColor
//        ui.layer.shadowOpacity = 0.5
//        ui.layer.shadowOffset = .zero
//        ui.layer.shadowRadius = 5.0
//    }
    
    

}

