//
//  TRData.swift
//  projectTrip
//
//  Created by Jeon Myeong Woo on 2016. 12. 11..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import Foundation

class TripMasterData
{
	var title: String = ""
	var countryCode: String = ""
	var expCurrencyCode: String = ""
	var stdCurrencyCode: String = ""
	var imgPath: String = ""
	
	private(set) var id: Int = -1
	private(set) var createDate: String = ""
	private(set) var updateDate: String = ""
	
	private var _startDate: Date?
	var startDate: String
	{
		get
		{
			if let sDate = _startDate
			{
				return sDate.toString()
			}
			return ""
		}
		set(newValue)
		{
			let sDate = newValue.toDate()
			if let eDate = _endDate, sDate <= eDate
			{
				_startDate = sDate
			}
			else
			{
				_startDate = nil
				assertionFailure("[TripMasterData] 여행 기간 설정 오류, Id: \(id), StartDate: (\(sDate)), EndDate: (\(_endDate))")
			}
		}
	}
	
	private var _endDate: Date?
	var endDate: String
	{
		get
		{
			if let eDate = _endDate
			{
				return eDate.toString()
			}
			return ""
		}
		set(newValue)
		{
			let eDate = newValue.toDate()
			if let sDate = _startDate, sDate <= eDate
			{
				_endDate = eDate
			}
			else
			{
				_endDate = nil
				assertionFailure("[TripMasterData] 여행 기간 설정 오류, Id: \(id), StartDate: (\(_startDate)), EndDate: (\(eDate))")
			}
		}
	}
	
	private var _budget: Float = 0.0
	var budget: Float
	{
		get
		{
			return _budget
		}
		set(newValue)
		{
			if newValue < 0.0
			{
				_budget = 0.0
				assertionFailure("[TripMasterData] 예산 음수 설정 오류, Id: \(id), Budget: (\(newValue))")
			}
			else
			{
				_budget = newValue
			}
		}
	}
	
	private var _exchangeRate: Float = 0.0
	var exchangeRate: Float
	{
		get
		{
			return _exchangeRate
		}
		set(newValue)
		{
			if newValue < 0.0
			{
				_exchangeRate = 0.0
				assertionFailure("[TripMasterData] 환율 음수 설정 오류, Id: \(id), ExchangeRate: (\(newValue))")
			}
			else
			{
				_exchangeRate = newValue
			}
		}
	}
	
	private var _currencyDailyUpdate: String = "N"
	var currencyDailyUpdate: Bool
	{
		get
		{
			return _currencyDailyUpdate == "Y" ? true : false
		}
		set(newValue)
		{
			_currencyDailyUpdate = newValue ? "Y" : "N"
		}
	}
	
	private var _currencyUpdateTime: Date?
	var currencyUpdateTime: String
		{
		get
		{
			if let uDate = _currencyUpdateTime
			{
				return uDate.toString()
			}
			return ""
		}
		set(newValue)
		{
			_currencyUpdateTime = newValue.toDate()
		}
	}
	
	init(id i: Int,
	     title t: String,
	     startDate sDate: String,
	     endDate eDate: String,
	     countryCode code: String,
	     expCurrencyCode eCurrCode: String,
	     stdCurrencyCode sCurrCode: String,
	     budget b: Float,
	     exchangeRate rate: Float,
	     currencyDailyUpdate cUpdate: Bool,
	     currencyUpdateTime cUpdateTime: String,
	     imgPath path: String,
	     createDate cDate: String,
	     updateDate uDate: String)
	{
		customInit(id: i, title: t, startDate: sDate, endDate: eDate, countryCode: code, expCurrencyCode: eCurrCode,
		           stdCurrencyCode: sCurrCode, budget: b, exchangeRate: rate, currencyDailyUpdate: cUpdate,
		           currencyUpdateTime: cUpdateTime, imgPath: path, createDate: cDate, updateDate: uDate)
	}
	
	private func customInit(id i: Int,
	                        title t: String,
	                        startDate sDate: String,
	                        endDate eDate: String,
	                        countryCode code: String,
	                        expCurrencyCode eCurrCode: String,
	                        stdCurrencyCode sCurrCode: String,
	                        budget b: Float,
	                        exchangeRate rate: Float,
	                        currencyDailyUpdate cUpdate: Bool,
	                        currencyUpdateTime cUpdateTime: String,
	                        imgPath path: String,
	                        createDate cDate: String,
	                        updateDate uDate: String)
	{
		id = i
		title = t
		startDate = sDate
		endDate = eDate
		countryCode = code
		expCurrencyCode = eCurrCode
		stdCurrencyCode = sCurrCode
		budget = b
		exchangeRate = rate
		currencyDailyUpdate = cUpdate
		currencyUpdateTime = cUpdateTime
		imgPath = path
		createDate = cDate
		updateDate = uDate
	}
}

