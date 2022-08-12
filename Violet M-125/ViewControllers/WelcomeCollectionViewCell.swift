//
//  WelcomeCollectionViewCell.swift
//  Violet M-125
//
//  Created by Иван Дрожжин on 11.08.2022.
//

import UIKit

class WelcomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: WelcomeCollectionViewCell.self)
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func setup(_ slide: WelcomeScreenSlide) {
        headerLabel.text = "Добро пожаловать!"
        titleLabel.text = slide.title
        descriptionLabel.text = slide.description
        imageView.image = UIImage(named: slide.image)
    }
}
