//
//  ComplicationController.swift
//  Watch Extension
//
//  Created by Håkon Løvdal on 19/10/15.
//  Copyright © 2015 Håkon Løvdal. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    let washerService = WasherService.sharedInstance
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler(CLKComplicationTimeTravelDirections.None)
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        // Call the handler with the current timeline entry
        washerService.getWasherData { (data: NSDictionary) -> Void in
            var template: CLKComplicationTemplate?
            
            switch complication.family {
            case .ModularSmall:
                print("Creating ModularSmall complication")
                let modularSmallComplication = CLKComplicationTemplateModularSmallRingText()
                
                if let availableWashers: Int = data["availableWashers"] as? Int {
                    let result: Float = Float(availableWashers) / Float(18)
                    modularSmallComplication.fillFraction = result
                    modularSmallComplication.textProvider = CLKSimpleTextProvider(text: "\(availableWashers)")
                } else {
                    modularSmallComplication.fillFraction = 0
                    modularSmallComplication.textProvider = CLKSimpleTextProvider(text: "N/A")
                }
                modularSmallComplication.ringStyle = CLKComplicationRingStyle.Closed
                template = modularSmallComplication
            case .UtilitarianLarge:
                print("Creating UtilitarianLarge complication")
                template = nil
            default:
                print("Unknown complication type acessed: \(complication.family)")
            }
            
            
            if (template != nil) {
                let timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template!)
                handler(timelineEntry)
            } else {
                handler(nil)
            }
        }
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(NSDate(timeIntervalSinceNow: 60 * 30));
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        var template: CLKComplicationTemplate?
        
        switch complication.family {
        case .ModularSmall:
            let modularSmallTemplate = CLKComplicationTemplateModularSmallRingText()
            modularSmallTemplate.textProvider = CLKSimpleTextProvider(text: "VM", shortText: "VM")
            modularSmallTemplate.fillFraction = 0.75
            modularSmallTemplate.ringStyle = CLKComplicationRingStyle.Closed
            template = modularSmallTemplate
        case .UtilitarianLarge:
            // ADD THIS
            template = nil
        default:
            print("Unknown complication type acessed: \(complication.family)")
            template = nil
        }
    
        handler(template)
    }
    
    // MARK: - Complication data generator
    
}
