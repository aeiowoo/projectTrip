//
//  TRDataExtension.swift
//  projectTrip
//
//  Created by Jeon Myeong Woo on 2016. 12. 13..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import Foundation

extension Date
{
	func toString() -> String
	{
		return toString(format: DEFAULT_DATE_FORMAT)
	}
	
	func toString(format: String) -> String
	{
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.string(from: self)
	}
}

extension String
{
	func toDate() -> Date
	{
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = DEFAULT_DATE_FORMAT
		return dateFormatter.date(from: self)!
	}
}
