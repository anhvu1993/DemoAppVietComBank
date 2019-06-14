//
//  PopupView.swift
//  AppVietcombank
//
//  Created by Anh vũ on 5/29/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit
extension Notification.Name {
    static var showAllButton = Notification.Name("showAll")
    static var showAtm       = Notification.Name("showAtm")
    static var showBranch    = Notification.Name("showBranch")
}
class MenuTopView: UIView {
    weak var selectbutton: UIButton?
    @IBOutlet var allButtonList: [UIButton]!
    @IBOutlet weak var showAtm: UIButton!
    @IBOutlet weak var showBranch: UIButton!
    @IBOutlet weak var showAll: UIButton!
    
    @IBOutlet weak var checkAll: UIButton!
    //    @IBOutlet weak var coverButtonAdress: UIButton!
    @IBOutlet weak var coverButton: UIButton!
    @IBAction func clickButton(_ sender: Any) {
        isOpen = false
    }
    
    @IBAction func onClickSelectAllButton(_ sender: UIButton) {
        switch sender {
        case showAll:
        NotificationCenter.default.post(name: .showAllButton, object: showAll, userInfo: nil)
        default:
            break
        }
        allButtonList.forEach{
            $0.isSelected = checkAll.isSelected
        }
        checkAll.isSelected.toggle()
    }
    @IBAction func ckeckAddress(_ sender: UIButton) {
        sender.isSelected.toggle()
        switch sender {
        case showAtm:
            NotificationCenter.default.post(name: .showAtm, object: showAtm, userInfo: nil)
        case  showBranch:
            NotificationCenter.default.post(name: .showBranch, object: showBranch, userInfo: nil)
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

