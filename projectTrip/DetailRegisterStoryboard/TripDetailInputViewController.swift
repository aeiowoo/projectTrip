//
//  RegistContentControllView.swift
//  Test1204
//
//  Created by Dawon on 2016. 12. 4..
//  Copyright © 2016년 Dawon. All rights reserved.
//

import Foundation

import UIKit


class TripDetailInputViewController: UIViewController {
   
    @IBOutlet weak var labelCurrency: UILabel!
    @IBOutlet weak var labelCost: UILabel!
    @IBOutlet weak var labelSum: UILabel!
    
    @IBOutlet weak var buttonCash: UIButton!
    @IBOutlet weak var buttonCard: UIButton!
    @IBOutlet weak var secmentedControlPlusMinus: UISegmentedControl!
    
    @IBOutlet weak var buttonFood: UIButton!
    @IBOutlet weak var buttonShopping: UIButton!
    @IBOutlet weak var buttonTour: UIButton!
    @IBOutlet weak var buttonTraffic: UIButton!
    @IBOutlet weak var buttonStay: UIButton!
    @IBOutlet weak var buttonEtc: UIButton!
    
    @IBOutlet weak var textFieldContentTitle: UITextField!
    
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var buttonCalendar: UIButton!
    @IBOutlet weak var buttonPicture: UIButton!
    @IBOutlet weak var buttonNote: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    
    @IBOutlet weak var imageViewMiddle:UIImageView!
    @IBOutlet weak var imageViewBottom:UIImageView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var buttonDiv: UIButton!
    @IBOutlet weak var buttonMul: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonDot: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var button0: UIButton!
    
    
    
    let buttonWidth: CGFloat
    var buttonHeight: CGFloat
    var firstButtonLocationX: CGFloat
    var firstButtonLocationY: CGFloat
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        buttonWidth = (UIScreen.main.bounds.width - 6.0)/4
        firstButtonLocationX = CGFloat.init()
        firstButtonLocationY = CGFloat.init()
        buttonHeight = CGFloat.init()
        
        super.init(nibName: nibNameOrNil, bundle: Bundle.main )

        self.view.frame(forAlignmentRect:  UIScreen.main.bounds)
        
        firstButtonLocationX = 3.0
        firstButtonLocationY = imageViewMiddle.frame.origin.y + imageViewMiddle.frame.height + 3.0
        buttonHeight = (UIScreen.main.bounds.height - firstButtonLocationY - 3.0)/4
        self.initialize()
        self.initButtonPosition()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    
    func initialize()
    {
        labelCurrency.text = "USD $"
        labelCost.text = "0"
        labelSum.text = labelCurrency.text! + labelCost.text!
        
        buttonCancel.setTitle("취소", for: UIControlState.normal)
        buttonSave.setTitle("저장", for: UIControlState.normal)
        
        textFieldContentTitle.placeholder = "항목명"
        buttonCancel.layer.cornerRadius = 5
        buttonCancel.layer.borderWidth = 1
        buttonCancel.layer.borderColor = UIColor.red.cgColor
        buttonSave.layer.cornerRadius = 5
        
        
        buttonCash.addTarget(self, action: #selector(selectCash(_:)),for:UIControlEvents.touchUpInside)
        buttonCard.addTarget(self, action: #selector(selectCard(_:)), for: UIControlEvents.touchUpInside)
        
        buttonCancel.addTarget(self, action: #selector(selectCancel(_sender:)), for: UIControlEvents.touchUpInside )
        buttonPicture.addTarget(self, action: #selector(selectPicture(_sender:)), for: UIControlEvents.touchUpInside)
    }
    
    func selectCash(_ sender:UIButton)
    {
        print("ButtonCash touched")
    }
    
    func selectCard(_ sender:UIButton)
    {
        print("ButtonCard touched")
    }
    
    func selectFood(_ sender:UIButton)
    {
        print("ButtonFood touched")
    }
    
    func selectShopping(_ sender:UIButton)
    {
        print("ButtonShopping touched")
    }
    func selectTour(_ sender:UIButton)
    {
        print("ButtonTour touched")
    }
    func selectTraffic(_ sender:UIButton)
    {
        print("ButtonTraffic touched")
    }
    func selectStay(_ sender:UIButton)
    {
        print("ButtonStay touched")
    }
    func selectEtc(_ sender:UIButton)
    {
        print("ButtonEtc touched")
    }
    
    func selectCancel( _sender:UIButton)
    {
        print("ButtonCancel touched")
        self.dismiss(animated: true, completion: nil)
    }
    
    func selectPicture( _sender:UIButton)
    {
        print("ButtonPicture touched")
        
        let alertController = UIAlertController.init()
        let takePicture = UIAlertAction(title: "사진찍기", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            print("take a Pickture Button Pressed")
        })

        let  pickPhoto = UIAlertAction(title: "앨범에서 고르기", style: UIAlertActionStyle.default) { (action) -> Void in
            print("pickPhoto Button Pressed")
        }
        let cancel = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: { (action) -> Void in
            print("Cancel Button Pressed")
        })
        alertController.addAction(takePicture)
        alertController.addAction(pickPhoto)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func initButtonPosition(){
        var buttonLocationX = firstButtonLocationX
        var buttonLocationY = firstButtonLocationY
        let buttonArray : NSMutableArray = NSMutableArray.init()
        
        buttonArray.add(button1)
        buttonArray.add(button2)
        buttonArray.add(button3)
        buttonArray.add(buttonDiv)
        
        buttonArray.add(button4)
        buttonArray.add(button5)
        buttonArray.add(button6)
        buttonArray.add(buttonMul)
        
        buttonArray.add(button7)
        buttonArray.add(button8)
        buttonArray.add(button9)
        buttonArray.add(buttonPlus)
        
        buttonArray.add(buttonDot)
        buttonArray.add(button0)
        buttonArray.add(buttonDelete)
        buttonArray.add(buttonMinus)
        
        for i in 1...16
        {
            let button : UIButton = buttonArray.object(at: i-1) as! UIButton
       
            button.frame(forAlignmentRect: CGRect.init(x: buttonLocationX , y: buttonLocationY, width: buttonWidth, height: buttonHeight))
            button.layer.borderWidth = 0.3
            button.layer.borderColor = imageViewBottom.backgroundColor?.cgColor

            if(i%4 == 0)
            {
                buttonLocationX = firstButtonLocationX
                buttonLocationY = buttonLocationY + buttonWidth
            }
            
        }
    }

}