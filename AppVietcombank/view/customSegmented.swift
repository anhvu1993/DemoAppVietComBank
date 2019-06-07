//
//  customSegmented.swift
//  AppVietcombank
//
//  Created by Anh vũ on 6/6/19.
//  Copyright © 2019 anh vu. All rights reserved.
//
import UIKit
class TabySegmentedControl: UISegmentedControl {
    func initUI(){
        setupBackground()
        setupFonts()
    }
    
    func setupBackground(){
        let backgroundImage = UIImage(named: "segmented_unselected_bg")
        let dividerImage = UIImage(named: "segmented_separator_bg")
        let backgroundImageSelected = UIImage(named: "segmented_selected_bg")
        
        self.setBackgroundImage(backgroundImage, for: UIControl.State(), barMetrics: .default)
        self.setBackgroundImage(backgroundImageSelected, for: .highlighted, barMetrics: .default)
        self.setBackgroundImage(backgroundImageSelected, for: .selected, barMetrics: .default)
        
        self.setDividerImage(dividerImage, forLeftSegmentState: UIControl.State(), rightSegmentState: .selected, barMetrics: .default)
        self.setDividerImage(dividerImage, forLeftSegmentState: .selected, rightSegmentState: UIControl.State(), barMetrics: .default)
        self.setDividerImage(dividerImage, forLeftSegmentState: UIControl.State(), rightSegmentState: UIControl.State(), barMetrics: .default)
    }
    
    func setupFonts(){
        let font = UIFont.systemFont(ofSize: 16.0)
        
        
        let normalTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: font
        ]
        
        self.setTitleTextAttributes(normalTextAttributes, for: UIControl.State())
        self.setTitleTextAttributes(normalTextAttributes, for: .highlighted)
        self.setTitleTextAttributes(normalTextAttributes, for: .selected)
    }
    
}
