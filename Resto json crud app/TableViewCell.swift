//
//  TableViewCell.swift
//  Resto json crud app
//
//  Created by hint on 21/08/18.
//  Copyright © 2018 ZidniRyi. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var imageMenu: UIImageView!
    @IBOutlet weak var lblHarga: UILabel!
    @IBOutlet weak var lblNama: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
