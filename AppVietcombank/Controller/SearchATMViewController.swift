//
//  ViewController.swift
//  AppVietcombank
//
//  Created by Anh vũ on 5/27/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit
extension Notification.Name {
    static let dataBankOnMap = Notification.Name("dataBankOnMap")
}

enum SegueIdentifier : String {
    case embedMapVC = "embedMapVC"
    case webViewVc  = "webViewVc"
    case PopupView  = "PopupView"
}
class SearchATMViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var atmMapViewController: MapATMViewController?
    
//    @IBOutlet var popupAdress: PopupView!
    @IBOutlet var popupView: MenuTopView!
    @IBOutlet weak var outletNavigartion: UIView!
    @IBOutlet weak var tableView: UITableView!
    var dataMapBank = [ATM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataSevice.shared.makeRequestJson { (data) in
            self.dataMapBank = data
            NotificationCenter.default.post(name: .dataBankOnMap, object: data, userInfo: nil)
            self.tableView.reloadData()
        }
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case SegueIdentifier.embedMapVC.rawValue:
            atmMapViewController = segue.destination as? MapATMViewController
        case SegueIdentifier.webViewVc.rawValue:
            guard let navigationController = segue.destination as? UINavigationController else {return}
            guard let webGooglemaoViewController = navigationController.topViewController as? WebGooglemaoViewController else {return}
           if let indexPath = tableView.indexPathForSelectedRow {
             webGooglemaoViewController.webGoogleMap = dataMapBank[indexPath.row].googleUrl
            }
        case SegueIdentifier.PopupView.rawValue:
            let vc = segue.destination
            let pc = vc.popoverPresentationController
            pc?.delegate = self
            pc?.sourceRect = CGRect(origin: view.center, size: .zero)
        default:
            return 
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
    @IBAction func actionPopup(_ sender: UIButton) {
        popupView.isOpen.toggle()
        view.addSubview(popupView)
        popupView.fill(left: 0, top: nil, right: 0, bottom: 0)
      
        
//      lay khoang cach navigation
//        navigationController?.navigationBar
        
    }
    
//    @IBAction func clickPopupAdress(_ sender: Any) {
//        popupAdress.onAdress.toggle()
//        view.addSubview(popupAdress)
//        popupAdress.fill(left: 0, top: 0, right: 0, bottom: 0)
//    }
    
    @IBAction func cancelHome(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension SearchATMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMapBank.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let listDataMapBank = dataMapBank[indexPath.row]
        cell.branch.text = listDataMapBank.name
        cell.address.text = listDataMapBank.addressbank
        let url = URL(string: listDataMapBank.logoUrlBranch!)
        do {
            let data = try? Data(contentsOf: url!)
            cell.logo.image = UIImage(data: data!)
            
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        atmMapViewController?.atm = dataMapBank[indexPath.row]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}



