//
//  SettingViewController.swift
//  ColorizedAppModification
//
//  Created by Денис Александров on 25.05.2024.
//

import UIKit

final class SettingViewController: UIViewController {
    
    weak var delegate: ColorDelegate?
    
    var selectedColor: UIColor?
    
    // MARK: - IB Outlets
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let color = selectedColor {
            
            colorView.backgroundColor = color
            colorView.layer.cornerRadius = 15
            
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            redSlider.value = Float(red)
            greenSlider.value = Float(green)
            blueSlider.value = Float(blue)
            
            updateLabelsAndTextFields()
        }
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        redTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        greenTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        blueTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
    }
    
    // MARK: - IB Actions
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        updateColorView()
        updateLabelsAndTextFields()
    }
    func updateColorView() {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        colorView.backgroundColor = color
        
    }
    func updateLabelsAndTextFields() {
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
        
    }
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        delegate?.didSelectColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extension
extension SettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
        
    }
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let value = Float(text), value >= 0, value <= 1 {
            if textField == redTextField {
                redSlider.value = value
            } else if textField == greenTextField {
                greenSlider.value = value
            } else if textField == blueTextField {
                blueSlider.value = value
            }
            updateColorView()
            updateLabelsAndTextFields()
        } else {
            textField.text = ""
            textField.placeholder = "0.00"
        }
    }
}
    
