//
//  TradeDataCell.swift
//

import UIKit
import SwiftyJSON

class TradeDataCell: UITableViewCell {
    
    @IBOutlet weak var pairLabel: UILabel!
    @IBOutlet weak var setupLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var tradeData : JSON? {
        didSet {
            guard let data = self.tradeData else {
                return
            }
            
            let pair = data["pair"].stringValue
            self.pairLabel.text = pair
            let drawdown = data["drawdown"].doubleValue
            /*if drawdown <= 2.0 {
                self.setupLabel.textColor = .black
                self.setupLabel.text = "Average"
            } else if drawdown > 2.0 && drawdown <= 5.0 {
                self.setupLabel.textColor = .orange
                self.setupLabel.text = "Great"
            } else {
                self.setupLabel.textColor = #colorLiteral(red: 0.05490196078, green: 0.5019607843, blue: 0.2156862745, alpha: 1)
                self.setupLabel.text = "Perfect"
            }*/
            self.setupLabel.text = String(format: "%.2f", drawdown) + "%"
            
            let level = data["level"].stringValue
            self.levelLabel.text = level
        }
    }
}
