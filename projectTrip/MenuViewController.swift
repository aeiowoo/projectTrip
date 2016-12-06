//
//  MenuViewController.swift
//  projectTrip
//
//  Created by Friday on 2016. 12. 6..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var TitleLabel: UILabel!
    
    var data : MainViewController.menuData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createViewContents()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createViewContents() {
        
        self.TitleLabel.text = data?.titleName
    }

}
