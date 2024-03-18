//
//  ProductCollectionCell.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 27.12.2023.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell {
    
    var selfLink: String = ""
    
    let image = UIImageView()
    let title = UILabel()
    let subTitle = UILabel()
    @objc let isFavouriteButton = UIButton()
    let vStack = UIStackView()

    var isFavourite: Bool = false
    
    var buttonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        layoutViews()
        configure()
        setColor()
        
        
    }
    
    override func prepareForReuse() {
        setColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProductCollectionCell {
    func setupViews() {
        setupView(image)
        setupView(vStack)
        
        vStack.addArrangedSubview(title)
        vStack.addArrangedSubview(subTitle)
        
        setupView(isFavouriteButton)
    }
    
    
    // w:100  h:80
    func layoutViews() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            image.widthAnchor.constraint(equalToConstant: 100),
            
            vStack.topAnchor.constraint(equalTo: image.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            vStack.trailingAnchor.constraint(equalTo: isFavouriteButton.leadingAnchor, constant: -10),
            
            isFavouriteButton.topAnchor.constraint(equalTo: image.topAnchor),
            isFavouriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            isFavouriteButton.heightAnchor.constraint(equalToConstant: 25),
            isFavouriteButton.widthAnchor.constraint(equalTo: isFavouriteButton.heightAnchor),
            
            
        ])
    }
    
    func configure() {
        layer.backgroundColor = R.Colors.backgroundSecond.cgColor
        layer.cornerRadius = 14
        layer.masksToBounds = true
        
        image.layer.cornerRadius = 14
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.distribution = .fillEqually
        vStack.spacing = 2
        
        title.font = R.Fonts.helveticaRegular(with: 17)
        title.textColor = R.Colors.text
        title.numberOfLines = 0
        
        subTitle.font = R.Fonts.helveticaRegular(with: 14)
        subTitle.textColor = R.Colors.text.withAlphaComponent(0.5)
        
        isFavouriteButton.setImage(R.TestCell.isFavourite, for: .normal)
        isFavouriteButton.backgroundColor = .none
        isFavouriteButton.tintColor = .gray.withAlphaComponent(0.5)
        isFavouriteButton.addTarget(self, action: #selector(isFavouriteButtonPressed), for: .touchUpInside)
    }
}


extension ProductCollectionCell {
    @objc func isFavouriteButtonPressed(sender: UIButton) {
        changeFavRecipe(recipe: selfLink)
        buttonTapped?()
        
        NotificationCenter.default.post(name: NSNotification.Name("favButtonTapped"), object: nil)
    }
    
    func setColor() {
        DatabaseManager.shared.getPost { recipesData in
            guard let favouriteRecipes = recipesData?.favouriteRecipes else { return }
            for recipe in favouriteRecipes {
                if self.selfLink == recipe {
                    self.isFavouriteButton.tintColor = .red
                    break
                } else {
                    self.isFavouriteButton.tintColor = .gray.withAlphaComponent(0.5)
                }
            }
        }
    }
    
    func changeFavRecipe(recipe: String) {
        DatabaseManager.shared.getPost { recipesData in
            guard let recipes = recipesData?.favouriteRecipes else { return }
            
            if let positionOfSimilaRecipe = recipes.firstIndex(of: recipe) {
                DatabaseManager.shared.removeRecipe(removePos: positionOfSimilaRecipe)
            } else {
                DatabaseManager.shared.addRecipe(addRecipe: recipe)
            }
            
        }
    }
}

