//
//  TripListSubMenuViewController.swift
//  projectTrip
//
//  Created by Friday on 2016. 12. 11..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class TripListSubMenuViewController: UIViewController {

    @IBOutlet var tripListSubMenuTabelView: UITableView!
    
    let datas = TripListSubMenuDatas.getDatas()
    
    struct TripListSubMenuDatas {
        
        let image : String
        let label : String
        
        static func getDatas() -> [TripListSubMenuDatas] {
            
            return [TripListSubMenuDatas(image: "icon00", label: "카테고리 설정"),
            TripListSubMenuDatas(image: "icon01", label: "본국 설정"),
            TripListSubMenuDatas(image: "icon04", label: "백업/복구"),
            TripListSubMenuDatas(image: "icon05", label: "평점/리뷰 남기기"),
            TripListSubMenuDatas(image: "icon06", label: "버그 신고 및 제안")]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        
        print("swipe")
        dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tripListSubMenuTabelView.indexPathForSelectedRow {
            
            print(indexPath)
        }
        
    }
}

extension TripListSubMenuViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripListSubTableViewCell") as! TripListSubTableViewCell
        
        cell.tripListSubImage.image = UIImage.init(named: datas[indexPath.row].image)
        cell.tripListSubLabel.text = datas[indexPath.row].label
        
        return cell
    }
}















