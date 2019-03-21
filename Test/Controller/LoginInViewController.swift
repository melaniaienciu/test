//
//  ViewController.swift
//  Test
//
//  Created by Melania Ienciu on 18/03/2019.
//  Copyright © 2019 Melania Ienciu. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
       
    }
    
    // MARK: - Hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    // MARK: - User Interaction
    @IBAction func logIn(_ sender: Any) {
        //textField -> string
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }
        if (username.count > 4) && (password.count > 4) {
            let myPost = Post(username: username, password: password)
            ApiServices.shared.request(post: myPost) { (responseData, error) in
                if responseData != nil {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "ProductsListIdentifier", sender: nil)
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    }
                } else if let error = error {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        UserDefaults.standard.set(false, forKey: "isLoggedIn")
                    }
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Invalid username or password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

