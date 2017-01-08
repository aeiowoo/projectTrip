//
//  TestLinkViewController.swift
//  projectTrip
//
//  Created by Dawon on 2016. 12. 11..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import Foundation
import UIKit

class TestLinkViewController: UIViewController {
    
    @IBOutlet weak var buttonDetailInput: UIButton!
    @IBOutlet weak var buttonDetailInfo: UIButton!
    @IBOutlet weak var buttonDetailGraph: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonDetailInput.addTarget(self, action: #selector(showDetailInputView(_:)), for: UIControlEvents.touchUpInside)
    }
    
    func showDetailInputView(_ sender:UIButton)  {
        /*let tripDetailInputViewController : TripDetailInputViewController
            = TripDetailInputViewController.init(nibName: "TripDetailInputViewController", bundle: nil)
        self.present(tripDetailInputViewController, animated: true, completion: nil)
        self.view.addSubview(tripDetailInputViewController.view)*/
    }
}
