//
//  MainViewController.swift
//  projectTrip
//
//  Created by Friday on 2016. 12. 4..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    //숨겨진 뷰
    @IBOutlet var hiddenView: UIView!
    //테이븗 뷰
    @IBOutlet var menuTableView: UITableView!
    
    //숨겨진 뷰에 쓰일 메뉴 데이터 구조체
    struct menuData {
        
        let titleName : String
        let imageName : String
    }
    
    //전역 변수들
    var _isSlideViewOpened = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //뷰가 보이기 전에 처리해야 할 것들
        setDatas()
        createViewContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDatas() {
        
        
    }
    
    func createViewContents() {
        
        // Setting dataSource
//        self.menuTableView.dataSource = self
        
        //네비게이션 바 색 조정
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 71/255, green: 173/255, blue: 247/255, alpha: 1);
        
        //네비게이션 타이틀 커스텀 이미지
        let titleImage = UIImage.init(named: "title")
        self.navigationItem.titleView = UIImageView.init(image: titleImage)
        
        //슬라이드 뷰 숨겨두기
        self.hiddenView.frame.origin = CGPoint(x: 0 - self.hiddenView.frame.size.width, y: 0)
        self.view.addSubview(hiddenView)
        
    }

    // + (추가하기) 버튼
    @IBAction func onAddButton(_ sender: UIBarButtonItem) {
        
        
    }
    
    // 슬라이드 메뉴 버튼
    @IBAction func onMenuButton(_ sender: UIBarButtonItem) {
        
        if !_isSlideViewOpened {
            
            openSlideView()
        }
        else {
            
            closeSlideView()
        }
        
        _isSlideViewOpened = !_isSlideViewOpened
    }
    func openSlideView() {
        
        UIView.animate(withDuration: 0.7, animations: {
            
            self.hiddenView.frame.origin = CGPoint(x: 0, y: 0)
        })
    }
    func closeSlideView() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.hiddenView.frame.origin = CGPoint(x: 0 - self.hiddenView.frame.size.width, y: 0)
        })
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

//extension MainViewController : UITableViewDataSource {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return 5
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell")
//        
//        return cell!
//    }
//}





























