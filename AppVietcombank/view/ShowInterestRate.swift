//
//  ShowInterestRate.swift
//  AppVietcombank
//
//  Created by Anh vũ on 6/11/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import Foundation
import UIKit
class ShowInteresinterRate: UIView {
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var segmentedController: TabySegmentedControl!
    var isOpen:Bool = false {
        didSet {
            self.alpha = self.isOpen ? 1 : 0
            if !isOpen {
                self.removeFromSuperview()
            }
        }
    }
    
    var vndRateViewcontroller = VndRateViewController()
    var usdRateViewController = UsdRateViewController()
    var eurRateViewController = EurRateViewController()
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
        tableView.dataSource = vndRateViewcontroller
//        tableView.dataSource = self
//        tableView.delegate = self
    }
    func setupTableView() {
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = UIColor.white
        tableView.isScrollEnabled = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @IBAction func segmented(_ sender: UISegmentedControl) {
        let index = segmented.selectedSegmentIndex
        switch index {
        case 0:
            self.tableView.dataSource = vndRateViewcontroller
            self.tableView.reloadData()
        case 1:
            self.tableView.dataSource = usdRateViewController
            self.tableView.reloadData()
        case 2:
            self.tableView.dataSource = eurRateViewController
            self.tableView.reloadData()
        default:
            break
        }
    }
}
class VndRateViewController: NSObject, UITableViewDelegate, UITableViewDataSource {
    var monthAndrate = [ Interestrate(month: "1", rate: 4.5),
                         Interestrate(month: "2", rate: 4.5),
                         Interestrate(month: "3", rate: 5.0),
                         Interestrate(month: "6", rate: 5.5),
                         Interestrate(month: "9", rate: 6.8),
                         Interestrate(month: "12", rate: 6.8),
                         Interestrate(month: "24", rate: 6.8),
                         Interestrate(month: "36", rate: 6.8),
                         Interestrate(month: "48", rate: 6.8)  ]
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
class UsdRateViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var monthAndrate = [Interestrate(month: "1", rate: 0.00),
                        Interestrate(month: "2", rate: 0.00),
                        Interestrate(month: "3", rate: 0.00),
                        Interestrate(month: "6", rate: 0.00),
                        Interestrate(month: "9", rate: 0.00),
                        Interestrate(month: "12", rate: 0.00),
                        Interestrate(month: "24", rate: 0.00),
                        Interestrate(month: "36", rate: 0.00),
                        Interestrate(month: "48", rate: 0.00)]
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

class EurRateViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var monthAndrate = [Interestrate(month: "1", rate: 0.15),
                        Interestrate(month: "2", rate: 0.15),
                        Interestrate(month: "3", rate: 0.15),
                        Interestrate(month: "6", rate: 0.15),
                        Interestrate(month: "9", rate: 0.15),
                        Interestrate(month: "12", rate: 0.3),
                        Interestrate(month: "24", rate: 0.3),
                        Interestrate(month: "36", rate: 0.3),
                        Interestrate(month: "48", rate: 0.3)
        
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
