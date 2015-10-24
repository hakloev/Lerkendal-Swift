//
//  StopDetailsInterfaceController.swift
//  Lerkendal-Swift
//
//  Created by Håkon Løvdal on 21/10/15.
//  Copyright © 2015 Håkon Løvdal. All rights reserved.
//

import Foundation
import WatchKit

class StopDetailsInterfaceController: WKInterfaceController {
    
    @IBOutlet var stopDetailsTable: WKInterfaceTable!
    
    let busApiService = BusService.sharedInstance
    
    override func awakeWithContext(context: AnyObject?) {
        let stop: Stop = context as! Stop
        setTitle(stop.name)
        print("StopDetails awake with context: \(stop)")
        busApiService.getBusDataFor(stop.locationId!) { (stopData: NSDictionary) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                if let departures: NSArray = stopData["next"] as? NSArray {
                    self.stopDetailsTable.setNumberOfRows(departures.count, withRowType: "StopDetailsRow")
                    
                    for index in 0..<self.stopDetailsTable.numberOfRows {
                        if let controller = self.stopDetailsTable.rowControllerAtIndex(index) as? StopDetailsRowController {
                            controller.stopDetails = StopDetails(json: departures[index] as! NSDictionary)
                        }
                    }
                }
            })
            
        }
        
        super.awakeWithContext(context)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func prettyPrintBusData(busData: NSDictionary) {
        let stopName = busData["name"] as! String
        print("Bus data for stop: \(stopName)")
        
        if let busDepartures: NSArray = busData["next"] as? NSArray {
            for index in 0...4 {
                if let departureDetails: NSDictionary = (busDepartures[index] as! NSDictionary) {
                    print(departureDetails["d"] as! String)
                }
            }
        }
    }
    
}
