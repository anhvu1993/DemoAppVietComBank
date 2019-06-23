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

class AddresAtmBrankViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    lazy private var activityIndicator : CustomActivityIndicatorView = {
        let image : UIImage = UIImage(named: "loading")!
        return CustomActivityIndicatorView(image: image)
    }()
    
    var atmMapViewController: MapAtmBrankViewController?
    var dataMapBank = [ATM]()
    
    @IBOutlet var popupView: MenuTopView!
    @IBOutlet weak var outletNavigartion: UIView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadActivity()
       getDataAddressAtmBranch()
    }
    func getDataAddressAtmBranch() {
        DataSevice.shared.makeRequestJson { (data) in
            self.dataMapBank = data
            NotificationCenter.default.post(name: .dataBankOnMap, object: data, userInfo: nil)
            self.tableView.reloadData()
        }
    }
//    MARK : Activity
    func loadActivity() {
        activityIndicator.startAnimating()
        addLoadingIndicator()
    }
    func addLoadingIndicator () {
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
    }
//  MARK: segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case SegueIdentifier.embedMapVC.rawValue:
            atmMapViewController = segue.destination as? MapAtmBrankViewController
        case SegueIdentifier.webViewVc.rawValue:
            guard let navigationController = segue.destination as? UINavigationController else {return}
            guard let webGooglemaoViewController = navigationController.topViewController as? WebGooglemaoViewController else {return}
            if let indexPath = tableView.indexPathForSelectedRow {
                webGooglemaoViewController.webGoogleMap = dataMapBank[indexPath.row].googleUrl
            }
//    MARK: Popover
        case SegueIdentifier.PopupView.rawValue:
            let vc = segue.destination
            let pc = vc.popoverPresentationController
            pc?.delegate = self
            pc?.sourceRect = CGRect(origin: view.center, size: .zero)
        default:
            break
        }
    }
//    MARK: Popover
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
//   MARK: Menutop
    @IBAction func actionPopup(_ sender: UIButton) {
        popupView.isOpen.toggle()
        view.addSubview(popupView)
        popupView.fill(left: 0, top: nil, right: 0, bottom: 0)
        popupView.topAnchor.constraint(equalTo: outletNavigartion.bottomAnchor).isActive = true
        //      lay khoang cach navigation
        //        navigationController?.navigationBar
    }
    @IBAction func cancelHome(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK : UITableViewDataSource
extension AddresAtmBrankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMapBank.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ShowAtmBranchTableViewCell else { return UITableViewCell()}
        let listDataMapBank = dataMapBank[indexPath.row]
        cell.branch.text = listDataMapBank.name
        cell.address.text = listDataMapBank.addressbank
        let url = URL(string: listDataMapBank.logoUrlBranch!)
        do {
            let data = try? Data(contentsOf: url!)
            cell.logo.image = UIImage(data: data!)
        }
// MARK :  top Activity
        activityIndicator.stopAnimating()
        return cell
    }
}

// MARK : UITableViewDelegate
extension AddresAtmBrankViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        atmMapViewController?.atm = dataMapBank[indexPath.row]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

