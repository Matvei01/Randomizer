//
//  MainViewController.swift
//  Randomizer
//
//  Created by Matvei Khlestov on 28.05.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewValues(for minimumNumber: String, and maximumNumber: String)
}

class MainViewController: UIViewController {
    
    private let stackView = UIStackView()
    
    private var minimumValue = 0
    private var maximumValue = 100
    
    private lazy var minimumValueLabel: UILabel = {
        createLabel(with: String(minimumValue), andFont: .systemFont(ofSize: 50))
    }()
    
    private lazy var maximumValueLabel: UILabel = {
        createLabel(with: String(maximumValue), andFont: .systemFont(ofSize: 50))
    }()
    
    private lazy var randomValueLabel: UILabel = {
        createRandomValueLabel()
    }()
    
    private lazy var labelPretextFrom: UILabel = {
        createLabel(with: "from", andFont: .systemFont(ofSize: 29))
    }()
    
    private lazy var labelPretextTo: UILabel = {
        createLabel(with: "to", andFont: .systemFont(ofSize: 29))
    }()
    
    private lazy var randomNumberButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = .systemFont(ofSize: 29)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.baseBackgroundColor = UIColor(named: "randomButtonColor")
        buttonConfiguration.attributedTitle = AttributedString("Get Result", attributes: attributes)
        
        let button = UIButton(configuration: buttonConfiguration, primaryAction: UIAction { [unowned self] _ in
            getRandomNumberButton()
        })
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var getRandom: Int {
        Int.random(in: minimumValue...maximumValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupSubviews(
            labelPretextFrom,
            minimumValueLabel,
            labelPretextTo,
            maximumValueLabel,
            randomValueLabel,
            stackView,
            randomNumberButton
        )
        setupNavigationBar()
        
        stackViewConfigure()
        
        setConstraints()
    }
    
    private func setupNavigationBar() {
        title = "Random Number"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        createCustomBarButtonItem()
    }
    
    private func createCustomBarButtonItem() {
        let button = UIButton(type: .system)
        button.setTitle("Settings", for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        let rightBarButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func settingsButtonTapped() {
        let settingsViewController = SettingsViewController()
        settingsViewController.minimumValue = minimumValueLabel.text ?? "0"
        settingsViewController.maximumValue = maximumValueLabel.text ?? "100"
        settingsViewController.delegate = self
        
        present(settingsViewController, animated: true)
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    private func setupSubviewsForStackView(_ subviews: UIView...) {
        for subview in subviews {
            stackView.addArrangedSubview(subview)
        }
    }
    
    private func stackViewConfigure() {
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.distribution = .fillProportionally
        stackView.spacing = 33
        
        setupSubviewsForStackView(
            labelPretextTo,
            minimumValueLabel,
            labelPretextFrom,
            maximumValueLabel
        )
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func getRandomNumberButton() {
        randomValueLabel.text = String(getRandom)
    }
    
    private func createLabel(with text: String, andFont: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.font = andFont
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }
    
    private func createRandomValueLabel() -> UILabel {
        let label = UILabel()
        label.text = "?"
        label.font = UIFont.systemFont(ofSize: 98, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                randomNumberButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
                randomNumberButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 57),
                randomNumberButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -57)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                randomValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                randomValueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewValues(for minimumNumber: String, and maximumNumber: String) {
        minimumValueLabel.text = minimumNumber
        maximumValueLabel.text = maximumNumber
    }
}


