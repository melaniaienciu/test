//
//  productsListViewController.swift
//  Test
//
//  Created by Melania Ienciu on 18/03/2019.
//  Copyright © 2019 Melania Ienciu. All rights reserved.
//

import UIKit

class ProductsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataDelegate {
    
    @IBOutlet var tableView: UITableView!
   
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiServices.shared.getList() { (products, error) in
            if let error = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Get List - Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } else if let products = products {
                DispatchQueue.main.async {
                    self.prepareData(products: products)
                }
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "Products"
        let button = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(ProductsListViewController.logOut))
        self.navigationItem.rightBarButtonItem = button
    }
    
    func prepareData(products: [Product]) {
        self.products = products
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func parseData(product: [Product]) {
        let product = product
        prepareData(products: product)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PListTableViewId", for: indexPath) as? ProductsListTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ProductsListTableViewCell.")
        }
        let product = self.products[indexPath.row]
        cell.name.text = product.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Mark: - push view controller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let productDetailsVC = UIStoryboard(name: "ProductDetails", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsIdentifier") as? ProductDetailsViewController {
            productDetailsVC.product = products[indexPath.row]
            if let navigator = navigationController {
                navigator.pushViewController(productDetailsVC, animated: true)
            }
            productDetailsVC.delegate = self
        }
    }
    
    //Mark: - User interacttion
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
