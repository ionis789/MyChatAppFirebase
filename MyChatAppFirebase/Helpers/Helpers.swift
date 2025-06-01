//
//  Helpers.swift
//  MyChatAppFirebase
//
//  Created by Ion Socol on 5/31/25.
//

import UIKit

class Helpers {
    static var shared = Helpers()


    func getTextField(withPlaceHolder text: String) -> UITextField {
        let v = UITextField()
        v.placeholder = text
        v.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        v.textColor = .label
        v.backgroundColor = UIColor.systemGray6
        v.layer.cornerRadius = 12
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.systemGray3.cgColor
        v.clipsToBounds = true
        v.borderStyle = .none

        // Create a left padding for text filed
        let leftSpacing = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        v.leftViewMode = .always
        v.leftView = leftSpacing

        // Shadow
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.05
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        v.layer.shadowRadius = 4
        
        
        return v
    }

}
