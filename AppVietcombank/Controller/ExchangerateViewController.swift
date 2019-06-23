//
//  ExchangerateViewController.swift
//  AppVietcombank
//
//  Created by Anh vũ on 6/15/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit

class ExchangerateViewController: UIViewController {
  
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showExchangerRate: ShowExchangerRate!
    @IBOutlet weak var segmentedExchanger: UISegmentedControl!
    
    var exchangerRate = ExchangerRate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
          tableView.dataSource = exchangerRate
        
    }
// MARK: - ACTION
    @IBAction func cancelHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func showSegmented(_ sender: UISegmentedControl) {
        let segmented = sender.selectedSegmentIndex
        switch segmented {
        case 0:
            showExchangerRate.isOpen = false
            tableView.dataSource = exchangerRate
            tableView.reloadData()
        case 1:
            showExchangerRate.isOpen = true
            view.addSubview(showExchangerRate)
            showExchangerRate.fill(left: 0, top: nil, right: 0, bottom: 0)
            showExchangerRate.topAnchor.constraint(equalTo:(topview.bottomAnchor)).isActive = true
        default:
           break
        }
    }
}

class ExchangerRate: NSObject, UITableViewDataSource  {
    var exchanger = [Exchangerate(currency: "AUD", buying: "15,888.19", sell: "16,255.83"),
                                  Exchangerate(currency: "CAD", buying: "17,189.19", sell: "17,640.18"),
                                  Exchangerate(currency: "CHF", buying: "23,168.94", sell: "23,634.2"),
                                  Exchangerate(currency: "DKK", buying: "-", sell: "3,578.5"),
                                  Exchangerate(currency: "EUR", buying: "25,955.92", sell: "26,714.34"),
                                  Exchangerate(currency: "GBF", buying: "29,234.44", sell: "29,714.34"),
                                  Exchangerate(currency: "HKD", buying: "15,888.19", sell: "16,255.83"),
                                  Exchangerate(currency: "INR", buying: "15,888.19", sell: "16,255.83"),
                                  Exchangerate(currency: "JPY", buying: "15,888.19", sell: "16,255.83"),
                                  Exchangerate(currency: "KRW", buying: "15,888.19", sell: "16,255.83"),
                                  Exchangerate(currency: "KQD", buying: "15,888.19", sell: "16,255.83"),
                                  Exchangerate(currency: "MYR", buying: "15,888.19", sell: "16,255.83"),
                                  Exchangerate(currency: "NOK", buying: "15,888.19", sell: "16,255.83"),
                                  Exchangerate(currency: "RUB", buying: "15,888.19", sell: "16,255.83")]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchanger.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ExchangerRateCell else {return UITableViewCell()}
        let listExchanger      = exchanger[indexPath.row]
        cell.showCurrency.text = listExchanger.currency
        cell.showBuying.text   = listExchanger.buying
        cell.showSell.text     = listExchanger.sell
        return cell
    }
}
