//
//  NetworkManager.swift
//  projectTrip
//
//  Created by 박은비 on 2016. 12. 4.
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import Foundation


class NetworkManager {
    
    private init() {
        
    }
    
    // http request
    /** example
     * // 요청 보낼 url 정의
     * let urlPath: String = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%3D%22USDKRW%22&format=json&diagnostics=false&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
     * // 응답값을 처리할 콜백함수 선언
     * let callback = {
     *   (response:NSDictionary?)->Void
     *    in
     *  // debugPrint("\(response!)");
     *  // 응답값 처리할 부분 구현
     * }
     *
     * // 요청 보내기
     * NetworkManager.sendRequest(reqUrl: urlPath, reqMethod: "GET", callback:callback)
     **/
    
    static func sendRequest(reqUrl: String, reqMethod: String, callback: ((NSDictionary?)->Void)!) {
        
        // debugPrint(makeParameter(parameterDic:testDic))
        
        let url = NSURL(string: reqUrl)!
        let request: URLRequest = URLRequest(url: url as URL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            callback!(makeResponse(data: data!))
        })
        
        task.resume()
        
    }
    
    // TODO : parameter dictionary to get request parameter format 변환 작업 필요
    // make parameter
    static func makeRequest(parameterDic: NSDictionary?) -> String? {
        
        if (parameterDic != nil) {
            debugPrint("test1")
            do {
                
                debugPrint("test2 \(parameterDic!)")
                
                // TODO : always fails -> 수정필요
                /*if let jsonObj = try JSONSerialization.data(withJSONObject: parameterDic!, options: []) as? String {
                    
                    return jsonObj
                } */
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        return nil
        
    }
    
    // response data to nsdictionary
    static func makeResponse(data: Data?) -> NSDictionary? {//[String: Any]? {
        
        do {
            if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                //debugPrint("Response = \(jsonResult)")
                
                return jsonResult
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
