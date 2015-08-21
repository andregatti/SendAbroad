//
//  RateParam.swift
//  SendAbroad
//
//  Created by Andre Gatti on 8/19/15.
//  Copyright (c) 2015 GattiSoft. All rights reserved.
//

import UIKit

class RateParam {
    var currencyAbbr: String?
    var value: Double?
    
    init (currencyAbbr: String, value: Double) {
        self.currencyAbbr = currencyAbbr
        self.value = value
    }

}
