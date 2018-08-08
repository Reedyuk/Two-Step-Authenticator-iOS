//
//  KeyboardViewController.swift
//  TSAKeyboard
//
//  Created by Andrew Reed on 08/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    var keyboardView: UIView!
    
    @IBOutlet weak var switchKeyboardButton: UIButton!
    @IBOutlet weak var authButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
    }
    

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
    @objc func authButtonPressed() {
        print("here")
    }
    @IBAction func keyboardButtonPressed(_ sender: Any) {
        let button = sender as! UIButton
        let title = button.title(for: .normal)
        (textDocumentProxy as UIKeyInput).insertText(title!)
    }

    func loadInterface(){
        let keyboardNib = UINib(nibName: "Keyboard", bundle: nil)
        keyboardView = keyboardNib.instantiate(withOwner: self, options: nil)        [0] as! UIView
        keyboardView.frame.size = view.frame.size
        view.addSubview(keyboardView)
        switchKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        authButton.addTarget(self,
                             action: #selector(authButtonPressed),
                             for: .allTouchEvents)
    }
}
