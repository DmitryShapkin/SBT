//
//  AnimalCollectionViewCell.swift
//  SBT-Lesson-11 Homework-UICollectionView
//
//  Created by Dmitry Shapkin on 25/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


import UIKit


class AnimalCollectionViewCell: UICollectionViewCell {
    
    var containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16.0
        return view
    }()
    
    var coverImageView: UIImageView = {
        var coverImageView = UIImageView()
        coverImageView.translatesAutoresizingMaskIntoConstraints = false;
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        return coverImageView
    }()
    
    var animalNameLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleLabel.numberOfLines = 0
        titleLabel.isUserInteractionEnabled = false
        return titleLabel
    }()
    
    var someFactLabel: UILabel = {
        var subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false;
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.systemFont(ofSize: 14.0)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.isUserInteractionEnabled = false
        return subtitleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.addSubview(coverImageView)
        containerView.addSubview(animalNameLabel)
        containerView.addSubview(someFactLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            animalNameLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 6),
            animalNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            animalNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            animalNameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            someFactLabel.topAnchor.constraint(equalTo: animalNameLabel.bottomAnchor, constant: 4),
            someFactLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            someFactLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            someFactLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
            ])
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
