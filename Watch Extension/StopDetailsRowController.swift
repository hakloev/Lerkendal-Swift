//
//  StopDetailsRowController.swift
//  Lerkendal-Swift
//
//  Created by Håkon Løvdal on 21/10/15.
//  Copyright © 2015 Håkon Løvdal. All rights reserved.
//

import Foundation
import WatchKit

class StopDetailsRowController: NSObject {
    
    @IBOutlet var route: WKInterfaceLabel!
    @IBOutlet var destination: WKInterfaceLabel!
    @IBOutlet var realTime: WKInterfaceLabel!
    @IBOutlet var departure: WKInterfaceLabel!
    
    var stopDetails: StopDetails? {
        
        didSet {
            if let stopDetails = stopDetails {
                route.setText("\(stopDetails.route)")
                destination.setText(stopDetails.destination)
                if stopDetails.realTime == 0 {
                    realTime.setText("")
                }
                departure.setText(stopDetails.departure)
            }
        }
    }
    
    
}