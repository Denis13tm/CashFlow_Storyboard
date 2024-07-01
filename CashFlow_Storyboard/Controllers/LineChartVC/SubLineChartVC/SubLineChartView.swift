//
//  SubLineChartView.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev
//

import Foundation
import Charts
import SwiftUI

struct SavingsHistory: View {
    
    let coreDB = TransactionService.shared
    var allTransactions = [Transaction]()
    init(allTransactions: [Transaction] = [Transaction]()) {
        self.allTransactions = coreDB.fetchTransactions()
    }
    var body: some View {
        
        
        if #available(iOS 16.0, *) {
            Chart(allTransactions) { savingModel in
//                AreaMark(
//                    x: .value("Month", savingModel.date ?? ""),
//                    yStart: .value("Dollar", savingModel.amount),
//                    yEnd: .value("minValue", 0)
//                )
//                .interpolationMethod(.cardinal)
//                .foregroundStyle(.blue.opacity(0.9))
                
                LineMark(
                    x: .value("Month", savingModel.date ?? ""),
                    y: .value("Dollar", savingModel.amount ?? "")
                )
                .interpolationMethod(.cardinal)
                .foregroundStyle(.red)
                
                PointMark(
                    x: .value("Month", savingModel.date ?? ""),
                    y: .value("Dollar", savingModel.amount ?? "")
                )
                .foregroundStyle(.red.opacity(0.9))
                
                
            }.chartYAxis {
                AxisMarks(position: .leading)
            }
        } else {
            Text("Please Update your iPhone's iOS version!")
        }
    }
    
    
}
