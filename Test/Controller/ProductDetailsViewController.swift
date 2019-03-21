//
//  productDetailsViewController.swift
//  Test
//
//  Created by Melania Ienciu on 18/03/2019.
//  Copyright © 2019 Melania Ienciu. All rights reserved.
//

import UIKit

protocol DataDelegate {
    func parseData(product: [Product])
}

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dateAddedLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var product: Product?
    var delegate: DataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = product?.name
        let button = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(ProductDetailsViewController.logOut))
        self.navigationItem.rightBarButtonItem = button
        categoryLabel.text = "Category: \(String(describing: product!.category))"
        descriptionTextView.text = product?.description
        descriptionTextView.isEditable = false
        dateAddedLabel.text = "Date Added: \(String(describing: product!.dateAdded))"
    }
    
    @objc func logOut() {
        DispatchQueue.main.async {
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            UserDefaults.standard.synchronize()
            let rootViewController: UIViewController = UIStoryboard(name: "LogIn", bundle: nil).instantiateViewController(withIdentifier: "LogInIdentifier") as UIViewController
            let navigationController = UINavigationController(rootViewController: rootViewController)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}
