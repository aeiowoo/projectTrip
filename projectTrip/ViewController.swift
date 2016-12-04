//
//  ViewController.swift
//  projectTrip
//
//  Created by Jeon Myeong Woo on 2016. 11. 26..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
        // TEST
        debugPrint("aaaa")
		
		//환율 테스트
		let urlPath: String = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%3D%22USDKRW%22&format=json&diagnostics=false&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
		let url: NSURL = NSURL(string: urlPath)!
		let request1: NSURLRequest = NSURLRequest(url: url as URL)
		let response: AutoreleasingUnsafeMutablePointer<URLResponse?>?=nil
		
		
		do{
			
			let dataVal = try NSURLConnection.sendSynchronousRequest(request1 as URLRequest, returning: response)
			
			print(response)
			do {
				if let jsonResult = try JSONSerialization.jsonObject(with: dataVal, options: []) as? NSDictionary {
					print("Synchronous\(jsonResult)")
				}
			} catch let error as NSError {
				print(error.localizedDescription)
			}
			
			
			
		}catch let error as NSError
		{
			print(error.localizedDescription)
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

