//
//  TripProfileInputViewController.swift
//  projectTrip
//
//  Created by Eunbee on 2016. 12. 16..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class TripProfileInputViewController: UIViewController {
    
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var buttonStartDate: UIButton!
    @IBOutlet weak var buttonEndDate: UIButton!
    @IBOutlet weak var buttonCountry: UIButton!
    // 여행 날짜 picker 있는 view
    @IBOutlet weak var viewTripDatePicker: UIView!
    @IBOutlet weak var datePickerTripDate: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("Profile View loaded")
        
        loadProfile()
        
        //TODO : 데이터 셋
        datePickerTripDate.setDate(Date.init(timeIntervalSinceNow: 0), animated: false)
    }
    
    // DB에서 데이터 로드
    func loadProfile() {
        debugPrint("load profile")
        // TODO : DB에서 데이터 로드
        
        // TODO : 데이터 셋
        
        //textFieldTitle.text = TITLE
        //buttonStartDate.text = START_DATE
        //buttonEndDate.text = END_DATE
        //buttonCountry.text = COUNTRY_CODE -> COUNTRY_NAME
        
    }
    
    // DatePicker 있는 view 숨기기
    func hideViewTripDatePicker() {
        if (!viewTripDatePicker.isHidden) {
            // view 숨기기
            viewTripDatePicker.isHidden = true;
        }
    }
    
    @IBAction func saveProfile(_ sender: UIBarButtonItem) {
        
        // 데이터 셋
        let title: String? = textFieldTitle.text
        //let startDate
        //let endDate
        //let country: String?
        
        // TODO : DB에 저장
        
        debugPrint("title is \(title!)")
    }
    
    @IBAction func showTripDatePicker(_ sender: UIButton) {
        if (viewTripDatePicker.isHidden) {
            // TODO : view 보여주기
            viewTripDatePicker.isHidden = false;
        }
    }
    
    @IBAction func saveTripDate(_ sender: Any) {
        // TODO : 날짜 저장
        buttonStartDate.setTitle(datePickerTripDate.date, for: nil)
        hideViewTripDatePicker();
    }
    
    @IBAction func cancelTripDate(_ sender: Any) {
        hideViewTripDatePicker();
    }
    
    func convertDateToString(date: Date) -> String? {
        let dateFormatter: DateFormatter?
        
        dateFormatter?.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter?.dateFromString(date)
        
        return dateString
    }
    
    
}
