//
//  StopDetails.swift
//  Lerkendal-Swift
//
//  Created by Håkon Løvdal on 21/10/15.
//  Copyright © 2015 Håkon Løvdal. All rights reserved.
//

import Foundation

class StopDetails {
    
    var route: String!
    var destination: String!
    var realTime: Int!
    var departure: String!
    
    init(json: NSDictionary) {
        self.route = json["l"] as! String
        self.destination = json["d"] as! String
        self.realTime = json["rt"] as! Int
        
        if self.realTime! == 1 {
            self.departure = sliceDeparture(json["t"] as! String)
        } else {
            self.departure = sliceDeparture(json["ts"] as! String)
        }
    }
    
    private func sliceDeparture(departure: String) -> String {
        return departure.substringFromIndex(departure.startIndex.advancedBy(11))
    }
    
}
