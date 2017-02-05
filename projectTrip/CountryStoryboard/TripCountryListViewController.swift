//
//  TripCountryListViewController.swift
//  projectTrip
//
//  Created by Magic Dan on 22/01/2017.
//  Copyright © 2017 SwiftTive. All rights reserved.
//

import UIKit

class TripCountryListViewController: UIViewController {

    @IBOutlet weak var countryTableView: UITableView!
    
    let countryData = TRDataManager.getCountryDatas()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countryTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TripCountryListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! TripCountryListTableViewCell
        
        cell.countryLabel.text = countryData[indexPath.row].countryName
        
        return cell
    }
}






