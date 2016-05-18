//
//  StationsData.swift
//  MRT_Ver_04
//
//  Created by 陳紹軒 on 2016/5/18.
//  Copyright © 2016年 tw.edu.nccu. All rights reserved.
//

import Foundation
import ObjectMapper

struct Station {
    var name : String!
    var coordinate: (x: Double, y: Double)!
    var lines: [String: String]!
}

struct Line {
    var name: String
    var stations: [Station]
}

extension Station: Mappable {
    init?(_ map: Map) {}
    mutating func mapping(map: Map) {
        self.name       <- map["name"]
        self.coordinate <- map["coordinate"]
        self.lines      <- map["lines"]
    }
}