//
//  Order.swift
//  ExpandableCellExample
//
//  Created by Luis Ángel Lucatero Villanueva on 23/08/20.
//  Copyright © 2020 Luis Lucatero. All rights reserved.
//

import Foundation


struct Order {
    let orderId: Int
    let products: [Product]
    var isShown: Bool = false
}

struct Product {
    let productId: Int
}
