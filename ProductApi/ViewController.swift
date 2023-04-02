//
//  ViewController.swift
//  ProductApi
//
//  Created by Mac on 08/03/23.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    @IBOutlet weak var productsTableView: UITableView!
    var products = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParsing()
        tableViewandregisterXIB()
    }
    func tableViewandregisterXIB(){
        productsTableView.delegate = self
        productsTableView.dataSource = self
        let uinib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.productsTableView.register(uinib, forCellReuseIdentifier: "ProductTableViewCell")
    }
    func jsonParsing(){
        var urlstring = "https://fakestoreapi.com/products"
        var url = URL(string: urlstring)
        var urlRequest = URLRequest(url: url!)
        URLSession.shared.dataTask(with: urlRequest){data,response,error in
            print(String(data: data!, encoding: .utf8)!)
            let jsonDecoder = JSONDecoder()
            let productResponse = try! jsonDecoder.decode([Product].self, from: data!)
            self.products = productResponse
            DispatchQueue.main.async {
                self.productsTableView.reloadData()
            }
        }.resume()
    }

}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.productsTableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        cell.idLabel.text = "\(products[indexPath.row].id)"
        cell.titleLabel.text = products[indexPath.row].title
        cell.img.sd_setImage(with: products[indexPath.row].image)
       // cell.layer.borderWidth = 5
        return cell
    }
    
}
