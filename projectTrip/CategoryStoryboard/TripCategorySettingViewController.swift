//
//  TripCategorySettingViewController.swift
//  projectTrip
//
//  Created by Friday on 2016. 12. 18..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class TripCategorySettingViewController: UIViewController {
    
    @IBOutlet var TripCategorySettingTableView: UITableView!
    
    let datas = TripCategorySettingDatas.getDatas()
    
    struct TripCategorySettingDatas {
        
        let image : String
        let label : String
        
        static func getDatas() -> [TripCategorySettingDatas] {
            
            return [TripCategorySettingDatas(image: "icon00", label: "식비"),
                    TripCategorySettingDatas(image: "icon01", label: "쇼핑"),
                    TripCategorySettingDatas(image: "icon04", label: "관광"),
                    TripCategorySettingDatas(image: "icon05", label: "교통"),
                    TripCategorySettingDatas(image: "icon06", label: "숙박")]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createViewContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func createViewContents() {
        
        //네비게이션 바 색 설정
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 71/255, green: 173/255, blue: 247/255, alpha: 1)
        
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension TripCategorySettingViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCategorySettingViewCell") as!TripCategorySettingViewCell
        
        cell.categoryImage.image = UIImage(named: datas[indexPath.row].image)
        cell.categoryLabel.text = datas[indexPath.row].label
        
        return cell
    }
}












