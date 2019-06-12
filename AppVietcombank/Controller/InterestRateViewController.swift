//
//  InterestRateViewController.swift
//  AppVietcombank
//
//  Created by Anh vũ on 6/5/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit

class InterestRateViewController: UIViewController {
    @IBOutlet var showInterestRate: ShowInteresinterRate!
    
    @IBOutlet weak var slackView: UIStackView!
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
        showInterestRate.isOpen = false
        deposits.titleLabel?.alpha = 0.5
    }
    
    @IBAction func runDeposits(_ sender: Any) {
        showInterestRate.isOpen = true
        view.addSubview(showInterestRate)
        showInterestRate.fill(left: 0, top: nil, right: 0, bottom: 0)
        showInterestRate.topAnchor.constraint(equalTo:(slackView.bottomAnchor)).isActive = true
        
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
    var monthAndrate = [ Interestrate(month: "Không kỳ hạn", rate: 0.1),
                         Interestrate(month: "7 ngày", rate: 0.5),
                         Interestrate(month: "14 ngày", rate: 0.5),
                         Interestrate(month: "1 tháng", rate: 4.5),
                         Interestrate(month: "2 tháng", rate: 4.5),
                         Interestrate(month: "3 tháng", rate: 5.00),
                         Interestrate(month: "6 tháng", rate: 5.5),
                         Interestrate(month: "9 tháng", rate: 5.5),
                         Interestrate(month: "12 tháng", rate: 6.8),
                         Interestrate(month: "24 tháng", rate: 6.8),
                         Interestrate(month: "36 tháng", rate: 6.8),
                         Interestrate(month: "48 tháng", rate: 6.8),
                         Interestrate(month: "60 tháng", rate: 6.8)]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthAndrate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var dataRate = monthAndrate[indexPath.row]
        cell.textLabel?.text = ("\(dataRate.month)")
        cell.detailTextLabel?.text = ("\(dataRate.rate)%")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
class UsdViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var monthAndrate = [ Interestrate(month: "Không kỳ hạn", rate: 0.00),
                         Interestrate(month: "7 ngày", rate: 0),
                         Interestrate(month: "14 ngày", rate: 0),
                         Interestrate(month: "1 tháng", rate: 0.00),
                         Interestrate(month: "2 tháng", rate: 0.00),
                         Interestrate(month: "3 tháng", rate: 0.00),
                         Interestrate(month: "6 tháng", rate: 0.00),
                         Interestrate(month: "9 tháng", rate: 0.00),
                         Interestrate(month: "12 tháng", rate: 0.00),
                         Interestrate(month: "24 tháng", rate: 0.00),
                         Interestrate(month: "36 tháng", rate: 0.00),
                         Interestrate(month: "48 tháng", rate: 0.00),
                         Interestrate(month: "60 tháng", rate: 0.00)]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthAndrate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dataRate = monthAndrate[indexPath.row]
        cell.textLabel?.text = ("\(dataRate.month)")
        cell.detailTextLabel?.text = ("\(dataRate.rate)%")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

class EurViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var monthAndrate = [ Interestrate(month: "Không kỳ hạn", rate: 0.00),
                         Interestrate(month: "7 ngày", rate: 0),
                         Interestrate(month: "14 ngày", rate: 0),
                         Interestrate(month: "1 tháng", rate: 0.15),
                         Interestrate(month: "2 tháng", rate: 0.15),
                         Interestrate(month: "3 tháng", rate: 0.15),
                         Interestrate(month: "6 tháng", rate: 0.15),
                         Interestrate(month: "9 tháng", rate: 0.15),
                         Interestrate(month: "12 tháng", rate: 0.3),
                         Interestrate(month: "24 tháng", rate: 0.3),
                         Interestrate(month: "36 tháng", rate: 0.3),
                         Interestrate(month: "48 tháng", rate: 0.3),
                         Interestrate(month: "60 tháng", rate: 0.3)]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthAndrate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dataRate = monthAndrate[indexPath.row]
        cell.textLabel?.text = ("\(dataRate.month)")
        cell.detailTextLabel?.text = ("\(dataRate.rate)%")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

