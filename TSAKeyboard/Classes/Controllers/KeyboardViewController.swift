//
//  KeyboardViewController.swift
//  TSAKeyboard
//
//  Created by Andrew Reed on 08/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    @IBOutlet weak var switchKeyboardButton: UIButton!
    @IBOutlet weak var authButton: UIButton!
    private weak var _heightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
    }

    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        guard nil == _heightConstraint else { return }
        let emptyView = UILabel(frame: .zero)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyView);
        let heightConstraint = NSLayoutConstraint(item: view,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 0.0,
                                                  constant: 200)
        heightConstraint.priority = .required - 1
        view.addConstraint(heightConstraint)
        _heightConstraint = heightConstraint
    }

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }

    @objc func authButtonPressed() {
        let tokenListViewController = TokenListViewController(textDocumentProxy: textDocumentProxy)
        present(tokenListViewController, animated: true, completion: nil)
    }
    @IBAction func keyboardButtonPressed(_ sender: Any) {
        let button = sender as! UIButton
        let title = button.title(for: .normal)
        (textDocumentProxy as UIKeyInput).insertText(title!)
    }

    func loadInterface(){
        let keyboardNodeViewController = KeyboardNodeViewController(textDocumentProxy: textDocumentProxy,
                                                                    parentInputViewController: self)
        present(keyboardNodeViewController, animated: true, completion: nil)
//        let keyboardNib = UINib(nibName: "Keyboard", bundle: nil)
//        keyboardView = keyboardNib.instantiate(withOwner: self, options: nil)        [0] as! UIView
//        keyboardView.frame.size = view.frame.size
//        view.addSubview(keyboardView)
//        switchKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
//        authButton.addTarget(self,
//                             action: #selector(authButtonPressed),
//                             for: .touchUpInside)
    }
}
