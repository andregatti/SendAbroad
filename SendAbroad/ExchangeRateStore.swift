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
            
            let error: AutoreleasingUnsafeMutablePointer<NSError?> = nil

            if let jsonResult = NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers, error : error) as? Dictionary<String, AnyObject> {
                let exchangeRateParam = ExchangeRateParam(dictionary: jsonResult)
                success(exchangeRateParam)
            } else {
                success(nil)
            }
           
            
        })
    }
}
