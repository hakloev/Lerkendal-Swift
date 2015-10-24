//
//  Stop.swift
//  Lerkendal-Swift
//
//  Created by Håkon Løvdal on 21/10/15.
//  Copyright © 2015 Håkon Løvdal. All rights reserved.
//

import Foundation

class Stop {
    
    var name: String!
    var locationId: String!
    var directionText: String!
    
    init(json: NSDictionary) {
        self.name = json["name"] as! String
        self.locationId = json["locationId"] as!String
        self.directionText = getDirection(self.locationId!)
    }
    
    // The following two functions is stolen from tmn's FuseBus. To be found here: https://github.com/tmn/FuseBus/blob/master/js/Bussholdeplass.js
    private func getDirection(locationId: String) -> String {
        let directionCode = getDirectionCode(locationId)
        switch directionCode {
        case "1": return "til midtbyen"
        case "0":  return "fra midtbyen"
        case "20": return "mot Stjørdal"
        case "83": return "mot Trondheim"
        case "6":  return "mot Klæbu"
        case "7":  return "mot Klæbu"
        case "40": return "vestover"
        case "87": return "østover"
        default: return "..."
        }
    }
    
    private func getDirectionCode(locationId: String) -> String {
        let index = locationId.startIndex.advancedBy(4)
        var endIndex = locationId.startIndex.advancedBy(5)
        
        var directionCode = locationId[Range(start: index, end: endIndex)]
        
        if (directionCode == "1" || directionCode == "0" || directionCode == "6" || directionCode == "7") {
            return directionCode
        }
        
        endIndex = locationId.startIndex.advancedBy(6)
        directionCode = locationId[Range(start: index, end: endIndex)]
        
        if (directionCode == "20" || directionCode == "83" || directionCode == "40" || directionCode == "87") {
            return directionCode
        }
        
        return ""
    }
    
    class func allStops() -> [Stop] {
        var stops = [Stop]()
        if let path = NSBundle.mainBundle().pathForResource("Stops", ofType: "json"), let data = NSData(contentsOfFile: path) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! [Dictionary<String, String>]
                for dict in json {
                    let stop = Stop(json: dict)
                    stops.append(stop)
                }
            } catch {
                print(error)
            }
        }
        return stops
    }
}