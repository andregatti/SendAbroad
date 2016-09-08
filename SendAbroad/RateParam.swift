//
//  RateParam.swift
//  SendAbroad
//
//  Created by Andre Gatti on 8/19/15.
//  Copyright (c) 2015 GattiSoft. All rights reserved.
//

import UIKit

class RateParam {
    var currencyName: String?
    var currencyAbbr: String?
    var value: Double?
    
    init(currencyAbbr: String, value: Double) {
        self.currencyAbbr = currencyAbbr
        self.value = value
        self.currencyName = self.currencyNameWithCurrencyAbbr(currencyAbbr)
    }
    
    func currencyNameWithCurrencyAbbr(currencyAbbr: String) -> String? {
        let path = NSBundle.mainBundle().pathForResource("Currencies", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        return dict![currencyAbbr] as? String
    }
}
