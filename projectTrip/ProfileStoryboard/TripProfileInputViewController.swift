//
//  TripProfileInputViewController.swift
//  projectTrip
//
//  Created by Eunbee on 2016. 12. 16..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class TripProfileInputViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("Profile View loaded");
        
        loadProfile()
    }
    
    // DB에서 데이터 로드
    func loadProfile() {
        debugPrint("load profile");
        
        
    }
    
    
    @IBAction func saveProfile(_ sender: UIBarButtonItem) {
        
        // TODO : DB에 저장
    }
}
