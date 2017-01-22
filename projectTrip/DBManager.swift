//
//  DBManager.swift
//  projectTrip
//
//  Created by Jeon Myeong Woo on 2016. 12. 10..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import Foundation

class DBManager
{
	//싱글톤 매니저 변수
	static private let sharedInstance: DBManager = DBManager()
	
	private var trDB: FMDatabase? = nil
	
	private class func copyFile() -> Bool
	{
		let fileManager = FileManager.default
		let localDBpath = Bundle.main.path(forResource: DB_FILE_NAME, ofType: DB_FILE_TYPE)
		let deviceDocPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
		let deviceDBpath = URL(fileURLWithPath: deviceDocPath).appendingPathComponent(DB_FILE_FULLNAME)
		
		if fileManager.fileExists(atPath: deviceDBpath.path)
		{
			return false
		}
		else
		{
			do
			{
				try fileManager.copyItem(atPath: localDBpath!, toPath: deviceDBpath.path)
			}
			catch
			{
				return false
			}
			return true
		}
	}
	
	class func getData(query: String) -> Array<Array<String>>?
	{
		var dataArr: Array<Array<String>>? = nil
		
		if !DBManager.copyFile()
		{
			debugPrint("DB file copy failed")
		}
		
		let fileManager = FileManager.default
		let deviceDocPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
		let deviceDBpath = URL(fileURLWithPath: deviceDocPath).appendingPathComponent(DB_FILE_FULLNAME)
		
		if fileManager.fileExists(atPath: deviceDBpath.path)
		{
			sharedInstance.trDB = FMDatabase(path: deviceDBpath.path)
			if (sharedInstance.trDB?.open())!
			{
				dataArr = Array<Array<String>>()
				let queryResults: FMResultSet = (sharedInstance.trDB!.executeQuery(query, withArgumentsIn: nil))!

				while queryResults.next() == true
				{
					var oneRowData = Array<String>()
					for index in 0...queryResults.columnCount() - 1
					{
						let oneColumnData = queryResults.string(forColumnIndex: index) ?? ""
						oneRowData.append(oneColumnData)
					}
					dataArr!.append(oneRowData)
				}
			}
		}
		return dataArr
	}
	
	class func setData(query: String) -> Bool
	{
		if !DBManager.copyFile()
		{
			debugPrint("DB file copy failed")
		}
		
		let fileManager = FileManager.default
		let deviceDocPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
		let deviceDBpath = URL(fileURLWithPath: deviceDocPath).appendingPathComponent(DB_FILE_FULLNAME)
		
		if fileManager.fileExists(atPath: deviceDBpath.path)
		{
			sharedInstance.trDB = FMDatabase(path: deviceDBpath.path)
			if (sharedInstance.trDB?.open())!
			{
				if sharedInstance.trDB!.executeUpdate(query, withArgumentsIn: nil)
				{
					return true
				}
			}
		}
		return false
	}
}
