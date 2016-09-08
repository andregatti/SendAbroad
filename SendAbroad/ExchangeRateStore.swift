//
//  ExchangeRateStore.swift
//  SendAbroad
//
//  Created by Andre Gatti on 8/19/15.
//  Copyright (c) 2015 GattiSoft. All rights reserved.
//

import UIKit

let kExchangeRateLatestUrl = "http://api.fixer.io/latest?base="

class ExchangeRateStore {

    func latestExchangeRate(baseCountryAbbr : String, success : (ExchangeRateParam!) -> Void) -> Void {
        let url : String = kExchangeRateLatestUrl + baseCountryAbbr
        let request = NSMutableURLRequest(URL : NSURL(string: url)!)
        request.HTTPMethod = "GET"
                
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
//            let error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
//
//            if let jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers, error : error) as? Dictionary<String, AnyObject> {
//                let exchangeRateParam = ExchangeRateParam(dictionary: jsonResult)
//                success(exchangeRateParam)
//            } else {
//                success(nil)
//            }
           
            
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions(rawValue: 0))
                guard let JSONDictionary :NSDictionary = jsonResult as? NSDictionary else {
                    print("Not a Dictionary")
                        success(nil)
                    return
                }
                print("JSONDictionary! \(JSONDictionary)")
                let exchangeRateParam = ExchangeRateParam(dictionary: jsonResult as! Dictionary<String, AnyObject>)
                success(exchangeRateParam)

            }
            catch let JSONError as NSError {
                print("\(JSONError)")
            }
            
            
            
        })
    }
}
