//
//  StationsListViewController.swift
//  MRT_Ver_04
//
//  Created by 陳紹軒 on 2016/5/18.
//  Copyright © 2016年 tw.edu.nccu. All rights reserved.
//

import UIKit
import ObjectMapper

class StationsListViewController: UITableViewController {

    var MRTstations : [Station]!
    var lines       : [Line]!
    var lineDict    : [String: [Station]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path : String = NSBundle.mainBundle().pathForResource("MRT", ofType: "json") as String!
        let jsonData = try! String(contentsOfFile: path) as String!
        
        self.MRTstations = Mapper<Station>().mapArray(jsonData)!
        
        for station in MRTstations {
            for lineName in station.lines.keys {
                if (self.lineDict[lineName] == nil) {
                    self.lineDict[lineName] = []
                }
                self.lineDict[lineName]!.append(station)
            }
        }
        self.lines = []
        
        for (lineName, stations) in lineDict {
            self.lines.append(Line(name: lineName, stations: stations))
        }

        for index in 0...lines.count-1 {
            let lineName =  lines[index].name
            lines[index].stations = lines[index].stations.sort {
                (stationA: Station, stationB: Station) -> Bool in
                return stationA.lines[lineName] < stationB.lines[lineName]
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.lines.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.lines[section].name
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lines[section].stations.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! StationsListViewCell
        let station = self.lines[indexPath.section].stations[indexPath.row]
        let keys = [String](station.lines.keys)

        cell.stationNameLabel.text = station.name

        if (keys.count == 2) {
            cell.lineLabel_1.alpha              = 1.0
            cell.lineLabel_1.text               = station.lines[keys[0]]
            cell.lineLabel_1.backgroundColor    = colorSelector(keys[0])
            cell.lineLabel_1.textColor          = UIColor.whiteColor()
            cell.lineLabel_2.text               = station.lines[keys[1]]
            cell.lineLabel_2.backgroundColor    = colorSelector(keys[1])
            cell.lineLabel_2.textColor          = UIColor.whiteColor()
        }
        else {
            cell.lineLabel_1.alpha              = 0.0
            cell.lineLabel_2.text               = station.lines[keys[0]]
            cell.lineLabel_2.backgroundColor    = colorSelector(keys[0])
            cell.lineLabel_2.textColor          = UIColor.whiteColor()
        }

        cell.lineLabel_1.layer.masksToBounds = true
        cell.lineLabel_1.layer.cornerRadius  = 3.0
        cell.lineLabel_2.layer.masksToBounds = true
        cell.lineLabel_2.layer.cornerRadius  = 3.0
        
        return cell
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPathForCell(cell)!
            let station = self.lines[indexPath.section].stations[indexPath.row]
            let detailViewController = segue.destinationViewController as! StationViewController

            detailViewController.station = station
        }
    }
}