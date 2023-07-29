//
//  SettingsViewController.swift
//  Randomizer
//
//  Created by Matvei Khlestov on 28.05.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var randomNumber: RandomNumber!
    
    var delegate: SettingsViewControllerDelegate!
    
    private let stackViewForTextfields = UIStackView()
    
    private lazy var minimumValueTF: UITextField = {
        createTextfield(
            withText: String(randomNumber.minimumValue),
            andPlaceholder: "Minimum Value"
        )
    }()
    
    private lazy var maximumValueTF: UITextField = {
        createTextfield(
            withText: String(randomNumber.maximumValue),
            andPlaceholder: "Maximum Value"
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        minimumValueTF.delegate = self
        maximumValueTF.delegate = self
        
        setupSubviews(
            minimumValueTF,
            maximumValueTF,
            stackViewForTextfields
        )
        
        setupNavigationController()
        
        stackViewsConfigure()
        
        setConstraints()
    }
    
    private func setupNavigationController() {
        
        title = "Settings"
        
        navigationItem.largeTitleDisplayMode = .never
        
        let rightBarButtonItem = createCustomBarButtonItem(
            title: "Save",
            color: UIColor(named: "saveButtonColor") ?? .systemBlue,
            selector: #selector(saveButtonTapped)
        )
        let leftBarButtonItem = createCustomBarButtonItem(
            title: "Cancel",
            color: UIColor(named: "cancelButtonColor") ?? .systemBlue,
            selector: #selector(cancelButtonTapped)
        )
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func createCustomBarButtonItem(title: String, color: UIColor,
                                           selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.tintColor = color
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
    
    @objc private func saveButtonTapped() {
        view.endEditing(true)
        
        delegate.setNewValues(for: randomNumber)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func createTextfield(withText text: String,
                                 andPlaceholder placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.text = text
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        
        return textField
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    private func setupSubviewsForStackView(_ subviews: UIView...) {
        for subview in subviews {
            stackViewForTextfields.addArrangedSubview(subview)
        }
    }
    
    private func stackViewAutoLayouts() {
        stackViewForTextfields.axis = .vertical
        stackViewForTextfields.alignment = .fill
        stackViewForTextfields.distribution = .fill
        stackViewForTextfields.spacing = 24
    }
    
    private func stackViewsConfigure() {
        stackViewAutoLayouts()
        
        setupSubviewsForStackView(
            minimumValueTF,
            maximumValueTF
        )
        
        stackViewForTextfields.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                stackViewForTextfields.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: 60
                ),
                stackViewForTextfields.leadingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: 60
                ),
                stackViewForTextfields.trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: -60
                )
            ]
        )
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Int(newValue) else { return }
        
        if textField == minimumValueTF {
            randomNumber.minimumValue = numberValue
            
        } else {
            randomNumber.maximumValue = numberValue
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
