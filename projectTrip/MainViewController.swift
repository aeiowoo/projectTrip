//
//  MainViewController.swift
//  projectTrip
//
//  Created by Friday on 2016. 12. 4..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let transition = ModalAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //뷰가 보이기 전에 처리해야 할 것들
        createViewContents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createViewContents() {
        
        //네비게이션 바 색 조정
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 255/255, green: 216/255, blue: 88/255, alpha: 1);
        
        //네비게이션 타이틀 커스텀 이미지
        let titleImage = UIImage.init(named: "title1")
        self.navigationItem.titleView = UIImageView.init(image: titleImage)
        
        //슬라이드 뷰 숨겨두기
        //self.hiddenView.frame.origin = CGPoint(x: 0 - self.hiddenView.frame.size.width, y: 0)
        //self.view.addSubview(hiddenView)
        
    }

    @IBAction func onMenuButton(_ sender: UIBarButtonItem) {
        
        let modalVC = self.storyboard?.instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController
        modalVC.transitioningDelegate = self
        modalVC.modalPresentationStyle = .custom
        present(modalVC, animated: true, completion: nil)

    }
    
    
}

extension MainViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.isPresenting = true
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.isPresenting = false
        
        return transition
    }
}



























