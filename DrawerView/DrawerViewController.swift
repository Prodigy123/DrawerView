//
//  ViewController.swift
//  DrawerView
//
//  Created by 吉安 on 14/12/2016.
//  Copyright © 2016 An Ji. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController {
    
    //create singleton
    static let sharedDrawerViewController = DrawerViewController()
    
    var leftViewController: LeftViewController?
    var mainViewController: MainViewController?
    var drawerWidth: CGFloat?
    var coverButton: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        setCoverButton()
        view.backgroundColor = UIColor.white
        self.leftViewController?.view.transform = CGAffineTransform(translationX: -drawerWidth!, y: 0.0)
        for childVC in (mainViewController?.childViewControllers)!{
            addScreenEdgePanGestureRecognizer(view: childVC.view)
        }
    }
    class func createDrawer(leftViewController: LeftViewController, mainViewController: MainViewController, drawerWidth: CGFloat)-> DrawerViewController{
        let drawerViewController = DrawerViewController.sharedDrawerViewController
        drawerViewController.leftViewController = leftViewController
        drawerViewController.mainViewController = mainViewController
        drawerViewController.drawerWidth = drawerWidth
        drawerViewController.view.addSubview(leftViewController.view)
        drawerViewController.addChildViewController(leftViewController)
        drawerViewController.view.addSubview(mainViewController.view)
        drawerViewController.addChildViewController(mainViewController)
        return drawerViewController
    }
    
    func setCoverButton() {
        
        guard self.coverButton != nil else {
            let coverButton = UIButton.init()
            self.coverButton = coverButton
            coverButton.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            coverButton.addTarget(self, action: (#selector(DrawerViewController.closeDrawer)), for: .touchUpInside)
            addPanGestureRecognizer(view: coverButton)
            return
        }
    }

    func panGestureRecognizer(pan: UIPanGestureRecognizer) {
        let offsetX = pan.translation(in: pan.view).x
        
        if pan.state == .cancelled || pan.state == .failed || pan.state == .ended {
            
            if offsetX < 0 , UIScreen.main.bounds.width - self.drawerWidth! + abs(offsetX) > UIScreen.main.bounds.width * 0.5{
                closeDrawer(closeDuration: (self.drawerWidth! + offsetX) / self.drawerWidth! * 0.2)
            }else{
                openDrawer(openDuration:abs(offsetX) / self.drawerWidth! * 0.2)
            }
            
        }else if pan.state == .changed{
            if offsetX < 0 , offsetX > -self.drawerWidth! {
                mainViewController?.view.transform = CGAffineTransform.init(translationX: self.drawerWidth! + offsetX, y: 0)
                leftViewController?.view.transform = CGAffineTransform.init(translationX: offsetX, y: 0)
            }
        }
        
    }
    func addPanGestureRecognizer(view: UIView) {
        let pan = UIPanGestureRecognizer.init(target: self.mainViewController, action: (#selector(MainViewController.panGestureRecognizer(pan:))))
        view.addGestureRecognizer(pan)
    }
    
    
    // pan from edge
    func addScreenEdgePanGestureRecognizer(view: UIView) {
        let pan = UIScreenEdgePanGestureRecognizer(target: self, action: (#selector(DrawerViewController.screenEdgePanGestureRecognizer(pan:))))
        pan.edges = UIRectEdge.left
        view.addGestureRecognizer(pan)
    }
    func screenEdgePanGestureRecognizer(pan: UIScreenEdgePanGestureRecognizer) {
        
        let offsetX = pan.translation(in: pan.view).x
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            if pan.state == UIGestureRecognizerState.changed && offsetX < self.drawerWidth! {
                self.mainViewController?.view.transform = CGAffineTransform.init(translationX: offsetX, y: 0)
                self.leftViewController?.view.transform = CGAffineTransform.init(translationX: -self.drawerWidth! + offsetX, y: 0)
            }else if pan.state == .cancelled || pan.state == .ended || pan.state == .failed {
                if offsetX > UIScreen.main.bounds.width * 0.5 {
                    self.openDrawer(openDuration: (self.drawerWidth! - offsetX)/self.drawerWidth! * 0.2)
                }else {
                    self.closeDrawer(closeDuration: offsetX / self.drawerWidth! * 0.2)
                }
            }
        });
        
    }

    // open drawer
    func openDrawer(openDuration: CGFloat){
        UIView.animate(withDuration: TimeInterval(openDuration), delay: 0.0, options: .curveLinear, animations: {
            self.mainViewController?.view.transform = CGAffineTransform(translationX: self.drawerWidth!, y: 0.0)
            self.leftViewController?.view.transform = CGAffineTransform.identity
        }){ (Bool) in
            
            self.setCoverButton()
            
            self.mainViewController?.view.addSubview(self.coverButton!)
        }
    }
    // close closeDrawer
    func closeDrawer(closeDuration: CGFloat){
        UIView.animate(withDuration: TimeInterval(closeDuration), delay: 0.0, options: .curveLinear, animations: {
            self.mainViewController?.view.transform = CGAffineTransform.identity
            self.leftViewController?.view.transform = CGAffineTransform(translationX: -self.drawerWidth!, y: 0.0)

            }){ (Bool) in
                
                self.coverButton?.removeFromSuperview()
                self.coverButton = nil        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    // create drawer 
    

}

