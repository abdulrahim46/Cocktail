//
//  DrinkCollectionViewCell.swift
//  Cocktail
//
//  Created by Abdul Rahim on 09/11/21.
//

import UIKit

class DrinkCollectionViewCell: UICollectionViewCell {

    //MARK:- Properties & Views
    
    static let identifier = "DrinkCollectionViewCell"
    
    @IBOutlet weak var drinkImageVIew: UIImageView!
    
    @IBOutlet weak var drinkNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .brown
    }

}
