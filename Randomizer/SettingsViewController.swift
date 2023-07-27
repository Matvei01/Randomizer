//
//  SettingsViewController.swift
//  Randomizer
//
//  Created by Matvei Khlestov on 28.05.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var minimumValue = ""
    var maximumValue = ""
    
    var delegate: SettingsViewControllerDelegate!
    
    private let stackViewForTextfields = UIStackView()
    private let stackViewForButtons = UIStackView()
    
    private lazy var minimumValueTF: UITextField = {
        createTextfield(minimumValue, "Minimum Value")
    }()
    
    private lazy var maximumValueTF: UITextField = {
        createTextfield(maximumValue, "Maximum Value")
    }()
    
    private lazy var saveButton: UIButton = {
        createButton(
            withTitle: "Save",
            andColor: UIColor(named: "saveButtonColor") ?? .systemPink,
            action: UIAction { [unowned self] _ in
                saveButtonTapped()
                dismiss(animated: true)
            })
    }()
    
    private lazy var cancelButton: UIButton = {
        createButton(
            withTitle: "Cancel",
            andColor: UIColor(named: "cancelButtonColor") ?? .systemPink,
            action: UIAction { [unowned self] _ in
                dismiss(animated: true)
            })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupSubviews(
            minimumValueTF,
            maximumValueTF,
            saveButton,
            cancelButton,
            stackViewForTextfields,
            stackViewForButtons
        )
        
        stackViewsConfigure()
        
        setConstraints()
    }
    
    private func createButton(withTitle title: String, andColor color: UIColor, action: UIAction) -> UIButton {
        var attributes = AttributeContainer()
        attributes.font = .systemFont(ofSize: 30)
        attributes.foregroundColor = color
        
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.attributedTitle = AttributedString(title, attributes: attributes)
        
        let button = UIButton(configuration: buttonConfiguration, primaryAction: action)
        
        return button
    }
    
    private func createTextfield(_ text: String, _ placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.text = text
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        
        return textField
    }
    
    private func saveButtonTapped() {
        delegate.setNewValues(for: minimumValueTF.text ?? "0", and: maximumValueTF.text ?? "100")
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    private func setupSubviews(stackView: UIStackView, subviews: UIView...) {
        for subview in subviews {
            stackView.addArrangedSubview(subview)
        }
    }
    
    private func stackViewAutoLayouts(_ stackView: UIStackView, spacing: CGFloat) {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = spacing
    }
    
    private func stackViewsConfigure() {
        stackViewAutoLayouts(stackViewForTextfields, spacing: 24)
        stackViewAutoLayouts(stackViewForButtons, spacing: 8)
        
        setupSubviews(
            stackView: stackViewForTextfields,
            subviews: minimumValueTF, maximumValueTF
        )
        
        setupSubviews(
            stackView: stackViewForButtons,
            subviews: saveButton, cancelButton
        )
        
        stackViewForTextfields.translatesAutoresizingMaskIntoConstraints = false
        stackViewForButtons.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                stackViewForTextfields.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
                stackViewForTextfields.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
                stackViewForTextfields.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                stackViewForButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackViewForButtons.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }
}

extension SettingsViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
