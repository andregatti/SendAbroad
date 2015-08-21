//
//  ExchangeRateViewController.swift
//  SendAbroad
//
//  Created by Andre Gatti on 8/19/15.
//  Copyright (c) 2015 GattiSoft. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var exchangeRates = Array<RateParam>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        print("COUNT \(exchangeRates.count)")
        return exchangeRates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell: ExchangeRateTableViewCell = tableView.dequeueReusableCellWithIdentifier("ExchangeRateIdentifier") as? ExchangeRateTableViewCell {
            // Configure the cell for this indexPath
            let rateParam = exchangeRates[indexPath.row]
            
            cell.currencyAbbrLabel.text = rateParam.currencyAbbr
            cell.exchangeRateLabel.text = String(format:"%.4f", rateParam.value!)
            
            
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
