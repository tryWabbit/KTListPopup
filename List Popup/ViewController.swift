//
//  ViewController.swift
//  List Popup
//
//  Created by Kuldeep Tanwar on 06/07/19.
//  Copyright © 2019 Kuldeep Tanwar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func presentView(_ sender: UIView) {
        showPopupOn(sender, list: getItems()) { (item) in
            print(item.title ?? "")
        }
    }
    func getItems() -> [KTItem] {
        let item1 = KTItem(id: "", title: "This item will is also too big but it will fit, maybe?")
        let item2 = KTItem(id: "", title: "Item 2 will fit")
        let item3 = KTItem(id: "", title: "This item is too big to fit in so you have to update the popup size so it can easily fit the screen")
        return [item1,item2,item3]
    }
}

extension ViewController : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
