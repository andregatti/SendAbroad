//
//  VariationInTimeViewController.swift
//  SendAbroad
//
//  Created by Andre Gatti on 8/20/15.
//  Copyright (c) 2015 GattiSoft. All rights reserved.
//

import UIKit
import Charts

class VariationInTimeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ex = ExchangeRateStore()
        
        ex.latestExchangeRate("USD", success:{ (eparam : ExchangeRateParam!) -> Void in
            print("\(eparam.baseCountryAbbr)")
            print("\(eparam.date)")
            dispatch_async(dispatch_get_main_queue()) {
                
                // CREATE GRAPHIC
            }
        })
    }
    
}
