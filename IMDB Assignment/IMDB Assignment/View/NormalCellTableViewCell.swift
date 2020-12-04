//
//  NormalCellTableViewCell.swift
//  IMDB Assignment
//
//  Created by sai krishna reddy avuthu on 11/22/20.
//

import UIKit

class NormalCellTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
