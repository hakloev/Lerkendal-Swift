//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Håkon Løvdal on 19/10/15.
//  Copyright © 2015 Håkon Løvdal. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    let washerApiService = WasherService.sharedInstance
    let busApiService = BusService.sharedInstance
    
    let busStops: [String] = ["16011264", "16010264", "16010649"] // Lerkendal toCity, Lerkendal fromCity, Tempe toCity
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        washerApiService.getWasherData { (jsonData: NSDictionary) -> Void in
            print(jsonData["availableWashers"] as! Int)
        }
        
        // Lerkendal til byen
        for stopID in busStops {
            busApiService.getBusDataFor(stopID, onCompletion: prettyPrintBusData)
        }
        
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
