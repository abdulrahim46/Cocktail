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
        setupView()
    }
    
    func setupView() {
        drinkImageVIew.layer.cornerRadius = 8
        drinkImageVIew.clipsToBounds = true
        drinkImageVIew.contentMode = .scaleAspectFill
    }
    
    /// configure cell here
    func configure(with drink: Drinks) {
        drinkNameLabel.text = drink.drink
        //subtitle.text = article.description
        //authorLabel.text = article.author
        if let imageData = drink.image {
//            drinkImageVIew.sd_setImage(with: URL(string: imageData),
//                                  placeholderImage: UIImage(named: "placeholder"),
//                                  options: .continueInBackground,
//                                  completed: nil)
        }
    }

}
