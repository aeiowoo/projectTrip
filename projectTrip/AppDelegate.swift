//
//  AppDelegate.swift
//  projectTrip
//
//  Created by Jeon Myeong Woo on 2016. 11. 26..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

//tetset
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		TRDataManager.synchronizeData()
		
		//dump(TRDataManager.getCountryDatas())
		
		dump(TRDataManager.getTripMasterDatas())
		dump(TRDataManager.getTripDetailDatas())
		
		//dump(TRDataManager.getTripDetailDatas())
		
		//let newData = TRDataManager.setNewTripMasterData(title: "스페인", startDate: "2016-12-25", endDate: "2016-12-31", countryCode: "ES", expCurrencyCode: "ESP", stdCurrencyCode: "KRW", budget: 3000, exchangeRate: 25.5, currencyDailyUpdate: false, imgPath: "spain.png")
		
		//dump(TRDataManager.getTripMasterDatas())
		
		//newData!.budget = 4000
		
		//TRDataManager.updateTripMasterData(data: newData!)
		//dump(TRDataManager.getTripMasterDatas())
		
		//TRDataManager.deleteTripMasterData(id: 18)
		//dump(TRDataManager.getTripMasterDatas())
		
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

