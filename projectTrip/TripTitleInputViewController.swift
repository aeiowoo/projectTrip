//
//  TripTitleInputViewController.swift
//  projectTrip
//
//  Created by Friday on 2016. 12. 11..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class TripTitleInputViewController: UIViewController {

    @IBOutlet var backgroundImage: UIImageView!

    @IBOutlet var textField: UITextField!
    
    @IBOutlet var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createViewContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animation()
    }
    //컨텐츠 생성
    func createViewContents() {
        
        //이 화면은 네비게이션 바가 숨겨져 있어야 한다.
        self.navigationController?.navigationBar.isHidden = true
        
        self.backgroundImage.alpha = 0
        self.textField.alpha = 0
        self.addButton.alpha = 0
    }
    
    //시작 애니메이션
    func animation() {
        
        let addButtonOriginY = addButton.frame.origin.y
        let textFieldOriginY = textField.frame.origin.y
        
        addButton.frame.origin.y -= self.view.frame.size.height / 2.7
        textField.frame.origin.y -= self.view.frame.size.height / 2.7
        
        UIView.animate(withDuration:0.6, animations: {
            
            self.addButton.frame.origin.y = addButtonOriginY
            self.textField.frame.origin.y = textFieldOriginY
            
            self.backgroundImage.alpha = 1
            self.textField.alpha = 1
            self.addButton.alpha = 1
            
        }) { (secces:Bool) in
            
            //텍스트필드 안으로 바로 들어오도록 하는 메소드
            self.textField.becomeFirstResponder()
            
        }
    }

    @IBAction func onAddButton(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}










