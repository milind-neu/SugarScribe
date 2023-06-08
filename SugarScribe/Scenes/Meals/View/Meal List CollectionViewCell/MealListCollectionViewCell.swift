//
//  ContentCollectionViewCell.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import UIKit

final class MealListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRatings: UILabel!
    
    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        self.imgBackground.image = nil;
    }
    
    // MARK: - Cell Configuration
    func configure(meal: Meal? = nil) {
        if let content = meal {
            self.lblTitle.text = content.name ?? ""
            
            self.imgBackground.downloadImageWithCaching(with: content.thumbnail ?? "", placeholderImage: UIImage())
        }
    }
}
