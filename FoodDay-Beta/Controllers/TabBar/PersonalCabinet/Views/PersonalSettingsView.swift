//
//  PersonalSettingsView.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 31.12.2023.
//


// dop setting
import UIKit

final class PersonalSettingsView: UIView {
    
    private let personalSetLabel = UILabel()
    private let separator = UIView()
    
    private let nameImageView = UIImageView()
    private let nameLabel = UILabel()
    private let nameLeftArrow = UIImageView()
    
    private let emailImageView = UIImageView()
    private let emailLabel = UILabel()
    private let emailLeftArrow = UIImageView()
    
    private let changePassImageView = UIImageView()
    private let changePassLabel = UILabel()
    private let changePassLeftArrow = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        layoutViews()
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PersonalSettingsView {
    func setupViews() {
        
    }
    
    func layoutViews() {
        
    }
    
    func configure() {
        
    }
}
