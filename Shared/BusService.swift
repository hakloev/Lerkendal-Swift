//
//  BusService.swift
//  Lerkendal-Swift
//
//  Created by Håkon Løvdal on 19/10/15.
//  Copyright © 2015 Håkon Løvdal. All rights reserved.
//

import Foundation

class BusService: NSObject {
    
    static let sharedInstance = BusService()
    
    let baseURL: String = "http://bybussen.api.tmn.io/rt/"
    
    func getBusDataFor(busStop: String, onCompletion: (NSDictionary) -> Void) {
        let url: String = baseURL + busStop
        print("Making API-request for: \(url)")
        makeHTTPGetRequest(url, onCompletion: { response, err in
            onCompletion(response)
        })
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.requestCachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let session = NSURLSession(configuration: configuration)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            var jsonData: NSDictionary
            do {
                try jsonData = NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: AnyObject]
                onCompletion(jsonData, error)
            } catch let jsonError as NSError {
                print("Error while parsing JSON in makeHTTPGetRequest, here are the details:\n \(jsonError)")
            }
        })
        
        task.resume()
    }
}
