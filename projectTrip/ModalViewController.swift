//
//  ModalViewController.swift
//  projectTrip
//
//  Created by Friday on 2016. 12. 6..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    @IBOutlet var menuTableView: UITableView!
    
    //숨겨진 뷰에 쓰일 메뉴 데이터 구조체
    struct MenuData {
        
        let titleName : String
        let imageName : String
    }

    var data = [MenuData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //데이터 세팅
        setDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onButton(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    //데이터 세팅
    func setDatas() {
        
        data = [MenuData(titleName: "카테고리 설정", imageName: "icon00"),
                MenuData(titleName: "본국 설정", imageName: "icon01"),
                MenuData(titleName: "백업/복구", imageName: "icon04"),
                MenuData(titleName: "평점/리뷰 남기기", imageName: "icon05"),
                MenuData(titleName: "버그 신고 및 제안", imageName: "icon06")]
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MenuSegue" {
            
            if let indexPath = self.menuTableView.indexPathForSelectedRow {
                
                let menuVC = segue.destination as! MenuViewController
                menuVC.data = data[indexPath.row]
            }
        }
        
    }
}

extension ModalViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        
        cell.menuLabel.text = data[indexPath.row].titleName
        cell.imageView?.image = UIImage(named: data[indexPath.row].imageName)
        
        return cell
    }
}


























