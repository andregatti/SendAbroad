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
    
    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ex = ExchangeRateStore()
        
        ex.latestExchangeRate("USD", success:{ (eparam : ExchangeRateParam!) -> Void in
            print("\(eparam.baseCountryAbbr)")
            print("\(eparam.date)")
            dispatch_async(dispatch_get_main_queue()) {
                self.barChartView.noDataText = "You need to provide data for the chart."
                self.barChartView.noDataTextDescription = "GIVE REASON"
                
                var currencyAbbrs: [String] = []
                var values: [Double] = []
                
                for rateParam in eparam.rates {
                    if rateParam.value < 5 {
                        currencyAbbrs.append(rateParam.currencyAbbr!)
                        values.append(rateParam.value!)
                    }
                }
                
                self.setChart(currencyAbbrs, values: values)
            }
        })
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Currencies")
        let chartData = BarChartData(xVals: dataPoints, dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.descriptionText = "Exchange Rate"
    }
}


