//
//  PlanetTableViewCell.swift
//  Planets
//
//  Created by Esraa Mohamed Ragab on 23/11/2021.
//

import UIKit

class PlanetTableViewCell: UITableViewCell, PlanetCellView {

    @IBOutlet weak var planetTitleLabel: UILabel!

    func display(title: String) {
        planetTitleLabel.text = title
    }

}
