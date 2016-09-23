//
//  CommonProcess.swift
//  project
//
//  Created by Nixforest on 9/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import Foundation
class CommonProcess {
    static func requestLogin(username: String, password: String) {
        let url:URL = URL(string: Singleton.sharedInstance.getServerURL() + "/api/site/login")!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        // Make data string
        let dataStr: String = String(format: "{\"username\":\"%@\",\"password\":\"%@\",\"gcm_device_token\":\"1\",\"apns_device_token\":\"1\",\"type\":\"2\"}",
                                     username, password)
        let paramString = "q=" + dataStr
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            // Check error
            guard error == nil else {
                print(error)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            //guard let _:Data = data, let _:URLResponse = response  , error == nil else {
            //    print("error")
            //    return
            //}
            
//            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            print(dataString)
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            //print(json)
            

            if let json = json as? [String: Any] {
                print(json["status"])
                print(json["user_id"])
                print(json["message"])
                print(json["need_change_pass"])
                
                let status = json["status"]!
                if ((status.compare("1")) != nil) {
                    Singleton.sharedInstance.loginSuccess(json["token"]! as! String)
                }
                print(Singleton.sharedInstance.getUserToken())
            }
        })
        
        task.resume()
    }
}
