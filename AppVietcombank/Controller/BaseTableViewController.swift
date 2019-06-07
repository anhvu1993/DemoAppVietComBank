//
//  BaseTableViewController.swift
//  AppVietcombank
//
//  Created by Anh vũ on 6/3/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating  {
    
    var filteredCities = [Name]()
    let searchController = UISearchController(searchResultsController: nil)
    var dislayPlace: [Name] = []
    var resultSearchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        callsearch2()
    }
    
    // MARK : take searchbar
    func callsearch2() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        tableView.reloadData()
    }
    
    func callSearchbar (){
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search "
        tableView.tableHeaderView = searchController.searchBar
        searchController.delegate = self
        searchController.searchBar.delegate = self
        tableView.reloadData()
    }
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return resultSearchController.searchBar.text?.isEmpty ?? true
    }
    // loc noi dung
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCities = dislayPlace.filter({( cities : Name) -> Bool in
            return cities.name.lowercased().asciiString!.contains(searchText.lowercased().asciiString!)
        })
        tableView.reloadData()
    }
    // dang loc
    func  isFiltering () -> Bool {
        return resultSearchController.isActive && !searchBarIsEmpty ()
    }
    //    MARK: tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCities.count
        }
        return dislayPlace.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var cities:Name?
        if isFiltering() {
            cities = filteredCities[indexPath.row]
        }else {
            cities = dislayPlace[indexPath.row]
        }
        cell.textLabel?.text = cities?.name
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
}
class CitiesViewController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        dislayPlace = DataSeviceCities.shared.dataCitis
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as? DistrictsViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            if isFiltering() {
                DataSeviceCities.shared.selecterCity = filteredCities[indexPath.row] as! Cities
                UserDefaults.standard.set(filteredCities[indexPath.row].name, forKey: "Cities")
            } else {
                DataSeviceCities.shared.selecterCity = DataSeviceCities.shared.dataCitis[indexPath.row]
                UserDefaults.standard.set(DataSeviceCities.shared.dataCitis[indexPath.row].name, forKey: "Cities")
                
            }}
    }
    
    @IBAction func CancelHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

class DistrictsViewController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        dislayPlace = DataSeviceCities.shared.selecteDistricts
        
    }
    
    
    // MARK: Open app
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(DataSeviceCities.shared.selecteDistricts[indexPath.row].name, forKey: "Districts")
        if let urlApp = URL(string: "GoogleMaps://"){
            let canOpen = UIApplication.shared.canOpenURL(urlApp)
            print("\(canOpen)")
            let appName = "GoogleMaps"
            let appScheme = "\(appName)://"
            let appSchemURL = URL(string: appScheme)
            
            if UIApplication.shared.canOpenURL(appSchemURL as! URL) {
                UIApplication.shared.open(appSchemURL!, options: [:], completionHandler: nil)
            }else {
                let alert = UIAlertController(title: "\(appName) Error..", message: "the app named \(appName) Not on Iphone", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

// fintered tieng viet
extension String {
    var asciiString: String? {
        if let data = self.data(using: String.Encoding.ascii, allowLossyConversion: true){
            return String.init(data: data, encoding: String.Encoding.ascii)
        }
        return nil
    }
}
