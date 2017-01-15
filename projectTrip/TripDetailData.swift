//
//  TripDetailData.swift
//  projectTrip
//
//  Created by Jeon Myeong Woo on 2016. 12. 17..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import Foundation

enum MoneyType: String
{
	case Cash = "CASH", Card = "CARD"
	
	static let allValues = [Cash, Card]
}

enum UsedCode: String
{
	case Dining = "DIN", Shopping = "SHP", SightSeeing = "SEE", Transportation = "TRP", Stay = "STY", Etc = "ETC"
	
	static let allValues = [Dining, Shopping, SightSeeing, Transportation, Stay, Etc]
}

class TripDetailData
{
	private(set) var id: Int = -1
	private(set) var masterId: Int = -1
	
	var moneyType: MoneyType = .Cash
	var usedCode: UsedCode = .Etc
	var title: String = ""
	var desc: String = ""
	var imgPath: String = ""
	
	private var _usedDate: Date?
	var usedDate: String
	{
		get
		{
			if let uDate = _usedDate
			{
				return uDate.toString()
			}
			return ""
		}
		set(newValue)
		{
			_usedDate = newValue.toDate()
		}
	}
	
	private var _usedMoney: Float = 0.0
	var usedMoney: Float
	{
		get
		{
			return _usedMoney
		}
		set(newValue)
		{
			if newValue < 0.0
			{
				_usedMoney = 0.0
				assertionFailure("[TripDetailData] 사용 금액 음수 설정 오류, Id: \(id), UsedMoney: (\(newValue))")
			}
			else
			{
				_usedMoney = newValue
			}
		}
	}
	
	private var _usedMoneySign: String = ""
	var usedMoneyIsPositive: Bool
	{
		get
		{
			return _usedMoneySign == "+" ? true : false
		}
		set(newValue)
		{
			_usedMoneySign = newValue ? "+" : ""
		}
	}
	
	init(id dId: Int,
	     masterId mId: Int,
	     moneyType type: MoneyType,
	     usedCode code: UsedCode,
	     usedDate date: String,
	     usedMoney money: Float,
	     title t: String,
	     desc d: String,
	     imgPath path: String)
	{
		customInit(id: dId, masterId: mId, moneyType: type, usedCode: code, usedDate: date, usedMoney: money, title: t, desc: d, imgPath: path)
	}
	
	private func customInit(id dId: Int,
	                        masterId mId: Int,
	                        moneyType type: MoneyType,
	                        usedCode code: UsedCode,
	                        usedDate date: String,
	                        usedMoney money: Float,
	                        title t: String,
	                        desc d: String,
	                        imgPath path: String)
	{
		id = dId
		masterId = mId
		moneyType = type
		usedCode = code
		usedDate = date
		usedMoney = money
		title = t
		desc = d
		imgPath = path
	}
}
