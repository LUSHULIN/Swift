//
//  ImageRequestor.swift
//  Swift_Tip
//
//  Created by Jason on 18/01/2018.
//  Copyright © 2018 陆林. All rights reserved.
//

import UIKit
import Alamofire

class ImageRequestor: NSObject {
    private var resumeData: Data?
    private var image: UIImage?
    
    func fetchImage(completion: (UIImage?) -> Void) {
        guard image == nil else { completion(image) ; return }
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("pig.png")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let request: DownloadRequest
        
        if let resumeData = resumeData {
            
            request = Alamofire.download(resumingWith: resumeData)
            
        } else {
            request = Alamofire.download("https://httpbin.org/image/png")
        }
        
        request.responseData { response in
            switch response.result {
            case .success(let data):
                self.image = UIImage(data: data)
            case .failure:
                self.resumeData = response.resumeData
            }
        }
    }
}
