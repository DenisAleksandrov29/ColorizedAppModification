//
//  ViewController.swift
//  ColorizedAppModification
//
//  Created by Денис Александров on 25.05.2024.
//

import UIKit

 final class MainViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSettingViewController" {
            if let navigationController = segue.destination as? UINavigationController,
               let secondVC = navigationController.topViewController as? SettingViewController {
                secondVC.delegate = self
                secondVC.selectedColor = colorView.backgroundColor
            } else if let secondVC = segue.destination as? SettingViewController {
                secondVC.delegate = self
                secondVC.selectedColor = colorView.backgroundColor
            }
        }
    }
}

// MARK: - Extension
extension MainViewController: ColorDelegate {
    func didSelectRGB(red: CGFloat, green: CGFloat, blue: CGFloat) {
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        view.backgroundColor = color
        
    }
    func didSelectColor(_ color: UIColor) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        didSelectRGB(red: red, green: green, blue: blue)
    }
}


