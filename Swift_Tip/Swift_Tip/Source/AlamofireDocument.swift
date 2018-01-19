
//
//  AlamofireDocument.swift
//  Swift_Tip
//
//  Created by Jason on 18/01/2018.
//  Copyright © 2018 陆林. All rights reserved.
//

import UIKit
import Alamofire

//HTTP Method
public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

class AlamofireDocument: UIViewController {
    var imageView:UIImageView!
    var progress:UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Alamofire 官方文档"
        self.view.backgroundColor = UIColor.white
        
        imageView = UIImageView.init(frame: CGRect.init(x: 100, y: 200, width: 200, height: 200))
        self.view.addSubview(imageView!)
        
        progress =  UIProgressView.init(frame: CGRect.init(x: 100, y: 300, width: 500, height: 40))
        self.view.addSubview(progress)
        
        //1.
//        downImage2Api()
        //2.
        let _imageRequestor = ImageRequestor()
        _imageRequestor.fetchImage { (image) in
            self.imageView.image = image
        }
        
    }
    func loadimage(image:UIImage){
        print("下载完成")
        
    }
    // MARK: - Manual Validation
    func manualValidationNetwork() {
        Alamofire.request("https://httpbin.org/get")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { (response) in
                switch response.result {
                case .success:
                    print("validation success")
                case .failure(let error):
                    print(error)
                }
        }
    }
    /*
     Automatically validates status code within `200..<300` range, and that the `Content-Type` header of the response matches the `Accept` header of the request, if one is provided.
     */
    func automaticValidationNetwork() {
        Alamofire.request("https://httpbin.org/get").validate().responseData { (response) in
            switch response.result {
            case .success:
                print("validation success")
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    //MARK: -custon parameter
    struct JSONStringArrayEncoding: ParameterEncoding {
        private let array: [String]
        
        init(array: [String]) {
            self.array = array
        }
        
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var urlRequest = try urlRequest.asURLRequest()
            
            let data = try JSONSerialization.data(withJSONObject: array, options: [])
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = data
            
            return urlRequest
        }
    }
    
    //MARK -HTTP Basic Authentication
    func autherntication() {
        let user = "Jason"
        let password = "11111"
        //url append user & password
        Alamofire.request("https://httpbin.org/basic-auth/\(user)/\(password)")
            .authenticate(user: user, password: password)
            .responseJSON { response in
                debugPrint(response)
        }
        //headers append user & password
        var headers:HTTPHeaders = [:]
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        Alamofire.request("https://httpbin.org/basic-auth/user/password", headers: headers)
            .responseJSON { response in
                debugPrint(response)
        }
        
        //Authentication with URLCredential
        let credential = URLCredential(user: user, password: password, persistence: .forSession)
        Alamofire.request("https://httpbin.org/basic-auth/\(user)/\(password)")
            .authenticate(usingCredential: credential)
            .responseJSON { response in
                debugPrint(response)
        }
        
    }
    
    func downImageAPI() {
        Alamofire.download("https://httpbin.org/image/png").responseData { response in
            if let data = response.result.value {
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        }
    }
    
    func downImage2Api() {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("pig.png")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download("https://httpbin.org/image/png", to: destination)
            .downloadProgress(queue: DispatchQueue.main) { (progress) in
                self.progress.setProgress(Float(progress.fractionCompleted), animated:true)
            }
            .response { response in
                if response.error == nil, let imagePath = response.destinationURL?.path {
                    let image = UIImage(contentsOfFile: imagePath)
                    self.imageView.image = image
                }
        }
    }
    
    func upload(){
        /*
        //1.上传照片到server
        let imageData = UIImagePNGRepresentation(image)!
        Alamofire.upload(imageData, to: "https://httpbin.org/post").responseJSON { response in
            debugPrint(response)
        }
        //2.上传视频到server
        let fileURL = Bundle.main.url(forResource: "video", withExtension: "mov")
        
        Alamofire.upload(fileURL, to: "https://httpbin.org/post").responseJSON { response in
            debugPrint(response)
        }
        //3.上传可变的data到server
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(unicornImageURL, withName: "unicorn")
                multipartFormData.append(rainbowImageURL, withName: "rainbow")
        },
            to: "https://httpbin.org/post",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
        //4.上传进度
        let fileURL2 = Bundle.main.url(forResource: "video", withExtension: "mov")
        
        Alamofire.upload(fileURL2!, to: "https://httpbin.org/post")
            .uploadProgress { progress in // main queue by default
                print("Upload Progress: \(progress.fractionCompleted)")
            }
            .downloadProgress { progress in // main queue by default
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .responseJSON { response in
                debugPrint(response)
        }
        
    }
 */
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
