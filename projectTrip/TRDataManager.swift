//
//  TRDataManager.swift
//  projectTrip
//
//  Created by Jeon Myeong Woo on 2016. 12. 11..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import Foundation

class TRDataManager
{
	//싱글톤 매니저 변수
	static private let sharedInstance: TRDataManager = TRDataManager()
	
	private(set) var trMasterDatas: Array<TripMasterData> = Array<TripMasterData>()
	private(set) var trDetailDatas: Array<TripDetailData> = Array<TripDetailData>()
	private(set) var countryDatas: Array<CountryData> = Array<CountryData>()
	
	
	//MARK: Getting Trip data from DB
	private func getTripMasterDatasFromDB() -> Array<TripMasterData>?
	{
		let query = "SELECT * FROM TRIP_MASTER ORDER BY START_DATE DESC CREATE_TIME DESC"
		guard let dbDataArr = DBManager.getData(query: query) else
		{
			return nil
		}
		
		var dataArr = Array<TripMasterData>()
		for oneRow in dbDataArr
		{
			guard let id = Int(oneRow[0]),
				  let budget = Float(oneRow[7]),
				  let rate = Float(oneRow[8]),
				  let isDailyUpdate = Bool(oneRow[9]) else
			{
				continue
			}
			
			let oneData = TripMasterData(id: id,
			                             title: oneRow[1],
			                             startDate: oneRow[2],
			                             endDate: oneRow[3],
			                             countryCode: oneRow[4],
			                             expCurrencyCode: oneRow[5],
			                             stdCurrencyCode: oneRow[6],
			                             budget: budget,
			                             exchangeRate: rate,
			                             currencyDailyUpdate: isDailyUpdate,
			                             currencyUpdateTime: oneRow[10],
			                             imgPath: oneRow[11],
			                             createTime: oneRow[12],
			                             updateTime: oneRow[13])
			
			dataArr.append(oneData)
		}
		
		return dataArr
	}
	
	private func getTripDetailDatasFromDB(tripID: String) -> Array<TripDetailData>?
	{
		var dataArr = Array<TripDetailData>()
		
		return dataArr
	}
	
	
	//MARK: Getting Trip data
	class func getTripMasterDatas() -> Array<TripMasterData>
	{
		if let dataArr = TRDataManager.sharedInstance.getTripMasterDatasFromDB()
		{
			TRDataManager.sharedInstance.trMasterDatas = dataArr
		}
		return TRDataManager.sharedInstance.trMasterDatas
	}
	
	class func getTripMasterData(id: Int) -> TripMasterData?
	{
		for oneData in TRDataManager.sharedInstance.trMasterDatas
		{
			if id == oneData.id
			{
				return oneData
			}
		}
		return nil
	}
	
	class func getTripDetailDatas() -> Array<TripDetailData>
	{
		
	}
	
	class func getTripDetailData(id: Int) -> TripDetailData?
	{
		for oneData in TRDataManager.sharedInstance.trDetailDatas
		{
			return nil
			
//			if id == oneData.id
//			{
//				return oneData
//			}
		}
		return nil
	}
	
	
	//MARK: Setting Trip data to DB
	private func insertTripMasterDataToDB(title t: String,
	                                      startDate sDate: String,
	                                      endDate eDate: String,
	                                      countryCode code: String,
	                                      expCurrencyCode eCurrCode: String,
	                                      stdCurrencyCode sCurrCode: String,
	                                      budget b: Float,
	                                      exchangeRate rate: Float,
	                                      currencyDailyUpdate cUpdate: Bool,
	                                      imgPath path: String) -> TripMasterData?
	{
		let presentTime = Date().toString()
		let cUpdateTime = cUpdate ? presentTime : ""
		
		var query = "INSERT INTO TRIP_MASTER VALUES('\(t)', '\(sDate)', '\(eDate)', '\(code)', '\(eCurrCode)', '\(sCurrCode)', '\(b)', '\(rate)', '\(cUpdate)', '\(cUpdateTime)', '\(path)', '\(presentTime)', '\(presentTime)')"
		guard DBManager.setData(query: query) else
		{
			return nil
		}
		
		query = "SELECT MAX(TR_ID) FROM TRIP_MASTER"
		guard let tripIdArr = DBManager.getData(query: query) else
		{
			return nil
		}
		
		guard let presentTripId = Int(tripIdArr[0][0]) else
		{
			return nil
		}
		
		let newData = TripMasterData(id: presentTripId,
		                             title: t,
		                             startDate: sDate,
		                             endDate: eDate,
		                             countryCode: code,
		                             expCurrencyCode: eCurrCode,
		                             stdCurrencyCode: sCurrCode,
		                             budget: b,
		                             exchangeRate: rate,
		                             currencyDailyUpdate: cUpdate,
		                             currencyUpdateTime: cUpdateTime,
		                             imgPath: path,
		                             createTime: presentTime,
		                             updateTime: presentTime)
		return newData
	}
	
	private func updateTripMasterDataToDB(data: TripMasterData) -> TripMasterData?
	{
		let presentTime = Date().toString()
		let cUpdateTime = data.currencyDailyUpdate ? presentTime : ""
		
		let query = "UPDATE TRIP_MASTER SET TITLE = '\(data.title)', START_DATE = '\(data.startDate)', END_DATE = '\(data.endDate)', COUNTRY_CODE = '\(data.countryCode)', EXP_CURRENCY_CODE = '\(data.expCurrencyCode)', STD_CURRENCY_CODE = '\(data.stdCurrencyCode)', BUDGET = \(data.budget), EXCHANGE_RATE = \(data.exchangeRate), DAILY_UPDATE_YN = '\(data.currencyDailyUpdate)', DAILY_UPDATE_TIME = '\(cUpdateTime)', IMG_PATH = '\(data.imgPath)', UPDATE_TIME = '\(data.updateTime)' WHERE TR_ID = \(data.id)"
		
		guard DBManager.setData(query: query) else
		{
			return nil
		}
		
		return data
	}
	
	//MARK: Setting Trip data
	class func setNewTripMasterData(title t: String,
	                                startDate sDate: String,
	                                endDate eDate: String,
	                                countryCode code: String,
	                                expCurrencyCode eCurrCode: String,
	                                stdCurrencyCode sCurrCode: String,
	                                budget b: Float,
	                                exchangeRate rate: Float,
	                                currencyDailyUpdate cUpdate: Bool,
	                                imgPath path: String) -> TripMasterData?
	{
		guard let newData = TRDataManager.sharedInstance.insertTripMasterDataToDB(title: t,
		                                                                          startDate: sDate,
		                                                                          endDate: eDate,
		                                                                          countryCode: code,
		                                                                          expCurrencyCode: eCurrCode,
		                                                                          stdCurrencyCode: sCurrCode,
		                                                                          budget: b,
		                                                                          exchangeRate: rate,
		                                                                          currencyDailyUpdate: cUpdate,
		                                                                          imgPath: path) else
		{
			return nil
		}
		
		var dataArr = TRDataManager.getTripMasterDatas()
		dataArr.append(newData)
		return newData
	}
	
	class func setNewTripDetailData() -> TripDetailData?
	{
		return nil
	}
	
	class func updateTripMasterData(data: TripMasterData) -> TripMasterData?
	{
//		guard let newData = TRDataManager.sharedInstance.updateTripMasterDataToDB(data: data) else
//		{
//			
//		}
		return nil
	}
	
	class func updateTripDetailData(data: TripDetailData) -> TripDetailData?
	{
		return nil
	}
	
	
	//MARK: Getting Country data
	class func getCountryDatas() -> Array<CountryData>
	{
		
	}
}
