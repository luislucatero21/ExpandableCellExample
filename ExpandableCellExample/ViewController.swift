//
//  ViewController.swift
//  ExpandableCellExample
//
//  Created by Luis Ángel Lucatero Villanueva on 22/08/20.
//  Copyright © 2020 Luis Lucatero. All rights reserved.
//

import UIKit

protocol StackViewDelegate {
    func updated()
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StackViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var orders: [Order] = [
        Order(orderId: 0, products: [Product(productId: 0), Product(productId: 1), Product(productId: 2)]),
        Order(orderId: 1, products: [Product(productId: 10), Product(productId: 11), Product(productId: 12)]),
        Order(orderId: 2, products: [Product(productId: 20)]),
        Order(orderId: 3, products: [Product(productId: 30), Product(productId: 31)]),
        Order(orderId: 4, products: [Product(productId: 40)]),
        Order(orderId: 5, products: [Product(productId: 50)]),
        Order(orderId: 6, products: [Product(productId: 60)]),
        Order(orderId: 7, products: [Product(productId: 70)]),
        Order(orderId: 8, products: [Product(productId: 80)]),
        Order(orderId: 9, products: [Product(productId: 90)]),
        Order(orderId: 10, products: [Product(productId: 100)]),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTable()
    }
    
    func configureTable() {
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 128
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        let order = orders[indexPath.row]
        
        cell.cellLabel.text = String(order.orderId)
        cell.delegate = self
        cell.showButton.tag = order.orderId
        cell.setOrder(order)
        cell.showButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func buttonTapped(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell {
            
            UIView.animate(withDuration: 0.3) {
                cell.bottomView.isHidden = !cell.bottomView.isHidden
            }
            print(orders[indexPath.row])
            orders[indexPath.row].isShown = !orders[indexPath.row].isShown
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func updated() {
        print("Updated!")
        tableView.beginUpdates()
        tableView.endUpdates()
    }

}

