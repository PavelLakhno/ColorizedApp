//
//  SettingsViewController.swift
//  ColorizedApp
//
//  Created by Павел Лахно on 24.09.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redValueTF: UITextField!
    @IBOutlet weak var greenValueTF: UITextField!
    @IBOutlet weak var blueValueTF: UITextField!
    
    @IBOutlet var sliders: [UISlider]!
    
    var delegate: SettingsViewControllerDelegate!
    var backgroundColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 10
        
        sliders[0].value = Float(CIColor(color: backgroundColor).red)
        sliders[1].value = Float(CIColor(color: backgroundColor).green)
        sliders[2].value = Float(CIColor(color: backgroundColor).blue)
        
        sliders.forEach { changeColor($0) }
        [redValueTF, greenValueTF, blueValueTF].forEach {
            $0?.delegate = self
            $0?.inputAccessoryView = addToolBar()
        }
    }
    
    @IBAction func donePressedButton() {
        delegate.setupBackgroundColor(colorView.backgroundColor ?? .gray)
        dismiss(animated: true)
    }
    
    @IBAction func changeColor(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            redValueLabel.text = String(format: "%.2f", sender.value)
            redValueTF.text = String(format: "%.2f", sender.value)
        case 1:
            greenValueLabel.text = String(format: "%.2f", sender.value)
            greenValueTF.text = String(format: "%.2f", sender.value)
        default:
            blueValueLabel.text = String(format: "%.2f", sender.value)
            blueValueTF.text = String(format: "%.2f", sender.value)
        }
        
        setupColor()
    }
}

// MARK: - Private Methods
extension SettingsViewController {
    
    private func setupColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(sliders[0].value),
            green: CGFloat(sliders[1].value),
            blue: CGFloat(sliders[2].value),
            alpha: 1
        )
    }
    
    private func updateSlider(tag: Int, value: Float) {
        sliders[tag].setValue(value, animated: true)
        changeColor(sliders[tag])
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFieldValue = textField.text else { return }
        if (0...1).contains(Float(textFieldValue) ?? 0) {
            guard let newValue = Float(textFieldValue) else { return }
            updateSlider(tag: textField.tag, value: newValue)
        } else {
            showAlert()
        }
    }
}

// MARK: - Alert Controller
extension SettingsViewController {
    
    private func showAlert() {
        let alertMessage = UIAlertController(
            title: "Error",
            message: "Please, enter correct value",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertMessage.addAction(okAction)
        present(alertMessage, animated: true)
    }
}

// MARK: - Keyboard Settings
extension SettingsViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func addToolBar() -> UIToolbar{
        let toolBar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(clickDoneButton)
        )
        toolBar.setItems([space, doneButton], animated: true)
        toolBar.sizeToFit()
        return toolBar
    }
    
    @objc func clickDoneButton() {
        view.endEditing(true)
    }
}
