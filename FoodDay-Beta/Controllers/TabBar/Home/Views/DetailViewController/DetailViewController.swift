//
//  DeatilView.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 14.02.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    var ingredientLines: [String]?
    let backButton = UIButton()
    let imageView = UIImageView()
    let descriptionView = UIView()
    let nameOfRecipe = UILabel()
    let separator = UIView()
    let necProdubcts = UILabel()
    let ingredients = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        layoutView()
        configure()
    }
    
    @objc func backButtonPressed() {
//        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = false
    }
    
}

extension DetailViewController {
    func setupViews() {
        view.setupView(imageView)
        view.setupView(backButton)
        view.setupView(descriptionView)
        
        descriptionView.setupView(nameOfRecipe)
        descriptionView.setupView(separator)
        descriptionView.setupView(necProdubcts)
        descriptionView.setupView(ingredients)
    }
    
    func layoutView() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            descriptionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nameOfRecipe.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 10),
            nameOfRecipe.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 20),
            nameOfRecipe.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -20),
            
            separator.topAnchor.constraint(equalTo: nameOfRecipe.bottomAnchor, constant: 10),
            separator.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 2),
            
            necProdubcts.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10),
            necProdubcts.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 20),
            necProdubcts.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -20),
            
            ingredients.topAnchor.constraint(equalTo: necProdubcts.bottomAnchor, constant: 10),
            ingredients.leadingAnchor.constraint(equalTo: necProdubcts.leadingAnchor, constant: 10),
            ingredients.trailingAnchor.constraint(equalTo: necProdubcts.trailingAnchor, constant: -10)
        ])
        
    }
    
    func configure() {
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
        backButton.setImage(R.Images.Navigation.backArrow, for: .normal)
        backButton.tintColor = R.Colors.black
        backButton.backgroundColor = .white.withAlphaComponent(0.7)
        backButton.layer.cornerRadius = CGFloat(5)
        backButton.layer.masksToBounds = true
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        descriptionView.backgroundColor = R.Colors.backgroundSecond
        descriptionView.layer.cornerRadius = 15
        descriptionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        nameOfRecipe.font = R.Fonts.helveticaRegular(with: 40)
        nameOfRecipe.textColor = R.Colors.text
        nameOfRecipe.numberOfLines = 0
        
        separator.backgroundColor = R.Colors.separator
        
        necProdubcts.font = R.Fonts.helveticaRegular(with: 30)
        necProdubcts.textColor = R.Colors.text
        necProdubcts.numberOfLines = 1
        necProdubcts.text = "Necessary products"
        
        ingredients.font = R.Fonts.helveticaRegular(with: 20)
        ingredients.numberOfLines = 0
        ingredients.textColor = R.Colors.text
        ingredients.text = ""
        
        if let ingredientLines = ingredientLines {
            for ingredient in ingredientLines {
                ingredients.text! += "• " + ingredient + "\n"
            }
        }
    }
}
