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
    @IBOutlet weak var priceLabel: UILabel!
    
    func generateCell(car:CarViewModel) {
        prosListStackView.subviews.forEach({ $0.removeFromSuperview() })
        consListStackView.subviews.forEach({ $0.removeFromSuperview() })
        starStackView.subviews.forEach({ $0.removeFromSuperview() })
        
        carImgView.image = UIImage(named: car.make)
        carTitleLabel.text = car.makeAndModel
        priceLabel.text = car.marketPrice

        for _ in  1...car.rating {
            let itemLbl = UILabel()
            let text = NSMutableAttributedString()
            text.append(NSAttributedString(string: "★",
                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#FC6016"),
                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            itemLbl.attributedText = text
            starStackView.addArrangedSubview(itemLbl)
        }

        if !car.prosList.isEmpty {
            prosLabel.isHidden = false
            prosLabel.text = "Pros:"
            for pro in car.prosList {
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
                prosListStackView.addArrangedSubview(itemLbl)
                }
            }
        }
        if !car.consList.isEmpty {
            consLabel.isHidden = false
            consLabel.text = "Cons:"
            for cons in car.consList {
                if !cons.isEmpty {
                    let itemLbl = UILabel()
                    itemLbl.numberOfLines = 0
                    let text = NSMutableAttributedString()
                    text.append(NSAttributedString(string: "\u{2022} ",
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#FC6016"),
                                                                                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28)]))
                    
                    text.append(NSAttributedString(string: cons,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.black ,NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
                    
                    itemLbl.attributedText = text
                    consListStackView.addArrangedSubview(itemLbl)
                }
            }
        }
       
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
