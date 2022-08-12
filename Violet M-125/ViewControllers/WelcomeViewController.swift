//
//  WelcomeViewController.swift
//  Violet M-125
//
//  Created by Иван Дрожжин on 11.08.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var welcomePageControl: UIPageControl!
    
    var welcomeScreens: [WelcomeScreenSlide] = []
    var currentPage = 0 {
        didSet {
            welcomePageControl.currentPage = currentPage
            if currentPage == welcomeScreens.count - 1 {
                nextButton.isHidden = false
            } else {
                nextButton.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeScreens = [
            WelcomeScreenSlide(
                title: "ФИАЛКА М-125",
                description: "Лучшая советсткая шифровальная машина",
                image: "violet-m-125-1"
            ),
            WelcomeScreenSlide(
                title: "Возможности:",
                description: "1. Зашифровать сообщение\n 2. Расшифровать сообщение",
                image: "violet-m-125-2"
            ),
            WelcomeScreenSlide(
                title: "Надежная защита",
                description: "Для любой переписки",
                image: "violet-m-125-3"
            )
        ]
        
        nextButton.isHidden = true
        nextButton.layer.cornerRadius = 10
    }
}
//MARK: extensions
extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        welcomeScreens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WelcomeCollectionViewCell.identifier,
                for: indexPath
       ) as! WelcomeCollectionViewCell
           cell.setup(welcomeScreens[indexPath.row])
           return cell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = view.frame.width - 32
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
    
}
