//
//  IngredientTableViewCell.swift
//  SugarScribe
//
//  Created by Milind Sharma on 07/06/23.
//

import UIKit

final class IngredientTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var lblSrNo: UILabel!
    @IBOutlet weak var lblIngredient: UILabel!
    @IBOutlet weak var lblMeasurement: UILabel!
    
    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Cell Configuration
    func configure(srNo: Int, ingredient: String, measurement: String) {
        self.lblSrNo.text = "\(srNo)."
        self.lblIngredient.text = "\(measurement) \(ingredient.capitalized)"
        self.lblMeasurement.text = ""
    }
    
}
