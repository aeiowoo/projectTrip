//
//  TestViewController.swift
//  projectTrip
//
//  Created by Friday on 2017. 1. 23..
//  Copyright © 2017년 SwiftTive. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func createViewContents() -> Void {
        
        myLabel.text = "Hi"
        myLabel.textColor = UIColor.blue
    }
    
    func creatViewContents2(withString : String, withColor: UIColor) {
        
        myLabel.text = withString
        myLabel.textColor = withColor
    }

    @IBAction func rrrr(_ sender: Any) {
        
        myLabel.font = UIFont(name: myLabel.font.fontName, size: myLabel.font.pointSize + 1)
    }
    
    
    
    
}




