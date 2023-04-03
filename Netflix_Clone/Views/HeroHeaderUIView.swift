//
//  HeroHeaderUIView.swift
//  Netflix clone
//
//  Created by Lina on 16/11/22.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    
    private let playButton: UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        return button
    }()
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill//.scaleAspectFit .redraw
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "lightyear-poster")
        return imageView
    }()
    
    private func addGradiant() {
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradiantLayer.frame = bounds
        layer.addSublayer(gradiantLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradiant()
        addSubview(playButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let playButtonConstraints = [
            
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomAnchor.constraint(equalToSystemSpacingBelow: playButton.bottomAnchor, multiplier: 6),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
    }
    public func configure(with model: TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        heroImageView.sd_setImage(with: url, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        
        print("pew")
    }
}
