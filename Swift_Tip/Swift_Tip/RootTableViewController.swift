//
//  TableViewController.swift
//  Swift_Tip
//
//  Created by Jason on 16/01/2018.
//  Copyright © 2018 陆林. All rights reserved.
//

import UIKit

enum ViewControllerType:String {
    case one = "列表展示"
    case two = "首页"
    case three = "Alamofire"
    case four = "其他功能"
}

class RootTableViewController: UITableViewController {
    var dataList = [String]()
    let identifier = "iOS CELL iDENTIFIER"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift列表展示"
        dataList = ["列表展示","首页","Alamofire","其他功能"]
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = dataList[indexPath.row]
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option:ViewControllerType = ViewControllerType(rawValue: dataList[indexPath.row])!
        switch option {
        case ViewControllerType.one:
            let listTable = ListTableView()
            listTable.title = dataList[indexPath.row]
            self.navigationController?.pushViewController(listTable, animated: true)
            
        case ViewControllerType.two:
            let twoVC:TwoViewController = TwoViewController()
            twoVC.title = dataList[indexPath.row]
            self.navigationController?.pushViewController(twoVC, animated: true)
            
        case ViewControllerType.three:
            let alamofire = AlamofireDemo()
            alamofire.title = "AlamofireDemo"
            self.navigationController?.pushViewController(alamofire, animated: true)
            
        default:
            let alertVC = UIAlertController.init(title: "友情提示:", message: "该界面暂未实现", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler:{(okAction:UIAlertAction) in
                print("你点击了确定按钮")
                
            })
            let cancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (cancelAction:UIAlertAction) in
                print("你点击了取消按钮")
            })
            
            alertVC.addAction(ok);
            alertVC.addAction(cancel)
            self.present(alertVC, animated: true, completion: nil)
            
            
        }
        
    }

}
