//
//  CarTableViewCell.swift
//  Guidomia
//
//  Created by Razieh Halimi on 2022-08-31.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var consLabel: UILabel!
    @IBOutlet weak var prosLabel: UILabel!
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var prosItemStackView: UIStackView!
    @IBOutlet weak var consItemStackView: UIStackView!
    @IBOutlet weak var consListStackView: UIStackView!
    @IBOutlet weak var prosListStackView: UIStackView!
    @IBOutlet weak var carImgView: UIImageView!
    @IBOutlet weak var carTitleLabel: UILabel!
    @IBOutlet weak var priceMarketLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    
    func generateCell(car:CarViewModel) {
        if getdeviceSize() == .small {
            self.carTitleLabel.font = .boldSystemFont(ofSize: 14)
            self.priceMarketLabel.font = .boldSystemFont(ofSize: 12)
            self.priceLabel.font = .boldSystemFont(ofSize: 12)
            self.prosLabel.font = .boldSystemFont(ofSize: 14)
            self.consLabel.font = .boldSystemFont(ofSize: 14)
        }
        
        self.carImgView.image = UIImage(named: car.make)
        self.carTitleLabel.text = car.makeAndModel
        self.priceMarketLabel.text = car.marketPrice
        self.makeStar(rate: car.rating)
        self.makeProsAndCons(pros: car.prosList, cons: car.consList)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectedBackgroundView?.backgroundColor = UIColor(hexString: "#D5D5D5")
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension CarTableViewCell {
    private func makeStar(rate: Int) {
        self.starStackView.subviews.forEach({ $0.removeFromSuperview() })
        for _ in  1...rate {
            let itemLbl = UILabel()
            let text = NSMutableAttributedString()
            text.append(NSAttributedString(string: "★",
                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#FC6016"),
                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            itemLbl.attributedText = text
            self.starStackView.addArrangedSubview(itemLbl)
        }
    }
    
    private func makeProsAndCons(pros: [String], cons: [String]) {
        self.prosListStackView.subviews.forEach({ $0.removeFromSuperview() })
        self.consListStackView.subviews.forEach({ $0.removeFromSuperview() })
        if !pros.isEmpty {
            self.prosLabel.isHidden = false
            self.prosLabel.text = "Pros:"
            for pro in pros {
                if !pro.isEmpty {
                let itemLbl = UILabel()
                itemLbl.numberOfLines = 0
                let text = NSMutableAttributedString()
                text.append(NSAttributedString(string: "\u{2022} ",
                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#FC6016"),
                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28)]))

                    text.append(NSAttributedString(string: pro,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.black ,NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
                itemLbl.attributedText = text
                    self.prosListStackView.addArrangedSubview(itemLbl)
                }
            }
        }
        if !cons.isEmpty {
            self.consLabel.isHidden = false
            self.consLabel.text = "Cons:"
            for con in cons {
                if !con.isEmpty {
                    let itemLbl = UILabel()
                    itemLbl.numberOfLines = 0
                    let text = NSMutableAttributedString()
                    text.append(NSAttributedString(string: "\u{2022} ",
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#FC6016"),
                                                                                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28)]))
                    
                    text.append(NSAttributedString(string: con,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.black ,NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
                    
                    itemLbl.attributedText = text
                    self.consListStackView.addArrangedSubview(itemLbl)
                }
            }
        }
        
    }
    
}
