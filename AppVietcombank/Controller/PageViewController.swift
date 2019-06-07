//
//  PageViewController.swift
//  DemoSileMenu_infinitely
//
//  Created by Anh vũ on 6/2/19.
//  Copyright © 2019 anh vu. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    // lay tung man hinh
     var subviewcontroller: [UIViewController] = {
        return [UIStoryboard(name: "InterestRate", bundle: nil).instantiateViewController(withIdentifier: "man1") as! ViewController1 ,
                UIStoryboard(name: "InterestRate", bundle: nil).instantiateViewController(withIdentifier: "man2")as! ViewController2 ,
                UIStoryboard(name: "InterestRate", bundle: nil).instantiateViewController(withIdentifier: "man3") as! ViewController3 ]
               
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        setViewControllers([subviewcontroller[0]], direction: .forward, animated: true, completion: nil)
    }
    //     kieu vuot qua
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    
    // dem man hinh
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subviewcontroller.count
    }
    //     lui man hinh
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = subviewcontroller.index(of: viewController) ?? 0
        if currentIndex <= 0{
            return subviewcontroller[currentIndex + 2]
        }
        return subviewcontroller[currentIndex-1]
    }
    //     tien man hinh
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var currentIndex = subviewcontroller.index(of: viewController) ?? 0
        if currentIndex >= subviewcontroller.count - 1 {
            return subviewcontroller[currentIndex - 2]
        }
        return subviewcontroller[currentIndex + 1]
    }
}
