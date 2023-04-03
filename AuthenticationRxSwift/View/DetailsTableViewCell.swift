//
//  DetailsTableViewCell.swift
//  AuthenticationRxSwift
//
//  Created by Chandrasheela Hotkar on 24/03/23.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
