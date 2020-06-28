////
//FavoritesQuotesTableViewCell.swift
//QuotesAPI
//
//Created by Basel Baragabah on 26/06/2020.
//Copyright © 2020 Basel Baragabah. All rights reserved.
//

import UIKit

class FavoritesQuotesTableViewCell: UITableViewCell {

    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(favorite: FavoritesQuotes) {
        
        guard let quotes = favorite.en else {return}
        guard let author = favorite.author else {return}

        quoteTextView.text = quotes
        authorLabel.text = author

    }
    
    
}
