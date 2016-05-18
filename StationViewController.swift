//
//  StationViewController.swift
//  MRT_Ver_04
//
//  Created by 陳紹軒 on 2016/5/18.
//  Copyright © 2016年 tw.edu.nccu. All rights reserved.
//

import UIKit

class StationViewController: UIViewController {
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var lineLabel_1: UILabel!
    @IBOutlet weak var lineLabel_2: UILabel!

    var station: Station? {
        willSet(newStation) {}
        didSet(newStation) {
            if self.isViewLoaded() {
                self.fillData()
            }
        }
    }
    
    func fillData() {
        guard let station = self.station else {
            return
        }
        self.stationNameLabel.text = station.name
        self.title = station.name
        
        let keys = [String](station.lines.keys)
        
        if (keys.count == 2) {
            self.lineLabel_1.hidden             = false
            self.lineLabel_1.text               = keys[0]
            self.lineLabel_1.backgroundColor    = colorSelector(keys[0])
            self.lineLabel_1.textColor          = UIColor.whiteColor()
            self.lineLabel_2.text               = keys[1]
            self.lineLabel_2.backgroundColor    = colorSelector(keys[1])
            self.lineLabel_2.textColor          = UIColor.whiteColor()
        }
        else {
            self.lineLabel_1.hidden             = true
            self.lineLabel_2.text               = keys[0]
            self.lineLabel_2.backgroundColor    = colorSelector(keys[0])
            self.lineLabel_2.textColor          = UIColor.whiteColor()
        }
    }
    
    func colorSelector (lineName: String) -> UIColor {
        switch lineName {
        case "文湖線":
            return UIColor(red: 158.0/255.0, green: 101.0/255.0, blue: 46.0/255.0,  alpha: 1.0)
        case "淡水信義線":
            return UIColor(red: 203.0/255.0, green: 44.0/255.0,  blue: 48.0/255.0,  alpha: 1.0)
        case "新北投支線":
            return UIColor(red: 248.0/255.0, green: 144.0/255.0, blue: 165.0/255.0, alpha: 1.0)
        case "松山新店線":
            return UIColor(red: 0.0/255.0,   green: 119.0/255.0, blue: 73.0/255.0,  alpha: 1.0)
        case "小碧潭支線":
            return UIColor(red: 206.0/255.0, green: 220.0/255.0, blue: 0.0,         alpha: 1.0)
        case "中和新蘆線":
            return UIColor(red: 255.0/255.0, green: 163.0/255.0, blue: 0.0,         alpha: 1.0)
        case "板南線":
            return UIColor(red: 0.0,         green: 94.0/255.0,  blue: 184.0/255.0, alpha: 1.0)
        case "貓空纜車":
            return UIColor(red: 119.0/255.0, green: 185.0/255.0, blue: 51.0/255.0,  alpha: 1.0)
        default:
            return UIColor.blackColor()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
