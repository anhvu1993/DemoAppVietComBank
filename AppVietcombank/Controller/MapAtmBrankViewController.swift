//
//  MapATMViewController.swift
//  AppVietcombank
//
//  Created by Anh vũ on 5/27/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import GooglePlacePicker

class MapAtmBrankViewController: UIViewController{
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var pinContansGps: NSLayoutConstraint!
    @IBOutlet weak var gps: UIImageView!
    
    private let locationManager = CLLocationManager()
    var atmMarkers     = [GMSMarker]()
    var branchMarkers  = [GMSMarker]()
    var atm: ATM?
    var atms = [ATM](){
        didSet {
            atms.forEach{ data in
                let position = CLLocationCoordinate2D(latitude: data.tatitudebranch!, longitude: data.longitudebranch!)
                addBranchMarker(at: position, name: data.name!, logo: "6")
                let branchBank = CLLocationCoordinate2D(latitude: data.tatitudeBank!, longitude: data.longitudeBank!)
                addATMMarker(at: branchBank, name: "Ngan hàng VietCombank", logo: "12")
            }
        }
    }
    var result = true {
        didSet {
            gps.alpha = self.result ? 0 : 1
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextField.delegate = self
        getdatafromNotification()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
//    MARK: danh dau dia diem
    func addATMMarker(at position: CLLocationCoordinate2D, name: String, logo: String) {
        let marker   = GMSMarker(position: position)
        marker.title = name
        marker.icon  = UIImage(named: logo)
        marker.map   = mapView
        atmMarkers.append(marker)
    }
    func addBranchMarker(at position: CLLocationCoordinate2D, name: String, logo: String) {
        let marker   = GMSMarker(position: position)
        marker.title = name
        marker.icon  = UIImage(named: logo)
        marker.map   = mapView
        branchMarkers.append(marker)
    }
    func getdatafromNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(showBranchMarket), name: .showBranch, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showAtmMarker), name: .showAtm, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getDataArrayAtm), name: .dataBankOnMap , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showAllMarker), name: .showAllButton , object: nil)
    }
    @objc func getDataArrayAtm(data: Notification) {
        if let datas = data.object as? [ATM] {
            DispatchQueue.main.async {
                self.atms = datas
            }
        }
    }
    @objc func showAllMarker(data: Notification) {
        if let data = data.object as? UIButton {
            if data.isSelected == true {
                branchMarkers.forEach{ marker in
                    marker.map = mapView
                atmMarkers.forEach{ maker in
                        maker.map = mapView
                    }
                }
            } else {
                branchMarkers.forEach { (marker) in
                    marker.map?.clear()
                }
                atmMarkers.forEach{ (marker) in
                    marker.map?.clear()
                }
            }
        }
    }
    @objc func showBranchMarket(data : Notification){
        guard let data = data.object as? UIButton else {return}
        if data.isSelected == true {
            branchMarkers.forEach{ marker in
                marker.map = mapView
            }
        } else {
            branchMarkers.forEach { (marker) in
                marker.map = nil
            }
        }
    }
    @objc func showAtmMarker(data : Notification){
        guard let data = data.object as? UIButton else {return}
        if data.isSelected == true {
            atmMarkers.forEach{ maker in
                maker.map = mapView
            }
        } else {
            atmMarkers.forEach{ (marker) in
                marker.map = nil
            }
        }
    }
// MARK :   lay dia chi
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            self.addressLabel.unlock()
            guard let address = response?.firstResult(), let lines = address.lines else {return}
            self.addressLabel.text = lines.joined(separator: "\n")
            let labelHeight = self.addressLabel.intrinsicContentSize.height
            self.mapView.padding = UIEdgeInsets(top: self.view.safeAreaInsets.top, left: 0,
                                                bottom: labelHeight, right: 0)
            UIView.animate(withDuration: 0.25) {
                self.pinContansGps.constant = ((labelHeight - self.view.safeAreaInsets.top) * 0.5)
                self.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension MapAtmBrankViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {return}
        locationManager.startUpdatingLocation()
        mapView?.isMyLocationEnabled = true
        mapView?.settings.myLocationButton = true
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        mapView?.camera = GMSCameraPosition(target: location.coordinate, zoom: 8, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - GMSMapViewDelegate
extension MapAtmBrankViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        addressLabel.lock()
    }
}
extension MapAtmBrankViewController {
    //    Mark: tim duong
    
    //    func drawPolygon(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
    //
    //        let config = URLSessionConfiguration.default
    //        let session = URLSession(configuration: config)
    //
    //        guard let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving") else {
    //            return
    //        }
    //
    //        DispatchQueue.main.async {
    //
    //            session.dataTask(with: url) { (data, response, error) in
    //
    //                guard data != nil else {
    //                    return
    //                }
    //                do {
    //
    //                    let route = try JSONDecoder().decode(MapPath.self, from: data!)
    //
    //                    if let points = route.routes?.first?.overview_polyline?.points {
    //                        self.drawPath(with: points)
    //                    }
    //                    print(route.routes?.first?.overview_polyline?.points)
    //
    //                } catch let error {
    //
    //                    print("Failed to draw ",error.localizedDescription)
    //                }
    //                }.resume()
    //        }
    //    }
    //
    //    //MARK:- Draw polygon
    //
    //    private func drawPath(with points : String){
    //
    //        DispatchQueue.main.async {
    //
    //            let path = GMSPath(fromEncodedPath: points)
    //            let polyline = GMSPolyline(path: path)
    //            polyline.strokeWidth = 3.0
    //            polyline.strokeColor = .red
    //            polyline.map = self
    //
    //        }
    //    }
}

// MARK : Search address
extension MapAtmBrankViewController: UITextFieldDelegate, GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress ?? "null")")
        self.searchTextField.text = place.formattedAddress
        print("Place attributions: \(String(describing: place.attributions))")
// MARK: tim dia diem
        let camera = GMSCameraUpdate.setTarget(place.coordinate, zoom: 15)
        mapView.animate(with: camera)
        self.dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        self.dismiss(animated: true, completion: nil)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        self.dismiss(animated: true, completion: nil)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        self.present(acController, animated: true, completion: nil)
    }
}
