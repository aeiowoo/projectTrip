//
//  DBManager.swift
//  projectTrip
//
//  Created by Jeon Myeong Woo on 2016. 12. 10..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import Foundation
import UIKit

class DBManager {
	static let sharedInstance: DBManager = DBManager()
	
	private var trDB: FMDatabase? = nil
	
	private init() {
		
		let fileMgr = FileManager.default
		let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
		let dbPath = dirPaths[0].appendingPathComponent("tripDB.sqlite").path
		
		copyFile(fileName: "tripDB.sqlite")
		
		debugPrint("init")
		debugPrint(dbPath)
		if fileMgr.fileExists(atPath: dbPath as String) {

			debugPrint("file exists")
			trDB = FMDatabase(path: dbPath as String)
			if(trDB!.open()) {
			
				debugPrint("open success")
				let querySQL = "SELECT * FROM TRIP_MASTER"
				
				let results: FMResultSet = (trDB!.executeQuery(querySQL, withArgumentsIn: nil))!
				
				while results.next() == true {
					
					debugPrint(results.columnCount())
					
					let str1: String? = results.string(forColumnIndex: 0)
					let str2: String? = results.string(forColumnIndex: 1)
					
					let str3: String? = results.string(forColumn: "TITLE")
					
					debugPrint(str1!)
					debugPrint(str2!)
					debugPrint(str3!)
				}
				
			}
		}
	}
	
	func getData() {
		
	}
	
	func copyFile(fileName: NSString) {
		
		let bundlePath = Bundle.main.path(forResource: "tripDB", ofType: ".sqlite")
		let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
		let fileManager = FileManager.default
		let fullDestPath = URL(fileURLWithPath: destPath).appendingPathComponent("tripDB.sqlite")
		if fileManager.fileExists(atPath: fullDestPath.path){
			print("Database file is exist")
			print(fileManager.fileExists(atPath: bundlePath!))
		}else{
			do{
				try fileManager.copyItem(atPath: bundlePath!, toPath: fullDestPath.path)
			}catch{
				print("\n",error)
			}
		}
	}
}
