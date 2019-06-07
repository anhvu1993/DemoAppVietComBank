//
//  WebGooglemaoViewController.swift
//  AppVietcombank
//
//  Created by Anh vũ on 6/3/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit

class WebGooglemaoViewController: UIViewController {
    @IBOutlet weak var WebView: UIWebView!
    var webGoogleMap:String?
    override func viewDidLoad() {
        super.viewDidLoad()
       runWebView()
    }
func runWebView(){
        if let dataWebGoogle = webGoogleMap {
            if let url = URL(string: dataWebGoogle) {
                let request = URLRequest(url: url)
                WebView.loadRequest(request)
            }
        }
    }
    @IBAction func cancel(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    

}
