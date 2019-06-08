//
//  InterestRateViewController.swift
//  AppVietcombank
//
//  Created by Anh vũ on 6/5/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit

class InterestRateViewController: UIViewController {
    var vndViewcontroller = VndViewController()
    var usdViewController = UsdViewController()
    var eurViewController = EurViewController()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var outletSaving: UIButton!
    @IBOutlet weak var deposits: UIButton!
    @IBOutlet weak var segmented: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = vndViewcontroller
        deposits.titleLabel?.alpha = 0.5
    }
    @IBAction func runSaving(_ sender: Any) {
        deposits.titleLabel?.alpha = 0.5
    }
    
    @IBAction func runDeposits(_ sender: Any) {
        outletSaving.titleLabel?.alpha = 0.5
    }
    
    @IBAction func CancelHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func segmented(_ sender: UISegmentedControl) {
        let index = segmented.selectedSegmentIndex
        switch index {
        case 0:
            self.tableView.dataSource = vndViewcontroller
            self.tableView.reloadData()
        case 1:
            self.tableView.dataSource = usdViewController
            self.tableView.reloadData()
        case 2:
            self.tableView.dataSource = eurViewController
            self.tableView.reloadData()
            
        default:
            break
        }
    }
}
class VndViewController: NSObject, UITableViewDelegate, UITableViewDataSource {
    var monthAndrate = [Interestrate(month: 1, rate: 4.5),
                        Interestrate(month: 2, rate: 4.5),
                        Interestrate(month: 3, rate: 5.0),
                        Interestrate(month: 6, rate: 5.5),
                        Interestrate(month: 9, rate: 6.8),
                         Interestrate(month: 12, rate: 6.8),
                         Interestrate(month: 24, rate: 6.8),
                         Interestrate(month: 36, rate: 6.8),
                         Interestrate(month: 48, rate: 6.8)
                                                                                                        
    ]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthAndrate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var dataRate = monthAndrate[indexPath.row]
        cell.textLabel?.text = ("Tháng \(dataRate.month)")
        cell.detailTextLabel?.text = ("\(dataRate.rate)%")
        return cell
    }
}
class UsdViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var monthAndrate = [Interestrate(month: 1, rate: 0.00),
                        Interestrate(month: 2, rate: 0.00),
                        Interestrate(month: 3, rate: 0.00),
                        Interestrate(month: 6, rate: 0.00),
                        Interestrate(month: 9, rate: 0.00),
                        Interestrate(month: 12, rate: 0.00),
                        Interestrate(month: 24, rate: 0.00),
                        Interestrate(month: 36, rate: 0.00),
                        Interestrate(month: 48, rate: 0.00)
        
    ]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthAndrate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dataRate = monthAndrate[indexPath.row]
        cell.textLabel?.text = ("Tháng \(dataRate.month)")
        cell.detailTextLabel?.text = ("\(dataRate.rate)%")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

class EurViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var monthAndrate = [Interestrate(month: 1, rate: 0.15),
                        Interestrate(month: 2, rate: 0.15),
                        Interestrate(month: 3, rate: 0.15),
                        Interestrate(month: 6, rate: 0.15),
                        Interestrate(month: 9, rate: 0.15),
                        Interestrate(month: 12, rate: 0.3),
                        Interestrate(month: 24, rate: 0.3),
                        Interestrate(month: 36, rate: 0.3),
                        Interestrate(month: 48, rate: 0.3)
        
    ]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthAndrate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dataRate = monthAndrate[indexPath.row]
        cell.textLabel?.text = ("Tháng \(dataRate.month)")
        cell.detailTextLabel?.text = ("\(dataRate.rate)%")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

