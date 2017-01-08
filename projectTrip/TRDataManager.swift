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
	
	
	//MARK: Get Trip data from DB
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
			//DB 데이터 변환 정합성 체크
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
			                             createDate: oneRow[12],
			                             updateDate: oneRow[13])
			
			dataArr.append(oneData)
		}
		
		return dataArr
	}
	
	private func getTripDetailDatasFromDB(tripID: String) -> Array<TripDetailData>?
	{
		let query = "SELECT * FROM TRIP_DETAIL ORDER BY USED_DATE DESC"
		guard let dbDataArr = DBManager.getData(query: query) else
		{
			return nil
		}
		
		var dataArr = Array<TripDetailData>()
		for oneRow in dbDataArr
		{
			//DB 데이터 변환 정합성 체크
			guard let id = Int(oneRow[0]),
				  let masterId = Int(oneRow[1]),
				  let moneyType = MoneyType(rawValue: oneRow[2]),
				  let usedCode = UsedCode(rawValue: oneRow[3]),
				  let usedMoney = Float(oneRow[5]) else
			{
				continue
			}
			
			let oneData = TripDetailData(id: id,
			                             masterId: masterId,
			                             moneyType: moneyType,
			                             usedCode: usedCode,
			                             usedDate: oneRow[4],
			                             usedMoney: usedMoney,
			                             title: oneRow[6],
			                             desc: oneRow[7],
			                             imgPath: oneRow[8])
			dataArr.append(oneData)
		}
		
		return dataArr
	}
	
	//MARK: Create Trip data to DB
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
		let presentDate = Date().toString()
		let cUpdateDate = cUpdate ? presentDate : ""
		
		var query = "INSERT INTO TRIP_MASTER VALUES('\(t)', '\(sDate)', '\(eDate)', '\(code)', '\(eCurrCode)', '\(sCurrCode)', '\(b)', '\(rate)', '\(cUpdate)', '\(cUpdateDate)', '\(path)', '\(presentDate)', '\(presentDate)')"
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
		                             currencyUpdateTime: cUpdateDate,
		                             imgPath: path,
		                             createDate: presentDate,
		                             updateDate: presentDate)
		return newData
	}
	
	private func insertTripDetailDataToDB(masterId mId: Int,
	                                      moneyType mType: MoneyType,
	                                      usedCode uCode: UsedCode,
	                                      usedDate uDate: String,
	                                      usedMoney uMoney: Float,
	                                      title t: String,
	                                      desc d: String,
	                                      imgPath path: String) -> TripDetailData?
	{
		var query = "INSERT INTO TRIP_DETAIL VALUES('\(mId)', '\(mType.rawValue)', '\(uCode.rawValue)', '\(uDate)', '\(uMoney)', '\(t)', '\(d)', '\(path)')"
		guard DBManager.setData(query: query) else
		{
			return nil
		}
		
		query = "SELECT MAX(TR_DETAIL_ID) FROM TRIP_DETAIL"
		guard let tripIdArr = DBManager.getData(query: query) else
		{
			return nil
		}
		
		guard let presentTripId = Int(tripIdArr[0][0]) else
		{
			return nil
		}
		
		let newData = TripDetailData(id: presentTripId,
		                             masterId: mId,
		                             moneyType: mType,
		                             usedCode: uCode,
		                             usedDate: uDate,
		                             usedMoney: uMoney,
		                             title: t,
		                             desc: d,
		                             imgPath: path)
		return newData
	}
	
	//MARK: Update Trip data to DB
	private func updateTripMasterDataToDB(data: TripMasterData) -> Bool
	{
		let presentDate = Date().toString()
		let cUpdateDate = data.currencyDailyUpdate ? presentDate : ""
		
		let query = "UPDATE TRIP_MASTER SET TITLE = '\(data.title)', START_DATE = '\(data.startDate)', END_DATE = '\(data.endDate)', COUNTRY_CODE = '\(data.countryCode)', EXP_CURRENCY_CODE = '\(data.expCurrencyCode)', STD_CURRENCY_CODE = '\(data.stdCurrencyCode)', BUDGET = \(data.budget), EXCHANGE_RATE = \(data.exchangeRate), DAILY_UPDATE_YN = '\(data.currencyDailyUpdate)', DAILY_UPDATE_TIME = '\(cUpdateDate)', IMG_PATH = '\(data.imgPath)', UPDATE_TIME = '\(data.updateDate)' WHERE TR_ID = \(data.id)"
		
		return DBManager.setData(query: query)
	}
	
	private func updateTripDetailDataToDB(data: TripDetailData) -> Bool
	{
		let query = "UPDATE TRIP_DETAIL SET MONEY_TYPE = '\(data.moneyType.rawValue)', USED_CODE = '\(data.usedCode.rawValue)', USED_DATE = '\(data.usedDate)', USED_MONEY = \(data.usedMoney), TITLE = '\(data.title)', DESC = '\(data.desc)', IMG_PATH = '\(data.imgPath)' WHERE TR_DETAIL_ID = \(data.id)"
		
		return DBManager.setData(query: query)
	}
	
	//MARK: Delete Trip data from DB
	private func deleteTripMasterDataFromDB(id: Int) -> Bool
	{
		let masterQuery = "DELETE FROM TRIP_MASTER WHERE TR_ID = \(id)"
		let detailQuery = "DELETE FROM TRIP_DETAIL WHERE TR_MASTER_ID = \(id)"
		return DBManager.setData(query: detailQuery) && DBManager.setData(query: masterQuery)
	}
	
	private func deleteTripDetailDataFromDB(id: Int) -> Bool
	{
		let query = "DELETE FROM TRIP_DETAIL WHERE TR_DETAIL_ID = \(id)"
		return DBManager.setData(query: query)
	}
	
	//MARK: Getting Trip data
	class func getTripMasterDatas() -> Array<TripMasterData>
	{
		guard let dataArr = TRDataManager.sharedInstance.getTripMasterDatasFromDB() else
		{
			TRDataManager.sharedInstance.trMasterDatas.removeAll()
			return TRDataManager.sharedInstance.trMasterDatas
		}
		
		TRDataManager.sharedInstance.trMasterDatas = dataArr
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
	
	class func getTripDetailDatas(masterId: Int) -> Array<TripDetailData>
	{
		guard let dataArr = TRDataManager.sharedInstance.getTripDetailDatasFromDB(tripID: String(masterId)) else
		{
			TRDataManager.sharedInstance.trDetailDatas.removeAll()
			return TRDataManager.sharedInstance.trDetailDatas
		}
		
		TRDataManager.sharedInstance.trDetailDatas = dataArr
		return TRDataManager.sharedInstance.trDetailDatas
	}
	
	class func getTripDetailData(id: Int) -> TripDetailData?
	{
		for oneData in TRDataManager.sharedInstance.trDetailDatas
		{
			if id == oneData.id
			{
				return oneData
			}
		}
		return nil
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
	
	class func setNewTripDetailData(masterId mId: Int,
	                                moneyType mType: MoneyType,
	                                usedCode uCode: UsedCode,
	                                usedDate uDate: String,
	                                usedMoney uMoney: Float,
	                                title t: String,
	                                desc d: String,
	                                imaPath path: String) -> TripDetailData?
	{
		guard let newData = TRDataManager.sharedInstance.insertTripDetailDataToDB(masterId: mId,
		                                                                          moneyType: mType,
		                                                                          usedCode: uCode,
		                                                                          usedDate: uDate,
		                                                                          usedMoney: uMoney,
		                                                                          title: t,
		                                                                          desc: d,
		                                                                          imgPath: path) else
		{
			return nil
		}
		
		var dataArr = TRDataManager.getTripDetailDatas(masterId: mId)
		dataArr.append(newData)
		return newData
	}
	
	class func updateTripMasterData(data: TripMasterData) -> Bool
	{
		guard TRDataManager.sharedInstance.updateTripMasterDataToDB(data: data) else
		{
			return false
		}
		
		var dataArr = TRDataManager.getTripMasterDatas()
		for index in 0...dataArr.count - 1
		{
			let oneData = dataArr[index]
			if data.id == oneData.id
			{
				dataArr[index] = data
				return true
			}
		}
		return false
	}
	
	class func updateTripDetailData(data: TripDetailData) -> Bool
	{
		guard TRDataManager.sharedInstance.updateTripDetailDataToDB(data: data) else
		{
			return false
		}
		
		var dataArr = TRDataManager.getTripDetailDatas(masterId: data.masterId)
		for index in 0...dataArr.count - 1
		{
			let oneData = dataArr[index]
			if data.id == oneData.id
			{
				dataArr[index] = data
				return true
			}
		}
		return false
	}
	
	class func deleteTripMasterData(id: Int) -> Bool
	{
		guard TRDataManager.sharedInstance.deleteTripMasterDataFromDB(id: id) else
		{
			return false
		}
		
		var dataArr = TRDataManager.getTripMasterDatas()
		for index in 0...dataArr.count - 1
		{
			let oneData = dataArr[index]
			if id == oneData.id
			{
				dataArr.remove(at: index)
				return true
			}
		}
		return false
	}
	
	class func deleteTripMasterData(data: TripMasterData) -> Bool
	{
		return TRDataManager.deleteTripMasterData(id: data.id)
	}
	
	class func deleteTripDetailData(id: Int, masterId: Int) -> Bool
	{
		guard TRDataManager.sharedInstance.deleteTripDetailDataFromDB(id: id) else
		{
			return false
		}
		
		var dataArr = TRDataManager.getTripDetailDatas(masterId: masterId)
		for index in 0...dataArr.count - 1
		{
			let oneData = dataArr[index]
			if id == oneData.id
			{
				dataArr.remove(at: index)
				return true
			}
		}
		return false
	}
	
	class func deleteTripDetailData(data: TripDetailData) -> Bool
	{
		return TRDataManager.deleteTripDetailData(id: data.id, masterId: data.masterId)
	}
	
	
	//class func containsTripData()
	
	//MARK: Getting Country data
//	class func getCountryDatas() -> Array<CountryData>
//	{
//		
//	}
}
