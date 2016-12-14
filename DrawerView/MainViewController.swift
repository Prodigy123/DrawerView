//
//  MainViewController.swift
//  DrawerView
//
//  Created by 吉安 on 14/12/2016.
//  Copyright © 2016 An Ji. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        self.addChildViewController(NewsViewController(), "消息", defaultImageName: "tab_news_nor",selectedImageName: "tab_news_press")
        self.addChildViewController(ContactsViewController(), "联系人", defaultImageName: "tab_contact_nor", selectedImageName: "tab_contact_press")
        self.addChildViewController(DynamicViewController(), "动态", defaultImageName: "tab_star_nor",selectedImageName: "tab_star_press")
        // Do any additional setup after loading the view.
    }

    func addChildViewController(_ childController: UIViewController,_ title: NSString, defaultImageName: NSString, selectedImageName: NSString) {
        let navViewController = UINavigationController(rootViewController: childController)
        
        self.addChildViewController(navViewController)
        
        childController.tabBarItem.image = UIImage(named: defaultImageName as String)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName as String)
        
        childController.title = title as String
        
        if title.isEqual(to: "消息") {
            let segmentedControl = UISegmentedControl(items: NSArray(objects: "消息","电话") as? [Any])
            segmentedControl.selectedSegmentIndex = 0
            segmentedControl.frame = CGRect(x: 0, y: 0, width: 160, height: 40)
            segmentedControl.setTitle("消息", forSegmentAt: 0)
            segmentedControl.setTitle("电话", forSegmentAt: 1)
            childController.navigationItem.titleView = segmentedControl
            childController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "profileImage"), style: .plain , target: self, action: (#selector(MainViewController.openDrawer)))
        }

    }
    func openDrawer(){
        DrawerViewController.sharedDrawerViewController.openDrawer(openDuration: 0.2)
    }
    func panGestureRecognizer(pan: UIPanGestureRecognizer) {
        DrawerViewController.sharedDrawerViewController.panGestureRecognizer(pan: pan)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
