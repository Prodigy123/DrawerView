//
//  LeftViewController.swift
//  DrawerView
//
//  Created by 吉安 on 14/12/2016.
//  Copyright © 2016 An Ji. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // create items in the left view
    var items:[String]{
        let array = NSArray(objects: "激活会员","QQ钱包","个性装扮","我的收藏","我的相册","我的文件","我的名片夹")
        return array as! [String]
    }
    // create header image
    var headerView: UIView{
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 260))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "scenery")!)
        return view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = UITableView(frame:CGRect(x: 0, y: 200, width: headerView.bounds.width, height: UIScreen.main.bounds.height - 200), style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(patternImage:UIImage(named: "sigle")!)
        view.addSubview(headerView)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier)
        cell = UITableViewCell(style: .default, reuseIdentifier: cellIndentifier)
        cell?.selectionStyle = .none
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.text = items[indexPath.row]
        return cell!
//        let cellIdentifier = "cellIdentifier"
//        
//        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
//        
//        if !(cell != nil) {
//            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
//            cell?.selectionStyle = .none
//            cell?.backgroundColor = UIColor.clear
//        }
//        
//        cell!.textLabel?.text = items[indexPath.row]
//        
//        return cell!

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }

    
  

 
    
    

}
