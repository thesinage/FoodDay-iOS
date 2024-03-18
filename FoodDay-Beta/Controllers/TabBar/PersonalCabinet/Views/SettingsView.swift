//
//  SettingsView.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 27.12.2023.
//

import UIKit

enum Theme: Int {
    case light
    case dark
    
    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

final class SettingsView: UIView {
    
    private let settingsTitle = UILabel()
    private let separator = UIView()
    
    private let langImageView = UIImageView()
    private let langTitle = UILabel()
    private let langButton = UIButton(type: .system) // ?
    
    private let themeModeImageView = UIImageView()
    private let themeModeTitle = UILabel()
    private let themeModeSwitcher = UISwitch()
    
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

extension SettingsView {
    func setupViews() {
        setupView(settingsTitle)
        setupView(separator)
        
        setupView(langImageView)
        setupView(langTitle)
        setupView(langButton)
        
        setupView(themeModeImageView)
        setupView(themeModeTitle)
        setupView(themeModeSwitcher)
        
    }
    func layoutViews() {
        NSLayoutConstraint.activate([
            settingsTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            settingsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            settingsTitle.heightAnchor.constraint(equalToConstant: 25),
            
            separator.topAnchor.constraint(equalTo: settingsTitle.bottomAnchor , constant: 10),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            langImageView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20),
            langImageView.leadingAnchor.constraint(equalTo: settingsTitle.leadingAnchor),
            langImageView.heightAnchor.constraint(equalToConstant: 25),
            langImageView.widthAnchor.constraint(equalToConstant: 25),
            
            langTitle.topAnchor.constraint(equalTo: langImageView.topAnchor),
            langTitle.leadingAnchor.constraint(equalTo: langImageView.trailingAnchor, constant: 10),
            langTitle.heightAnchor.constraint(equalToConstant: 25),
            
            langButton.topAnchor.constraint(equalTo: langImageView.topAnchor),
            langButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            langButton.heightAnchor.constraint(equalToConstant: 25),
            langButton.widthAnchor.constraint(equalToConstant: 80),
            
            themeModeImageView.topAnchor.constraint(equalTo: langImageView.bottomAnchor, constant: 20),
            themeModeImageView.leadingAnchor.constraint(equalTo: settingsTitle.leadingAnchor),
            themeModeImageView.heightAnchor.constraint(equalToConstant: 25),
            themeModeImageView.widthAnchor.constraint(equalToConstant: 25),

            themeModeTitle.topAnchor.constraint(equalTo: themeModeImageView.topAnchor),
            themeModeTitle.leadingAnchor.constraint(equalTo: themeModeImageView.trailingAnchor, constant: 10),
            themeModeTitle.heightAnchor.constraint(equalToConstant: 25),
            
            themeModeSwitcher.topAnchor.constraint(equalTo: themeModeImageView.topAnchor),
            themeModeSwitcher.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -15),
            themeModeSwitcher.heightAnchor.constraint(equalToConstant: 10),
            
        ])
        
    }
    func configure() {
        backgroundColor = R.Colors.backgroundSecond
        layer.cornerRadius = 14
        layer.masksToBounds = true
        
        settingsTitle.text = "General Settings"
        settingsTitle.font = R.Fonts.helveticaRegular(with: 22)
        settingsTitle.textColor = R.Colors.text
        
        separator.backgroundColor = R.Colors.separator
        
        langTitle.text = "Language"
        langTitle.font = R.Fonts.helveticaRegular(with: 18)
        langTitle.textColor = R.Colors.text
        
        langImageView.image = UIImage(systemName: "network")
        langImageView.tintColor = R.Colors.text
        langButton.tintColor = R.Colors.green
        langButton.setTitle("English", for: .normal)
        langButton.titleLabel?.font = R.Fonts.helveticaRegular(with: 18)
        
        themeModeTitle.text = "Light mode"
        themeModeTitle.font = R.Fonts.helveticaRegular(with: 18)
        themeModeTitle.textColor = R.Colors.text
        
        themeModeImageView.image = UIImage(systemName: "moon.stars.fill")
        themeModeImageView.tintColor = R.Colors.text
        themeModeSwitcher.tintColor = R.Colors.text
        themeModeSwitcher.addTarget(self, action: #selector(setTheme), for: .touchUpInside)
        switcherPosition()
        
    }
    
    func switcherPosition() {
        if UserDefaultsManager.shared.theme == .dark {
            themeModeSwitcher.isOn = true
        } else {
            themeModeSwitcher.isOn = false
        }
    }
}

@objc extension SettingsView {
    func setTheme(_ sender: UISwitch) {
        if sender.isOn {
            UserDefaultsManager.shared.theme = Theme(rawValue: 1) ?? .dark
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "themeChanged"), object: nil)
        } else {
            UserDefaultsManager.shared.theme = Theme(rawValue: 0) ?? .light
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "themeChanged"), object: nil)
        }
    }
}
