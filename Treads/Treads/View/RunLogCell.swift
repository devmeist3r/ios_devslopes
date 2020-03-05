//
//  RunLogCell.swift
//  Treads
//
//  Created by Lucas Inocencio on 16/09/18.
//  Copyright © 2018 Lucas Inocencio. All rights reserved.
//

import UIKit

class RunLogCell: UITableViewCell {

    @IBOutlet weak var lbRunDuration: UILabel!
    @IBOutlet weak var lbTotalDistance: UILabel!
    @IBOutlet weak var lbAvaregePace: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(run: Run) {
        lbRunDuration.text = run.duration.formatTimerDurationToString()
        lbTotalDistance.text = "\(run.distance.metersToMiles(places: 2)) mi"
        lbAvaregePace.text = run.pace.formatTimerDurationToString()
        lbDate.text = run.date.getDateString()
    }
    

}
