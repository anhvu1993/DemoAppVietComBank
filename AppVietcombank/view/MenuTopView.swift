//
//  PopupView.swift
//  AppVietcombank
//
//  Created by Anh vũ on 5/29/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit
class MenuTopView: UIView {
    weak var selectbutton: UIButton?
    @IBOutlet var Check: [UIButton]!
    @IBOutlet weak var CheckAll: UIButton!
    //    @IBOutlet weak var coverButtonAdress: UIButton!
    @IBOutlet weak var coverButton: UIButton!
    @IBAction func clickButton(_ sender: Any) {
        isOpen = false
    }
    var isSelectedAll = true {
        didSet {
            let title = isSelectedAll ? "Chọn Tất cả" : "Bỏ chọn"
            CheckAll.setTitle(title, for: .normal)
        }
    }
    @IBAction func check(_ sender: UIButton) {
        Check.forEach{
        $0.isSelected = isSelectedAll
        }
        isSelectedAll = !isSelectedAll
    }
    @IBAction func ckeckAddress(_ sender: UIButton) {
        sender.isSelected.toggle()
        isSelectedAll = Check.filter{$0.isSelected}.count == 0
    }
    
    //    @IBAction func clickButtonAdress(_ sender: Any) {
    //        onAdress = false
    //    }
    //
    //    @IBAction func offAdress(_ sender: Any) {
    //        onAdress = false
    //    }
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
    }
    //
    //    var onAdress: Bool = false {
    //        didSet {
    //            coverButtonAdress.alpha = onAdress ? 0.6 : 0
    //            self.alpha = self.onAdress ? 1 : 0
    //            if !onAdress {
    //                self.removeFromSuperview()
    //                selectbutton?.isSelected = false
    //            }
    //        }
    //    }
    //
}

