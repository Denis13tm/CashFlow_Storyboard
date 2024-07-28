//
//  SubChartView.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev.
//

import SwiftUI
import Charts

struct SubChartView: View {

    var allTransactions = [Transaction]()
    
        var body: some View {
            if #available(iOS 16.0, *) {
                Chart {
                    ForEach(allTransactions) { item in
                        BarMark(
                            x: .value("Value", item.amount ?? "0"),
                            y: .value("Month", item.date ?? "0")
                        )
                        
                    }
                }
                .aspectRatio(contentMode: .fit)
                .padding()
            } else {
                // Fallback on earlier versions
            }
        }
}


struct SubChartView_Previews: PreviewProvider {
    static var previews: some View {
        SubChartView()
    }
}
