//
//  StationsListViewCell.swift
//  MRT_Ver_04
//
//  Created by 陳紹軒 on 2016/5/18.
//  Copyright © 2016年 tw.edu.nccu. All rights reserved.
//

import UIKit

class StationsListViewCell: UITableViewCell {

    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var lineLabel_1: UILabel!
    @IBOutlet weak var lineLabel_2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
