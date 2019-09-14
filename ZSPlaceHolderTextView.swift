//
//  ZSPlaceHolderTextView.swift
//  ZSPlaceHolderTextView
//
//  Created by Zoeb Sheikh on 14/07/19.
//

import UIKit
import Foundation

class ZSPlaceHolderTextView: UITextView {
    
    @IBInspectable public var placeholder: String? = String.empty
    @IBInspectable public var placeholderColor: UIColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
    fileprivate var placeHolderLabel: UILabel!
    
    var textDidChangeHandler: (()->Void)?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func draw(_ rect: CGRect) {
        
        if let placeholder = placeholder, placeholder.count > 0 {
            
            if (placeHolderLabel == nil) {
                
                NotificationCenter.default.addObserver(self, selector: #selector(textDidChangeNotification), name: UITextView.textDidChangeNotification , object: nil)
                
                placeHolderLabel = UILabel(frame: CGRect(x: 4, y: 7, width: bounds.size.width, height: 0))
                placeHolderLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                placeHolderLabel.numberOfLines = 0
                placeHolderLabel.font = self.font
                placeHolderLabel.backgroundColor = UIColor.clear
                placeHolderLabel.textColor = placeholderColor
                placeHolderLabel.alpha = 0
                placeHolderLabel.tag = 999
                self.addSubview(placeHolderLabel)
            }
            
            placeHolderLabel.text = placeholder;
            placeHolderLabel.sizeToFit()
            self.sendSubviewToBack(placeHolderLabel)
            
            if text.count == 0
            {
                viewWithTag(999)?.alpha = 1;
            }
        }
        
        super.draw(rect)
    }
    
    @objc func textDidChangeNotification(_ notif: Notification) {
        guard self == notif.object as? UITextView else {
            return
        }
        textDidChange()
        textDidChangeHandler?()
    }
    
    func textDidChange() {
        
        guard let count = placeholder?.count, count > 0 else {
            return
        }
        
        viewWithTag(999)?.alpha = text.count == 0 ? 1 : 0
    }
}
