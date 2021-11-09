//
//  StaticCollectionViewCell.swift
//  Cocktail
//
//  Created by Abdul Rahim on 09/11/21.
//

import UIKit

class StaticCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "StaticCollectionViewCell"

    @IBOutlet weak var staticImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        staticImageView.layer.cornerRadius = 8
        staticImageView.clipsToBounds = true
        staticImageView.contentMode = .scaleAspectFill
    }

}
