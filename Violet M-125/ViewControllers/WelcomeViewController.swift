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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeScreens = [
            WelcomeScreenSlide(
                title: "ФИАЛКА М-125",
                description: "Лучшая советсткая шифровальная машина",
                image: "violet-m-125-1"
            ),
            WelcomeScreenSlide(
                title: "Возможности",
                description: "1. Зашифровать сообщение\n 2. Расшифровать сообщение",
                image: "violet-m-125-2"
            ),
            WelcomeScreenSlide(
                title: "Надежная защита",
                description: "Для любой переписки",
                image: "violet-m-125-3"
            )
        ]
    }
}
//MARK: extentions
extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        welcomeScreens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WelcomeCollectionViewCell.identifier,
                for: indexPath
       ) as? WelcomeCollectionViewCell {
           cell.setup(welcomeScreens[indexPath.row])
           return cell
       } else {
           let cell = UICollectionViewCell()
           return cell
       }
    }
}
