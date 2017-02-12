//
//  TripListViewController.swift
//  projectTrip
//
//  Created by Friday on 2016. 12. 11..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class TripListViewController: UIViewController {
    
    let masterDatas =  TRDataManager.getTripMasterDatas()
    
    @IBOutlet var collectionView: UICollectionView!
    
    let transition = TripModalAnimator()
    let dismissTransition = TripDismissModalAnimator()
    let interactionController = TripSwipeInterationController()
    
    var tripGirdLayout : TripGirdLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createViewContents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.reloadData()
    }
    
    func createViewContents() {
        
        //네비게이션 바 색 설정
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 71/255, green: 173/255, blue: 247/255, alpha: 1)
        
        //네비게이션 타이틀 커스텀 이미지
        let titleImage = UIImage.init(named: "title")
        self.navigationItem.titleView = UIImageView.init(image: titleImage)
        
        //오른쪽 바 버튼 아이템
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(onAddButton))
//        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        //컬렉션 뷰 격자 설정 클래스
        tripGirdLayout = TripGirdLayout(numberOfColumns: 2)
        collectionView.collectionViewLayout = tripGirdLayout
        collectionView.reloadData()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    //보류
    @IBAction func onMenuButton(_ sender: UIBarButtonItem) {
        
        let modalVC = self.storyboard?.instantiateViewController(withIdentifier: "TripListSubMenuViewController") as! TripListSubMenuViewController
        modalVC.modalPresentationStyle = .overCurrentContext
        modalVC.transitioningDelegate = self
        present(modalVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("prepared")
        
        if segue.identifier == "SubMenuSegue" {
            
            let destinationViewController = segue.destination as! TripListSubMenuViewController
            destinationViewController.transitioningDelegate = self
            interactionController.wireToViewController(viewController: destinationViewController)
        }
        
        if segue.identifier == "DetailSegue" {
            
            let destVC = segue.destination as! TripDetailInputViewController
        }
        
    }
}

extension TripListViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.isPresenting = true
        
        UIView.animate(withDuration: 1) {
            
            self.view.backgroundColor = UIColor.black
            self.view.alpha = 0.6
        }
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        dismissTransition.isPresenting = false
        
        UIView.animate(withDuration: 0.7) {
            
            self.view.backgroundColor = UIColor.clear
            self.view.alpha = 1
        }
        
        return dismissTransition
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactionController.interactionInProgress ? interactionController : nil
    }
}

extension TripListViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return masterDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripListCell", for: indexPath) as! TripListCollectionViewCell
        
        let budget = String(masterDatas[indexPath.row].budget)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        formatter.string(for: budget)
        
        cell.tripLabel.text = masterDatas[indexPath.row].title
        cell.tripBudget.text = budget
        
        let date = "\(masterDatas[indexPath.row].startDate) ~ \(masterDatas[indexPath.row].endDate)"
        
        cell.tripDate.text = date
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }
}











