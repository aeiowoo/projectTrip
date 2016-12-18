//
//  TripListViewController.swift
//  projectTrip
//
//  Created by Friday on 2016. 12. 11..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class TripListViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!

    var tripGirdLayout : TripGirdLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createViewContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func createViewContents() {
        
        //네비게이션 바 색 설정
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 71/255, green: 173/255, blue: 247/255, alpha: 1)
        
        //네비게이션 타이틀 커스텀 이미지
        let titleImage = UIImage.init(named: "title")
        self.navigationItem.titleView = UIImageView.init(image: titleImage)
        
        //오른쪽 바 버튼 아이템
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(onAddButton))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        //컬렉션 뷰 격자 설정 클래스
        tripGirdLayout = TripGirdLayout(numberOfColumns: 2)
        collectionView.collectionViewLayout = tripGirdLayout
        collectionView.reloadData()
        
    }
    
    // + 버튼 눌렀을 때
    func onAddButton() {
        
        let titleInputController = self.storyboard?.instantiateViewController(withIdentifier: "TripTitleInputViewController") as! TripTitleInputViewController
        titleInputController.modalTransitionStyle = .crossDissolve
        present(titleInputController, animated: true, completion: nil)
    }

    //보류
    @IBAction func onMenuButton(_ sender: UIBarButtonItem) {
        
        let modalVC = self.storyboard?.instantiateViewController(withIdentifier: "TripListSubMenuViewController") as! TripListSubMenuViewController
        modalVC.modalPresentationStyle = .overCurrentContext
//        modalVC.transitioningDelegate = self
        present(modalVC, animated: true, completion: nil)
    }
    
}

extension TripListViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripListCell", for: indexPath) as! TripListCollectionViewCell
        
        return cell
    }
}











