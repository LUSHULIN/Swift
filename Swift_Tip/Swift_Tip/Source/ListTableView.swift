//
//  OneViewController.swift
//  Swift_Tip
//
//  Created by Jason on 16/01/2018.
//  Copyright © 2018 陆林. All rights reserved.
//

import UIKit

class ListTableView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let identifier = "oneViewControllerIdentifier"
    var dataList = ["one","two","three"]
    var isDelIns:Bool!
    var tableView = UITableView()
    let btnEdit:UIButton! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: self.view.frame.size.height - 100))
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
        
        self.view.addSubview(tableView)
        
        let btnEdit = UIButton(frame: CGRect.init(x: 10, y: 80, width: 80, height: 20))
        btnEdit.addTarget(self, action: #selector(insertButtonAction), for: UIControlEvents.touchUpInside)
        btnEdit.setTitle("insert", for: UIControlState.normal)
        btnEdit.setTitleColor(UIColor.red, for: UIControlState.normal)
        self.view.addSubview(btnEdit)
        
        let btnDelete = UIButton(frame: CGRect.init(x: 230, y: 80, width: 80, height: 20))
        btnDelete.addTarget(self, action: #selector(deleteButtonAction), for: UIControlEvents.touchUpInside)
        btnDelete.setTitle("delete", for: UIControlState.normal)
        btnDelete.setTitleColor(UIColor.red, for: UIControlState.normal)
        self.view.addSubview(btnDelete)
    }
    
    @objc func insertButtonAction() {
        isDelIns = false
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
        } else {
            tableView.setEditing(true, animated: true)
        }
        
    }
    
    @objc func deleteButtonAction(){
        isDelIns = true
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
        } else {
            tableView.setEditing(true, animated: true)
        }
        
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if isDelIns {
            return UITableViewCellEditingStyle.delete
        } else {
            return UITableViewCellEditingStyle.insert
        }
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        tableCell.textLabel?.text = dataList[indexPath.row]
        return tableCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = dataList[indexPath.row]
        let alert = UIAlertController.init(title: "友情提示", message: "你点击了:\(message)", preferredStyle: UIAlertControllerStyle.alert)
        let actionOK = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(actionOK)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            dataList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        } else if editingStyle == UITableViewCellEditingStyle.insert {
            dataList.append("新增:\(arc4random()%100)")
            tableView.reloadData()
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
