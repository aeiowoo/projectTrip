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
    @IBOutlet weak var buttonStartDateCalendar: UIButton!
    @IBOutlet weak var buttonEndDate: UIButton!
    @IBOutlet weak var buttonEndDateCalendar: UIButton!
    @IBOutlet weak var buttonCountry: UIButton!
    
    // 여행 날짜 picker 있는 view
    @IBOutlet weak var viewTripDatePicker: UIView!
    @IBOutlet weak var datePickerTripDate: UIDatePicker!
    
    // date picker 세팅하기 위한 변수
    var dateButtonSender: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("Profile View loaded")
        
        loadProfile()
    }
    
    // DatePicker 있는 view 숨기기
    func hideViewTripDatePicker() {
        if (!viewTripDatePicker.isHidden) {
            // view 숨기기
            viewTripDatePicker.isHidden = true;
        }
    }
    
    /************ DB <-> View Method Start ************/
    
    // DB에서 데이터 로드
    func loadProfile() {
        debugPrint("load profile")
        
        // DB에서 데이터 로드
        // TODO : 쿼리 수정
        let tripProfile: Array<Array<String>>? = DBManager.getData(query: "SELECT * FROM TRIP_MASTER WHERE TR_ID = 1")
        
        
        
        // TODO : 데이터 셋
        
        textFieldTitle.text = tripProfile![0][1]
        
        
        buttonStartDate.setTitle(tripProfile![0][2], for: .normal)
        // TODO : 빈값이면 오늘날짜
        
        buttonEndDate.setTitle(tripProfile![0][3], for: .normal)
        // TODO : 빈값이면 오늘날짜
        
        //buttonCountry.text = COUNTRY_CODE -> COUNTRY_NAME
        
    }
    
    // DB에 데이터 저장
    func saveProfile() {
        // 데이터 셋
        // TITLE
        let title: String? = textFieldTitle.text
        // START_DATE
        let startDate: String? = buttonStartDate.currentTitle
        // END_DATE
        let endDate: String? = buttonEndDate.currentTitle
        // COUNTRY_CODE
        let countryCode: String? = buttonCountry.currentTitle
        // STD_CURRENCY_CODE
        
        // EXP_CURRENCY_CODE
        
        // EXCHANGE_RATE
        //let endDate
        //let country: String?
        
        // UPDATE_TIME
        let todayDate: Date = Date()
        let dateString: String? = convertDateToString(date: todayDate)
        
        
        
        let queryString: String = "UPDATE TRIP_MASTER "
            + "SET TITLE = " + title!
            + ", START_DATE = " + startDate!
            + ", END_DATE = " + endDate!
            + ", COUNTRY_CODE = " + countryCode!
            + ", EXP_CURRENCY_CODE = " /* currencyCode */
            + ", STD_CURRENCY_CODE = " /* currencyCode */
            + ", BUDGET = " /* budget */
            + ", EXCHANGE_RATE = " /* exchangeRate */
            + ", DAILY_UPDATE_YN = " /* update */
            + ", IMG_PATH = " /* imgPath */
            + ", UPDATE_TIME = " + dateString!
        
        // TODO : DB에 저장
        // DBManager.sharedInstance.setData(query:queryString)
        // 체크1 : 여행 시작일 < 여행 마지막일
    }
    
    /************ DB <-> View Method End ************/
    
    
    /************ Util Method Start ************/
    
    // Date type -> String type
    func convertDateToString(date: Date) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateFormatter.string(from: date)
        
        return dateString
        
    }
    
    // String type -> Date type
    func convertStringToDate(dateString: String?) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: dateString!)
        
        return date!
    }
    
    /************ Util Method End ************/
    
    
    /************ IBAction Method Start************/
    
    @IBAction func saveProfile(_ sender: UIBarButtonItem) {
        
        saveProfile()
        
        debugPrint("title is \(title!)")
        
        // TODO : view 닫기
    }
    
    @IBAction func showTripDatePicker(_ sender: UIButton) {
        // 현재 날짜 선택 view가 보이지 않는다면
        if (viewTripDatePicker.isHidden) {
            
            // 캘린더 이미지 버튼 눌렀을 때도 똑같이 동작하도록 처리
            switch sender {
            case buttonStartDateCalendar:
                dateButtonSender = buttonStartDate
            case buttonEndDateCalendar:
                dateButtonSender = buttonEndDate
            default:
                dateButtonSender = sender
            }
            
            
            // 보여줄 날짜 세팅
            datePickerTripDate.setDate(convertStringToDate(dateString: dateButtonSender.currentTitle), animated: false)
            // 뷰 보이도록 세팅
            viewTripDatePicker.isHidden = false
        }
    }
    
    @IBAction func saveTripDate(_ sender: Any) {
        // 노출되는 날짜 세팅
        dateButtonSender.setTitle(convertDateToString(date: datePickerTripDate.date), for: .normal)
        // 뷰 숨기기
        hideViewTripDatePicker();
    }
    
    @IBAction func cancelTripDate(_ sender: Any) {
        hideViewTripDatePicker();
    }
    
    /************ IBAction Method End************/
}
