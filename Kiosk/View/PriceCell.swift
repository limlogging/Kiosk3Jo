//
//  PriceCell.swift
//  Kiosk
//
//  Created by Dongik Song on 4/1/24.
//

import UIKit

class PriceCell: UITableViewCell {


    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var plusBtn: UIButton!
    
    @IBOutlet weak var minusBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImage.image = nil
        titleLabel.text = ""
        priceLabel.text = ""
        valueLabel.text = "1"
    }
}
