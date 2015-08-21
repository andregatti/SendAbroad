//
//  ExchangeRateParam.swift
//  SendAbroad
//
//  Created by Andre Gatti on 8/19/15.
//  Copyright (c) 2015 GattiSoft. All rights reserved.
//

import UIKit

class ExchangeRateParam {
    var baseCountryAbbr: String?
    var date: NSDate?
    var rates = Array<RateParam>()
    
    init (dictionary : Dictionary<String, AnyObject>) {
        baseCountryAbbr = dictionary["base"] as? String
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        // dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US")
        date = dateStringFormatter.dateFromString((dictionary["date"] as? String)!)!
           if let ratesDictionary = dictionary["rates"] as? [String: Double] {
                for rateDictionary in ratesDictionary {
                    print("anything")
//                    println("\(rateDictionary.) - \(rateDictionary.1)")
                    let rateParam = RateParam(currencyAbbr: rateDictionary.0, value: rateDictionary.1)
                    rates.append(rateParam)
                }
            }
        
    }
}
 