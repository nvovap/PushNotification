//
//  ViewController.swift
//  PushNotification
//
//  Created by nvovap on 5/16/16.
//  Copyright © 2016 nvovap. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            print("session \(session) occurred error \(error?.localizedDescription)")
        } else {
//            print("session \(session), response: \(NSString(data: responseData, encoding: NSUTF8StringEncoding))")
        }
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let uploadProgress: Float = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        print("session \(session) uploaded \(uploadProgress * 100)%.")
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        print("session \(session), received response \(response)")
        completionHandler(NSURLSessionResponseDisposition.Allow)
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
//        responseData.appendData(data)
    }

    @IBAction func uploadFile() {
        
        let fileName = "1.jpg"
        
        
        let bundle = NSBundle.mainBundle()
        
        if  let myFilePath = bundle.pathForResource("1", ofType: "jpg") {
            
            if let data = NSData(contentsOfFile: myFilePath) {
                let req = NSMutableURLRequest(URL: NSURL(string: "https://testftp.herokuapp.com/igor")!)
                
                req.HTTPMethod = "POST"
                req.timeoutInterval = 10.0
                
                
                let boundary = "-----Boundary\(arc4random())\(arc4random())"
                let boundaryStart = "--\(boundary)\r\n"
                let boundaryEnd = "--\(boundary)--\r\n"
                
                
                let contentType = "multipart/form-data; boundary=\(boundary)"
                req.setValue(contentType, forHTTPHeaderField: "Content-Type")
                
                
                let body = NSMutableData()
                let tempData = NSMutableData()
                let mimeType = "data"
                
                tempData.appendData("\(boundaryStart)".dataUsingEncoding(NSUTF8StringEncoding)!)
                tempData.appendData("Content-Disposition: form-data; name=\"description\"\r\n\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                
                
                //File
                tempData.appendData("\(boundaryStart)".dataUsingEncoding(NSUTF8StringEncoding)!)
                let fileNameContentDisposition =  "filename=\"\(fileName)\""
                let contentDisposition = "Content-Disposition: form-data; name=\"\(mimeType)\"; \(fileNameContentDisposition)\r\n"
                
                
                tempData.appendData(contentDisposition.dataUsingEncoding(NSUTF8StringEncoding)!)
                tempData.appendData("Content-Type: application/octet-stream\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                tempData.appendData(data)
                tempData.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
                
                
                body.appendData(tempData)
                
                body.appendData("\r\n\(boundaryEnd)".dataUsingEncoding(NSUTF8StringEncoding)!)
                
                
                
                req.setValue("\(body.length)", forHTTPHeaderField: "Content-Length")
                
                
//                let path = NSTemporaryDirectory().stringByAppendingString("Heder.txt")
//                
//                print(path)
//                
//                body.writeToFile(path, atomically: false)
//                
//                
//                print(String(data: body, encoding: NSUTF8StringEncoding))
                
                req.HTTPBody = body
                
                
                let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
                configuration.timeoutIntervalForRequest = 12
                configuration.timeoutIntervalForResource = 12
                let session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
                let task = session.uploadTaskWithRequest(req, fromData: data)
                task.resume()
            }
            
        }
        
    }
}

