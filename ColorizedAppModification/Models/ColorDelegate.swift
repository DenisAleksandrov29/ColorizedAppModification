//
//  ColorDelegate.swift
//  ColorizedAppModification
//
//  Created by Денис Александров on 25.05.2024.
//

import UIKit

protocol ColorDelegate: AnyObject {
    func didSelectColor(_ color: UIColor)
    func didSelectRGB(red: CGFloat, green: CGFloat, blue: CGFloat)
}
