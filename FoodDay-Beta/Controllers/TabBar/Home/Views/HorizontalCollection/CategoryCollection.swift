//
//  CategoryCollection.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 25.12.2023.
//

import UIKit

protocol CategoryCollectionSelectMealType {
    func mealTypeSelected(_ type: String)
}

final class CategoryCollection: UICollectionView {
    var categoryCollectionSelectDelegate: CategoryCollectionSelectMealType?
    
    private let categoryLayout = UICollectionViewFlowLayout()
    private let categoryName = R.Strings.Home.typesOfRecipes
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: categoryLayout)
        setupViews()
        layoutView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CategoryCollection {
    func setupViews() {}
    func layoutView() {}
    
    func configure() {
        categoryLayout.minimumInteritemSpacing = 10
        categoryLayout.scrollDirection = .horizontal
        
        backgroundColor = .none
        bounces = false
        showsHorizontalScrollIndicator = false
        
        delegate = self
        dataSource = self
        
        
        register(CategoryCollectionCell.self, forCellWithReuseIdentifier: "cell")
        selectItem(at: [0, 0], animated: false, scrollPosition: [])
    }
}

//MARK: - UICollectionDataSource
extension CategoryCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CategoryCollectionCell else { return UICollectionViewCell() }
        cell.nameOfCategory.text = categoryName[indexPath.row]
        
        return cell
    }
    
    
}

//MARK: - UICollectionViewDelegate
extension CategoryCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        switch indexPath.row {
        case 0:
            categoryCollectionSelectDelegate?.mealTypeSelected("")
        case 1:
            categoryCollectionSelectDelegate?.mealTypeSelected("breakfast")
        case 2:
            categoryCollectionSelectDelegate?.mealTypeSelected("branch")
        case 3:
            categoryCollectionSelectDelegate?.mealTypeSelected("dinner")
        case 4:
            categoryCollectionSelectDelegate?.mealTypeSelected("snack")
        case 5:
            categoryCollectionSelectDelegate?.mealTypeSelected("teatime")
        default:
            print("base")
        }
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CategoryCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let categoryFont = UIFont(name: "Arial Bold", size: 18)
        let categoryAttributes = [NSAttributedString.Key.font: categoryFont as Any ]
        let categoryWitdh = categoryName[indexPath.row].size(withAttributes: categoryAttributes).width + 20
        
        
        return CGSize(width: categoryWitdh, height: collectionView.frame.height)
    }
}
