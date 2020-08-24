//
//  CustomTableViewCell.swift
//  ExpandableCellExample
//
//  Created by Luis Ángel Lucatero Villanueva on 22/08/20.
//  Copyright © 2020 Luis Lucatero. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackSubview: UIView!
    @IBOutlet public weak var bottomView: UIView! {
        didSet {
            bottomView.isHidden = true
        }
    }
    private var myView: UIView!
    var delegate: StackViewDelegate?
    private var order: Order?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myView = stackSubview.copyView()
        stackSubview?.isHidden = true
    }
    
    func setOrder(_ order: Order) {
        self.order = order
        setValues()
    }
    
    func setValues() {
        if let safeOrder = order {
            cellLabel.text = String(safeOrder.orderId)
            bottomView.isHidden = !safeOrder.isShown
            cleanStack()
            fillStack(with: safeOrder.products)
        }
    }
    
    func cleanStack() {
        for view in stackView.arrangedSubviews {
            if !view.isHidden {
                stackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
    }
    
    func fillStack(with products: [Product]) {
        for i in 0..<products.count {
            let productId = products[i].productId
            addProductToStack(productId: productId)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addToStackTapped(_ sender: UIButton) {
        if let productId = order?.products.last?.productId {
            let stackCount = stackView.arrangedSubviews.count
            addProductToStack(productId: productId + stackCount)
            delegate?.updated()
        }
    }
    
    func addProductToStack(productId: Int) {
        let newView = myView.copyView()
        let labelView = newView.subviews[0] as? UILabel
        labelView?.text = String(productId)
        let buttonview = newView.subviews[1] as? UIButton
        buttonview?.addTarget(self, action: #selector(deleteFromStackTapped(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(newView)
    }
    
    @objc func deleteFromStackTapped(_ sender: UIButton) {
        let view = stackView.arrangedSubviews[0]
        self.stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
        delegate?.updated()
    }
    
}

//MARK: - UIView Extensions

extension UIView
{
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
}
