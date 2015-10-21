//
//  StopsRowController.swift
//  Lerkendal-Swift
//
//  Created by Håkon Løvdal on 21/10/15.
//  Copyright © 2015 Håkon Løvdal. All rights reserved.
//

import Foundation
import WatchKit

class StopsRowController: NSObject {
    
    @IBOutlet var stopNameLabel: WKInterfaceLabel!
    @IBOutlet var stopDirectionLabel: WKInterfaceLabel!

    var stop: Stop? {
    
        didSet {
            if let stop = stop {
                stopNameLabel.setText(stop.name)
                stopDirectionLabel.setText(stop.directionText)
            }
        }
    }
    
}