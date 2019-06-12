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

class MapATMViewController: UIViewController{
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var pinContansGps: NSLayoutConstraint!
    @IBOutlet weak var gps: UIImageView!
    var arraymarketAtm = [GMSMarker]()
    var atmMarkers = [GMSMarker]()
    var branchMarkers = [GMSMarker]()
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
    var atm: ATM?
    var result = true {
        didSet {
            gps.alpha = self.result ? 0 : 1
        }
    }
    private let locationManager = CLLocationManager()
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
        var marker = GMSMarker(position: position)
        marker.title = name
        marker.icon = UIImage(named: logo)
        marker.map = mapView
        atmMarkers.append(marker)
    }
    
    func addBranchMarker(at position: CLLocationCoordinate2D, name: String, logo: String) {
        var marker = GMSMarker(position: position)
        marker.title = name
        marker.icon = UIImage(named: logo)
        marker.map = mapView
        branchMarkers.append(marker)
    }
    
    func removeMarkers(mapView: GMSMapView){
        for (index, _) in arraymarketAtm.enumerated() {
            print("Item \(index)")
            self.arraymarketAtm[index].map = nil
        }
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
            }}
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
    //    lay dia chi
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        // 1 Tạo một GMSGeocoder đối tượng để biến tọa độ vĩ độ và kinh độ thành địa chỉ đường phố.
        let geocoder = GMSGeocoder()
        // 2 Yêu cầu trình mã hóa địa lý đảo ngược mã địa lý tọa độ được truyền cho phương thức. Sau đó nó xác minh có một địa chỉ trong phản hồi của loại GMSAddress. Đây là một lớp mô hình cho các địa chỉ được trả về bởi GMSGeocoder.
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            self.addressLabel.unlock()
            guard let address = response?.firstResult(), let lines = address.lines else {return}
            // 3 Đặt văn bản của addressLabelđịa chỉ được trả về bởi trình mã hóa địa lý.
            self.addressLabel.text = lines.joined(separator: "\n")
            
            // 4 Khi địa chỉ được đặt, hãy tạo hiệu ứng thay đổi kích thước nội dung bên trong của nhãn .
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
//1 Bạn tạo một MapViewControllerphần mở rộng phù hợp với CLLocationManagerDelegate.
extension MapATMViewController: CLLocationManagerDelegate {
    // 2 locationManager(_:didChangeAuthorization:) được gọi khi người dùng cấp hoặc thu hồi quyền truy cập vị trí.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3 Tại đây bạn xác minh người dùng đã cấp cho bạn quyền trong khi ứng dụng đang được sử dụng.
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4 Khi quyền đã được thiết lập, hãy hỏi người quản lý vị trí để cập nhật về vị trí của người dùng.
        locationManager.startUpdatingLocation()
        
        //5 GMSMapViewcó hai tính năng liên quan đến vị trí của người dùng: myLocationEnabledvẽ một chấm màu xanh nhạt nơi người dùng được đặt, trong khi myLocationButton, khi được đặt thành true, sẽ thêm một nút vào bản đồ, khi chạm vào, đặt bản đồ vào vị trí của người dùng.
        mapView?.isMyLocationEnabled = true
        mapView?.settings.myLocationButton = true
    }
    
    // 6 locationManager(_:didUpdateLocations:) thực thi khi người quản lý vị trí nhận dữ liệu vị trí mới.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        // 7 Điều này cập nhật camera của bản đồ vào trung tâm xung quanh vị trí hiện tại của người dùng. Các GMSCameraPositionlớp tập hợp tất cả các thông số vị trí camera và chuyển chúng vào bản đồ để trưng bày.
        mapView?.camera = GMSCameraPosition(target: location.coordinate, zoom: 8, bearing: 0, viewingAngle: 0)
        
        // 8 Nói locationManagerrằng bạn không còn quan tâm đến các bản cập nhật; bạn không muốn theo dõi người dùng vì vị trí ban đầu của họ là đủ để bạn làm việc.
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - GMSMapViewDelegate
extension MapATMViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        addressLabel.lock()
    }
    
}
extension MapATMViewController {
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
extension MapATMViewController: UITextFieldDelegate, GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress ?? "null")")
        self.searchTextField.text = place.formattedAddress
        print("Place attributions: \(String(describing: place.attributions))")
        //       tim dia diem
        let camera = GMSCameraUpdate.setTarget(place.coordinate, zoom: 15)
        mapView.animate(with: camera)
        self.dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        //        print("Error: \(error.description)")
        self.dismiss(animated: true, completion: nil)
    }
    
    // User canceled the operation.(huy thao tac)
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
