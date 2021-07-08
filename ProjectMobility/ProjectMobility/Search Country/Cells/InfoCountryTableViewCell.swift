//
//  InfoCountryTableViewCell.swift
//  ProjectMobility
//
//  Created by Camilo Betancourt on 17/06/21.
//

import UIKit

class InfoCountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var goTextLabel: UILabel!
    @IBOutlet weak var countrylabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    func config(country: Country) {
        cellView.layer.cornerRadius = 20
        cellView.layer.shadowRadius = 4
        cellView.layer.shadowColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        cellView.layer.shadowOpacity = 20
        
        countrylabel.text = country.name
        capitalLabel.text = country.capital
        regionLabel.text = country.region
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
