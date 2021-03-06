//
//  CountryData.swift
//  projectTrip
//
//  Created by Jeon Myeong Woo on 2016. 12. 17..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import Foundation

class CountryData
{
	private(set) var countryCode: String
	private(set) var countryName: String
	private(set) var korCountryName: String
	private(set) var currencyCode: String
	private(set) var imgPath: String
	
	init(countryCode code: String, countryName name: String, korCountryName korName: String,
	     currencyCode currCode: String, imgPath path: String)
	{
		countryCode = code
		countryName = name
		korCountryName = korName
		currencyCode = currCode
		imgPath = path
	}
}
