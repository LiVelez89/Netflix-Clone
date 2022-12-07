//
//  TitleCollectionViewCell.swift
//  Netflix_Clone
//
//  Created by Lina on 29/11/22.
//

import UIKit
import SDWebImage

//This is the cell that is responsable for handling everything inside the collection view
class TitleCollectionViewCell: UICollectionViewCell {
 
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    //After intalled SDWebImage create this function: each time we dequeue a cell in our collectionViewCell we need to have an update function so we can update the poster for each cell with the models that we have in the HomeViewController
    public func configure(with model: String) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            return
        }
       posterImageView.sd_setImage(with: url, completed: nil)
    }
}
