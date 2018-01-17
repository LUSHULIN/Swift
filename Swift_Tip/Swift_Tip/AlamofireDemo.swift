//
//  AlamofireDemo.swift
//  Swift_Tip
//  练习使用Alamofire网络库
//  Created by Jason on 16/01/2018.
//  Copyright © 2018 陆林. All rights reserved.
//

import UIKit
import Alamofire


class AlamofireDemo: UIViewController {

    var imageView:UIImageView?
    var fileManager = FileManager.default
    
    var downloadRequest:DownloadRequest!
    var progress:UIProgressView!
    var progressLabel:UILabel!
    
    var cancelledData:Data!
    var cancelDownImage:UIButton!
    var continueButton:UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let downImageButton = UIButton.init(type: UIButtonType.roundedRect)
        downImageButton.frame = CGRect.init(x: 100, y: 100, width: 100, height: 40)
        downImageButton.setTitle("下载照片", for: UIControlState.normal)
        downImageButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        downImageButton.addTarget(self, action: #selector(downExample), for:UIControlEvents.touchUpInside)
        downImageButton.backgroundColor = UIColor.red
        self.view.addSubview(downImageButton)
        
        cancelDownImage = UIButton.init(type: UIButtonType.roundedRect)
        cancelDownImage.frame = CGRect.init(x: 400, y: 100, width: 100, height: 40)
        cancelDownImage.setTitle("取消下载", for: UIControlState.normal)
        cancelDownImage.setTitleColor(UIColor.white, for: UIControlState.normal)
        cancelDownImage.addTarget(self, action: #selector(cancelDownImageAction), for:UIControlEvents.touchUpInside)
        cancelDownImage.backgroundColor = UIColor.red
        self.view.addSubview(cancelDownImage)
        
        
        continueButton = UIButton.init(type: UIButtonType.roundedRect)
        continueButton.frame = CGRect.init(x: 600, y: 100, width: 100, height: 40)
        continueButton.setTitle("继续下载", for: UIControlState.normal)
        continueButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        continueButton.addTarget(self, action: #selector(continueButtonAction), for:UIControlEvents.touchUpInside)
        continueButton.backgroundColor = UIColor.red
        self.view.addSubview(continueButton)
        
        imageView = UIImageView.init(frame: CGRect.init(x: 100, y: 200, width: 200, height: 200))
        self.view.addSubview(imageView!)
        
        cancelledData = Data()
        progress =  UIProgressView.init(frame: CGRect.init(x: 100, y: 300, width: 500, height: 40))
        self.view.addSubview(progress)
        
        progressLabel = UILabel.init(frame: CGRect.init(x: 100, y: 300, width: 200, height: 30))
        progressLabel.textColor = UIColor.green
        self.view.addSubview(progressLabel)
    }
    
    @objc func downExample() {
       let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask)
        self.downloadRequest =  Alamofire.download(
            "http://dldir1.qq.com/qqfile/qq/QQ7.9/16621/QQ7.9.exe", to: destination)
        self.downloadRequest.downloadProgress(queue: DispatchQueue.main,
                                              closure: downloadProgress) //下载进度
        self.downloadRequest.responseData(completionHandler: downloadResponse) //下载停止响应
        
    }
    
    @objc func cancelDownImageAction() {
        self.downloadRequest.cancel()
        cancelDownImage.isEnabled = false
        self.continueButton.isEnabled = true
    }
    
    @objc func continueButtonAction() {
        self.cancelDownImage.isEnabled = true
        self.continueButton.isEnabled = false
        if let cancelledData = self.cancelledData {
            let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask)
            self.downloadRequest = Alamofire.download(resumingWith: cancelledData,
                                                      to: destination)
            self.downloadRequest.downloadProgress(queue: DispatchQueue.main,
                                                  closure: downloadProgress) //下载进度
            self.downloadRequest.responseData(completionHandler: downloadResponse) //下载停止响应
        }
        
    }
    
    func downloadProgress(progress: Progress) {
        //进度条更新
        self.progress.setProgress(Float(progress.fractionCompleted), animated:true)
        let f = progress.fractionCompleted * 100;
        let prog = String(format:"%2.f",f)
        self.progressLabel.text = "下载进度:\(prog)%"
    }
    
    //下载停止响应（不管成功或者失败）
    func downloadResponse(response: DownloadResponse<Data>) {
        switch response.result {
        case .success(let data):
            //self.image = UIImage(data: data)
            print("文件下载完毕 data大小: \(data.count)")
        case .failure:
            print("下载失败")
            self.cancelledData = response.resumeData //意外终止的话，把已下载的数据储存起来
        }
    }
    
    func downImage() {
        let urlString = "http://t2.hddhhn.com/uploads/tu/20150506/9527-fyLlsw.jpg"
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                self.imageView?.image = UIImage.init(data: response.data!, scale: 1.0)
        }
    }
    
    //自定义报文头
    func customHeader(){
        let headers :HTTPHeaders = [
            "Authorization":"Basic ",
            "Accept":"application/json"
        ]
        Alamofire.request("https://httpbin.org/headers", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
            
        }
    }
    
    //凭证校验
    func authenticate(){
        Alamofire.request("").response(queue: DispatchQueue.global(qos:.utility)) { (response) in
            
        }
        .authenticate(user: "username", password: "password")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
