//
//  WebGooglemaoViewController.swift
//  AppVietcombank
//
//  Created by Anh vũ on 6/3/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit

class WebGooglemaoViewController: UIViewController {
    lazy private var activityIndicator : CustomActivityIndicatorView = {
        let image : UIImage = UIImage(named: "loading")!
        return CustomActivityIndicatorView(image: image)
    }()
    var webGoogleMap:String?
    
    @IBOutlet weak var WebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        addLoadingIndicator()
        runWebView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.activityIndicator.stopAnimating()
    }
    func runWebView(){
        if let dataWebGoogle = webGoogleMap {
            if let url = URL(string: dataWebGoogle) {
                let request = URLRequest(url: url)
                WebView.loadRequest(request)
            }
        }
    }
    func addLoadingIndicator () {
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
