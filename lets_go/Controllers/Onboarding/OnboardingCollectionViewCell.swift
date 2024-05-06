//
//  OnboardingCollectionViewCell.swift
//  lets_go
//
//  Created by Ishan Singla on 05/05/24.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    func setup(_ slide: OnboardingSlide) {
        title.text = slide.title
        des.text = slide.description
        image.image = slide.image
    }
}
