//
//  StopsInterfaceController.swift
//  Watch Extension
//
//  Created by Håkon Løvdal on 19/10/15.
//  Copyright © 2015 Håkon Løvdal. All rights reserved.
//

import WatchKit
import Foundation

class StopsInterfaceController: WKInterfaceController {
    
    @IBOutlet var stopsTable: WKInterfaceTable!
    
    let busStops = Stop.allStops()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        stopsTable.setNumberOfRows(busStops.count, withRowType: "StopsRow")
        
        for index in 0..<stopsTable.numberOfRows {
            if let controller = stopsTable.rowControllerAtIndex(index) as? StopsRowController {
                controller.stop = busStops[index]
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let stop = busStops[rowIndex]
        presentControllerWithName("StopDetails", context: stop)
    }
    
}
