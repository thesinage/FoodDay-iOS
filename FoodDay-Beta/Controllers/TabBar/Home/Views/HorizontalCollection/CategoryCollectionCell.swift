//
//  CategoryCollectionCell.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 25.12.2023.
//

import UIKit

final class CategoryCollectionCell: UICollectionViewCell {
    
    let nameOfCategory = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
       
        setupViews()
        layoutView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor  = self.isSelected ? R.Colors.green : R.Colors.backgroundSecond
            nameOfCategory.textColor = self.isSelected ? R.Colors.white : R.Colors.text
            
        }
    }
}

extension CategoryCollectionCell {
    func setupViews() {
        setupView(nameOfCategory)
    }
    func layoutView() {
        NSLayoutConstraint.activate([
            nameOfCategory.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameOfCategory.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    func configure() {
        nameOfCategory.textAlignment = .center
        nameOfCategory.textColor = R.Colors.text
        backgroundColor = R.Colors.backgroundSecond
        layer.cornerRadius = 15
        
        nameOfCategory.font = R.Fonts.helveticaRegular(with: 17)
    }
}
