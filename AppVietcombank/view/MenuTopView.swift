//
//  PopupView.swift
//  AppVietcombank
//
//  Created by Anh vũ on 5/29/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit
extension Notification.Name {
    static var atm = Notification.Name("ATM")
    static var chiNhanhButton = Notification.Name("chiNhanhButton")
    static var phongGDButton = Notification.Name("phongGDButton")
    static var truSoChinhButton = Notification.Name("truSoChinhButton")
}


class MenuTopView: UIView {
    weak var selectbutton: UIButton?
    @IBOutlet var allButtonList: [UIButton]!
    @IBOutlet weak var atmButton: UIButton!
    @IBOutlet weak var chiNhanhButton: UIButton!
    @IBOutlet weak var phongGDButton: UIButton!
    @IBOutlet weak var truSoChinhButton: UIButton!
    
    @IBOutlet weak var checkAll: UIButton!
    //    @IBOutlet weak var coverButtonAdress: UIButton!
    @IBOutlet weak var coverButton: UIButton!
    @IBAction func clickButton(_ sender: Any) {
        isOpen = false
    }
    
    @IBAction func onClickSelectAllButton(_ sender: UIButton) {
        allButtonList.forEach{
            $0.isSelected = checkAll.isSelected
        }
        checkAll.isSelected.toggle()
    }
    @IBAction func ckeckAddress(_ sender: UIButton) {
        sender.isSelected.toggle()
        switch sender {
        case atmButton:
            NotificationCenter.default.post(name: .atm, object: atmButton, userInfo: nil)
        case  chiNhanhButton:
            NotificationCenter.default.post(name: .chiNhanhButton, object: chiNhanhButton, userInfo: nil)
        case phongGDButton:
            NotificationCenter.default.post(name: .phongGDButton, object: nil, userInfo: nil)
        case truSoChinhButton:
            NotificationCenter.default.post(name: .truSoChinhButton, object: nil, userInfo: nil)
            
        default:
            break
        }
        checkAll.isSelected = allButtonList.filter{$0.isSelected}.count == 0
    }
    
    var isOpen:Bool = false {
        didSet {
            coverButton.alpha = isOpen ? 0.6 : 0
            self.alpha = self.isOpen ? 1 : 0
            if !isOpen {
                self.removeFromSuperview()
                selectbutton?.isSelected = false
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        allButtonList.forEach{$0.isSelected = true}
        checkAll.isSelected = false
        
    }
    
}

