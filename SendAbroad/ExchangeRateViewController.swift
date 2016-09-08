//
//  ExchangeRateViewController.swift
//  SendAbroad
//
//  Created by Andre Gatti on 8/19/15.
//  Copyright (c) 2015 GattiSoft. All rights reserved.
//

import UIKit

let WRITE_CURRENCIES_PLIST = false

class ExchangeRateViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var exchangeRates = Array<RateParam>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (WRITE_CURRENCIES_PLIST) {
            let bundle = NSBundle.mainBundle()
            let pathCSV = bundle.pathForResource("Currencies", ofType: "csv")
            
            let content = try? String(contentsOfFile: pathCSV!, encoding: NSUTF8StringEncoding)

            let currencies = content!.componentsSeparatedByString("\r\n")
            
            let pathPList = NSBundle.mainBundle().pathForResource("Currencies", ofType: "plist")
            var dict = NSDictionary(contentsOfFile: pathPList!) as! Dictionary<String, String>

            for index in 0 ... (currencies.count - 1) {
                let completeCurrencyDescription = currencies[index].componentsSeparatedByString(",")
                let currencyAbbr: String = completeCurrencyDescription[0]
                let currencyName: String = completeCurrencyDescription[1]

                dict[currencyAbbr] = currencyName
            }
            
            let dict2 = dict as NSDictionary
            
            print(pathPList)

            dict2.writeToFile(pathPList!, atomically: false)
        }
        
        let ex = ExchangeRateStore()
        
        ex.latestExchangeRate("USD", success:{ (eparam : ExchangeRateParam!) -> Void in
            print("\(eparam.baseCountryAbbr)")
            print("\(eparam.date)")
            self.exchangeRates = eparam.rates
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangeRates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell: ExchangeRateTableViewCell = tableView.dequeueReusableCellWithIdentifier("ExchangeRateIdentifier") as? ExchangeRateTableViewCell {
            // Configure the cell for this indexPath
            let rateParam = exchangeRates[indexPath.row]
            
            cell.currencyAbbrLabel.text = rateParam.currencyAbbr
            cell.exchangeRateLabel.text = String(format:"%.4f", rateParam.value!)
            cell.currencyNameLabel.text = rateParam.currencyName
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    @IBAction func baseCurrencyButtonTapped(sender: AnyObject) {
        
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
