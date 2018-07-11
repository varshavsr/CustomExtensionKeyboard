//
//  KeyboardViewController.swift
//  iOS CustomKeyboard
//
//  Created by varsha s rao on 11/07/18.
//  Copyright © 2018 varsha s rao. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    @IBOutlet var nextKeyboardButton: UIButton!
    
    var capsLockOn = true
    
    @IBOutlet weak var row1: UIView!
    @IBOutlet weak var row2: UIView!
    @IBOutlet weak var row3: UIView!
    @IBOutlet weak var row4: UIView!
    
    @IBOutlet weak var charSet1: UIView!
    @IBOutlet weak var charSet2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "KeyboardView", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)
        view = objects[0] as! UIView
        
        charSet2.isHidden = true
    }
    
    @IBAction func nextKeyboardPressed(button: UIButton) {
        advanceToNextInputMode()
    }
    
    @IBAction func capsLockPressed(button: UIButton) {
        capsLockOn = !capsLockOn
        
        changeCaps(containerView: row1)
        changeCaps(containerView: row2)
        changeCaps(containerView: row3)
        changeCaps(containerView: row4)
    }
    
    @IBAction func keyPressed(button: UIButton) {
        let string = button.titleLabel!.text
        (textDocumentProxy as UIKeyInput).insertText("\(string!)")
        
        button.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.2, animations: {
            button.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }, completion: {(_) -> Void in
            button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    @IBAction func backSpacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    @IBAction func spacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText(" ")
    }
    
    @IBAction func returnPressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    @IBAction func charSetPressed(button: UIButton) {
        if button.titleLabel!.text == "1/2" {
            charSet1.isHidden = true
            charSet2.isHidden = false
            button.setTitle("2/2", for: .normal)
        } else if button.titleLabel!.text == "2/2" {
            charSet1.isHidden = false
            charSet2.isHidden = true
            button.setTitle("1/2", for: .normal)
        }
    }
    
    func changeCaps(containerView: UIView) {
        for view in containerView.subviews {
            if let button = view as? UIButton {
                let buttonTitle = button.titleLabel!.text
                if capsLockOn {
                    let text = buttonTitle!.uppercased
                    button.setTitle("\(text)", for: .normal)
                } else {
                    let text = buttonTitle!.lowercased
                    button.setTitle("\(text)", for: .normal)
                }
            }
        }
    }
    
    /* For creating UIView programmatically
     override func updateViewConstraints() {
     super.updateViewConstraints()
     
     // Add custom view sizing constraints here
     }
     
     override func viewDidLoad() {
     super.viewDidLoad()
     
     let nib = UINib(nibName: "KeyboardView", bundle: nil)
     let objects = nib.instantiate(withOwner: self, options: nil)
     view = objects[0] as! UIView
     
     // Perform custom UI setup here
     self.nextKeyboardButton = UIButton(type: .system)
     
     self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
     self.nextKeyboardButton.sizeToFit()
     self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
     
     self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
     
     self.view.addSubview(self.nextKeyboardButton)
     
     self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
     self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
     
     let buttonTitles = ["Q", "W", "E", "R", "T", "Y"]
     let buttons = createButtons(titles: buttonTitles)
     let topRow = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
     
     for button in buttons {
     topRow.addSubview(button)
     }
     
     self.view.addSubview(topRow)
     
     addConstraints(buttons: buttons, containingView: topRow)
     }
     
     func createButtons(titles: [String]) -> [UIButton] {
     
     var buttons = [UIButton]()
     
     for title in titles {
     let button = UIButton(type: .system) as UIButton
     button.setTitle(title, for: .normal)
     button.translatesAutoresizingMaskIntoConstraints = false
     button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
     button.setTitleColor(UIColor.darkGray, for: .normal)
     button.addTarget(self, action: Selector(("keyPressed:")), for: .touchUpInside)
     buttons.append(button)
     }
     
     return buttons
     }
     
     func keyPressed(sender: AnyObject?) {
     let button = sender as! UIButton
     let title = button.title(for: .normal)
     (textDocumentProxy as UIKeyInput).insertText(title!)
     }
     
     func addConstraints(buttons: [UIButton], containingView: UIView){
     
     for (index, button) in buttons.enumerated() {
     
     let topConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: containingView, attribute: .top, multiplier: 1.0, constant: 1)
     
     let bottomConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: containingView, attribute: .bottom, multiplier: 1.0, constant: -1)
     
     var leftConstraint : NSLayoutConstraint!
     
     if index == 0 {
     
     leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: containingView, attribute: .left, multiplier: 1.0, constant: 1)
     
     }else{
     
     leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: buttons[index-1], attribute: .right, multiplier: 1.0, constant: 1)
     
     let widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1.0, constant: 0)
     
     containingView.addConstraint(widthConstraint)
     }
     
     var rightConstraint : NSLayoutConstraint!
     
     if index == buttons.count - 1 {
     
     rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: containingView, attribute: .right, multiplier: 1.0, constant: -1)
     
     }else{
     
     rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: buttons[index+1], attribute: .left, multiplier: 1.0, constant: -1)
     }
     
     containingView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
     }
     }
     override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated
     }
     
     override func textWillChange(_ textInput: UITextInput?) {
     // The app is about to change the document's contents. Perform any preparation here.
     }
     
     override func textDidChange(_ textInput: UITextInput?) {
     // The app has just changed the document's contents, the document context has been updated.
     
     var textColor: UIColor
     let proxy = self.textDocumentProxy
     if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
     textColor = UIColor.white
     } else {
     textColor = UIColor.black
     }
     self.nextKeyboardButton.setTitleColor(textColor, for: [])
     }
     */
}
