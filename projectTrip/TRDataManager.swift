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
	
	private var trMasterDatas: Array<TripMasterData> = Array<TripMasterData>()
	private var trDetailDatas: Array<TripDetailData> = Array<TripDetailData>()
	private var countryDatas: Array<CountryData> = Array<CountryData>()
	
	//MARK: Synchronize data with DB
	private func synchronizeTripMasterDatasWithDB() -> Array<TripMasterData>
	{
		guard let dataArr = TRDataManager.sharedInstance.getTripMasterDatasFromDB() else
		{
			TRDataManager.sharedInstance.trMasterDatas.removeAll()
			return TRDataManager.sharedInstance.trMasterDatas
		}
		
		TRDataManager.sharedInstance.trMasterDatas = dataArr
		return TRDataManager.sharedInstance.trMasterDatas
	}
	
	private func synchronizeTripDetailDatasWithDB() -> Array<TripDetailData>
	{
		guard let dataArr = TRDataManager.sharedInstance.getTripDetailDatasFromDB() else
		{
			TRDataManager.sharedInstance.trDetailDatas.removeAll()
			return TRDataManager.sharedInstance.trDetailDatas
		}
		
		TRDataManager.sharedInstance.trDetailDatas = dataArr
		return TRDataManager.sharedInstance.trDetailDatas
	}
	
	private func synchronizeCountryDatasWithDB() -> Array<CountryData>
	{
		guard let dataArr = TRDataManager.sharedInstance.getCountryDatasFromDB() else
		{
			TRDataManager.sharedInstance.countryDatas.removeAll()
			return TRDataManager.sharedInstance.countryDatas
		}
		
		TRDataManager.sharedInstance.countryDatas = dataArr
		return TRDataManager.sharedInstance.countryDatas
	}
	
	class func synchronizeData() -> Bool
	{
		guard let masterDatas = sharedInstance.getTripMasterDatasFromDB() else
		{
			sharedInstance.trMasterDatas.removeAll()
			return false
		}
		guard let detailDatas = sharedInstance.getTripDetailDatasFromDB() else
		{
			sharedInstance.trDetailDatas.removeAll()
			return false
		}
		guard let countryDatas = sharedInstance.getCountryDatasFromDB() else
		{
			sharedInstance.countryDatas.removeAll()
			return false
		}
		
		sharedInstance.trMasterDatas = masterDatas
		sharedInstance.trDetailDatas = detailDatas
		sharedInstance.countryDatas = countryDatas
		return true
	}
	
	//MARK: Get Trip data from DB
	private func getTripMasterDatasFromDB() -> Array<TripMasterData>?
	{
		let query = "SELECT * FROM TRIP_MASTER ORDER BY START_DATE DESC, CREATE_TIME DESC"
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
				  let rate = Float(oneRow[8]) else
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
			                             currencyDailyUpdate: oneRow[9].toBool(),
			                             currencyUpdateTime: oneRow[10],
			                             imgPath: oneRow[11],
			                             createDate: oneRow[12],
			                             updateDate: oneRow[13])
			
			dataArr.append(oneData)
		}
		
		return dataArr
	}
	
	private func getTripDetailDatasFromDB() -> Array<TripDetailData>?
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
				  let mId = Int(oneRow[1]),
				  let mType = MoneyType(rawValue: oneRow[2]),
				  let uCode = UsedCode(rawValue: oneRow[3]),
				  let uMoney = Float(oneRow[5]),
				  let uMoneySign = MoneySign(rawValue: oneRow[6]) else
			{
				continue
			}
			
			let oneData = TripDetailData(id: id,
			                             masterId: mId,
			                             moneyType: mType,
			                             usedCode: uCode,
			                             usedDate: oneRow[4],
			                             usedMoney: uMoney,
			                             usedMoneySign: uMoneySign,
			                             title: oneRow[7],
			                             desc: oneRow[8],
			                             imgPath: oneRow[9])
			dataArr.append(oneData)
		}
		
		return dataArr
	}
	
	//MARK: Get Country data from DB
	private func getCountryDatasFromDB() -> Array<CountryData>?
	{
		let query = "SELECT * FROM COUNTRY_INFO ORDER BY COUNTRY_CODE"
		guard let dbDataArr = DBManager.getData(query: query) else
		{
			return nil
		}
		
		var dataArr = Array<CountryData>()
		for oneRow in dbDataArr
		{
			let oneData = CountryData(countryCode: oneRow[0],
			                          countryName: oneRow[1],
			                          korCountryName: oneRow[2],
			                          currencyCode: oneRow[3],
			                          imgPath: oneRow[4])
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
		
		let query = "INSERT INTO TRIP_MASTER (TITLE, START_DATE, END_DATE, COUNTRY_CODE, EXP_CURRENCY_CODE, STD_CURRENCY_CODE, BUDGET, EXCHANGE_RATE, DAILY_UPDATE_YN, DAILY_UPDATE_TIME, IMG_PATH, CREATE_TIME, UPDATE_TIME) VALUES('\(t)', '\(sDate)', '\(eDate)', '\(code)', '\(eCurrCode)', '\(sCurrCode)', \(b), \(rate), '\(cUpdate)', '\(cUpdateDate)', '\(path)', '\(presentDate)', '\(presentDate)')"
		guard DBManager.setData(query: query) else
		{
			return nil
		}
		
		let id = TRDataManager.sharedInstance.getMaxTripMasterDataId() + 1
		
		let newData = TripMasterData(id: id,
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
	                                      usedMoneySign uMoneySign: MoneySign,
	                                      title t: String,
	                                      desc d: String,
	                                      imgPath path: String) -> TripDetailData?
	{
		let query = "INSERT INTO TRIP_DETAIL VALUES(\(mId), '\(mType.rawValue)', '\(uCode.rawValue)', '\(uDate)', \(uMoney), '\(uMoneySign.rawValue)', '\(t)', '\(d)', '\(path)')"
		guard DBManager.setData(query: query) else
		{
			return nil
		}
		
		let id = TRDataManager.sharedInstance.getMaxTripDetailDataId() + 1
		
		let newData = TripDetailData(id: id,
		                             masterId: mId,
		                             moneyType: mType,
		                             usedCode: uCode,
		                             usedDate: uDate,
		                             usedMoney: uMoney,
		                             usedMoneySign: uMoneySign,
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
		let query = "UPDATE TRIP_DETAIL SET MONEY_TYPE = '\(data.moneyType.rawValue)', USED_CODE = '\(data.usedCode.rawValue)', USED_DATE = '\(data.usedDate)', USED_MONEY = \(data.usedMoney), USED_MONEY_TYPE = '\(data.usedMoneyIsExpense.rawValue)', TITLE = '\(data.title)', DESC = '\(data.desc)', IMG_PATH = '\(data.imgPath)' WHERE TR_DETAIL_ID = \(data.id)"
		
		return DBManager.setData(query: query)
	}
	
	//MARK: Delete Trip data from DB
	private func deleteTripMasterDataFromDB(id: Int) -> Bool
	{
		let query = "DELETE FROM TRIP_MASTER WHERE TR_ID = \(id)"
		return DBManager.setData(query: query)
	}
	
	private func deleteTripDetailDataFromDB(id: Int) -> Bool
	{
		let query = "DELETE FROM TRIP_DETAIL WHERE TR_DETAIL_ID = \(id)"
		return DBManager.setData(query: query)
	}
	
	//MARK: Get Trip data
	private func getMaxTripMasterDataId() -> Int
	{
		guard let lastData = TRDataManager.sharedInstance.trMasterDatas.last else
		{
			return 0
		}
		return lastData.id
	}
	
	class func getTripMasterDatas() -> Array<TripMasterData>
	{
		return sharedInstance.trMasterDatas
	}
	
	class func getTripMasterData(id: Int) -> TripMasterData?
	{
		for oneData in sharedInstance.trMasterDatas
		{
			if id == oneData.id
			{
				return oneData
			}
		}
		return nil
	}
	
	private func getMaxTripDetailDataId() -> Int
	{
		guard let lastData = TRDataManager.sharedInstance.trDetailDatas.last else
		{
			return 0
		}
		return lastData.id
	}
	
	class func getTripDetailDatas() -> Array<TripDetailData>
	{
		return sharedInstance.trDetailDatas
	}
	
	class func getTripDetailDatas(masterId: Int) -> Array<TripDetailData>
	{
		var dataArr = Array<TripDetailData>()
		
		for oneData in sharedInstance.trDetailDatas
		{
			if oneData.masterId == masterId
			{
				dataArr.append(oneData)
			}
		}
		return dataArr
	}
	
	class func getTripDetailData(id: Int) -> TripDetailData?
	{
		for oneData in sharedInstance.trDetailDatas
		{
			if id == oneData.id
			{
				return oneData
			}
		}
		return nil
	}
	
	//MARK: Set Trip data
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
		guard let newData = sharedInstance.insertTripMasterDataToDB(title: t,
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
		sharedInstance.trMasterDatas.append(newData)
		return newData
	}
	
	class func setNewTripDetailData(masterId mId: Int,
	                                moneyType mType: MoneyType,
	                                usedCode uCode: UsedCode,
	                                usedDate uDate: String,
	                                usedMoney uMoney: Float,
	                                usedMoneySign uMoneySign: MoneySign,
	                                title t: String,
	                                desc d: String,
	                                imaPath path: String) -> TripDetailData?
	{
		guard let newData = sharedInstance.insertTripDetailDataToDB(masterId: mId,
																	moneyType: mType,
		                                                            usedCode: uCode,
		                                                            usedDate: uDate,
																	usedMoney: uMoney,
																	usedMoneySign: uMoneySign,
																	title: t,
																	desc: d,
																	imgPath: path) else
		{
			return nil
		}
		sharedInstance.trDetailDatas.append(newData)
		return newData
	}
	
	class func updateTripMasterData(data: TripMasterData) -> Bool
	{
		guard sharedInstance.updateTripMasterDataToDB(data: data) else
		{
			return false
		}
		
		var dataArr = sharedInstance.trMasterDatas
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
		guard sharedInstance.updateTripDetailDataToDB(data: data) else
		{
			return false
		}
		
		var dataArr = sharedInstance.trDetailDatas
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
	
	class func deleteTripMasterData(id: Int) -> (Bool, Bool)
	{
		guard sharedInstance.deleteTripMasterDataFromDB(id: id) else
		{
			return (false, false)
		}
		
		var isDeleteMasterData = false
		var count = sharedInstance.trMasterDatas.count
		for index in 0...count - 1
		{
			let oneData = sharedInstance.trMasterDatas[index]
			if id == oneData.id
			{
				sharedInstance.trMasterDatas.remove(at: index)
				isDeleteMasterData = true
				break
			}
		}
		
		var isDeleteDetailData = false
		count = sharedInstance.trDetailDatas.count
		for index in 0...count - 1
		{
			let oneData = sharedInstance.trDetailDatas[index]
			if id == oneData.masterId
			{
				sharedInstance.trDetailDatas.remove(at: index)
				isDeleteDetailData = true
			}
		}
		
		return (isDeleteMasterData, isDeleteDetailData)
	}
	
	class func deleteTripMasterData(data: TripMasterData) -> (Bool, Bool)
	{
		return TRDataManager.deleteTripMasterData(id: data.id)
	}
	
	class func deleteTripDetailData(id: Int) -> Bool
	{
		guard sharedInstance.deleteTripDetailDataFromDB(id: id) else
		{
			return false
		}
		
		let count = sharedInstance.trDetailDatas.count
		for index in 0...count - 1
		{
			let oneData = sharedInstance.trDetailDatas[index]
			if id == oneData.id
			{
				sharedInstance.trDetailDatas.remove(at: index)
				return true
			}
		}
		return false
	}
	
	class func deleteTripDetailData(data: TripDetailData) -> Bool
	{
		return TRDataManager.deleteTripDetailData(id: data.id)
	}
	
	//MARK: Get Country data
	class func getCountryDatas() -> Array<CountryData>
	{
		return sharedInstance.countryDatas
	}
	
	class func getCountryData(countryCode: String) -> CountryData?
	{
		for oneData in sharedInstance.countryDatas
		{
			if oneData.countryCode == countryCode
			{
				return oneData
			}
		}
		return nil
	}
	
	class func getCountryData(countryName: String) -> CountryData?
	{
		for oneData in sharedInstance.countryDatas
		{
			if oneData.countryName == countryName
			{
				return oneData
			}
		}
		return nil
	}
	
	class func getCountryData(korCountryName: String) -> CountryData?
	{
		for oneData in sharedInstance.countryDatas
		{
			if oneData.korCountryName == korCountryName
			{
				return oneData
			}
		}
		return nil
	}
	
	class func getCountryData(currencyCode: String) -> CountryData?
	{
		for oneData in sharedInstance.countryDatas
		{
			if oneData.currencyCode == currencyCode
			{
				return oneData
			}
		}
		return nil
	}
}
