//
//  WasheryInterfaceController.swift
//  Lerkendal-Swift
//
//  Created by Håkon Løvdal on 23/10/15.
//  Copyright © 2015 Håkon Løvdal. All rights reserved.
//

import WatchKit
import Foundation


class WasheryInterfaceController: WKInterfaceController {
    
    @IBOutlet var availableWashers: WKInterfaceLabel!
    
    @IBAction func refreshWasherStatus() {
        refreshData()
    }
    
    let washerService = WasherService.sharedInstance

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        refreshData()
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func refreshData() {
        washerService.getWasherData { (washerStatus: NSDictionary) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                if let availableMachines: String = washerStatus["availableWashers"] as? String {
                    self.availableWashers.setText(availableMachines)
                }
            })
        }
    }
}
