//
//  TripCategoryInputViewController.swift
//  projectTrip
//
//  Created by Friday on 2016. 12. 18..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class TripCategoryInputViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var colorButton: UIButton!
    @IBOutlet var iconButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createViewContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func createViewContents() {
        
        //버튼 둥글게
        colorButton.layer.cornerRadius = colorButton.frame.width/2
        iconButton.layer.cornerRadius = iconButton.frame.width/2
        
        //키보드 바로 띄우기
        textField.becomeFirstResponder()
    }

    @IBAction func completeButton(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
