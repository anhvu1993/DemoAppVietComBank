//
//  ShowExchangerRate.swift
//  AppVietcombank
//
//  Created by Anh vũ on 6/15/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit
class ShowExchangerRate: UIView{
    var isOpen:Bool = false {
        didSet {
            self.alpha = self.isOpen ? 1 : 0
            if !isOpen {
                self.removeFromSuperview()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
