//
//  LastTransactionTableViewCell.swift
//  CashFlow_Storyboard
//
//  Created by Otabek Tuychiev
//

import UIKit

class LastTransactionTableViewCell: UITableViewCell {
    
   
    @IBOutlet var notes: UILabel!
    @IBOutlet var amout: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var cell_BackgroundView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: - Methods...
    
    private func initViews() {
        cell_BackgroundView.layer.cornerRadius = 13.0
    }
    
}

