//
//  ViewController.swift
//  List Popup
//
//  Created by Kuldeep Tanwar on 06/07/19.
//  Copyright © 2019 Kuldeep Tanwar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageViewAnimation: UIImageView!
    var animationImages : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAnimation()
    }
    
    @IBAction func presentView(_ sender: UIButton) {
        var list = getList1()
        let tag = sender.superview?.tag
        switch sender.superview?.tag {
            case 2:
                list = getList2()
                break
            case 3:
                list = getList3()
                break
            case 4:
                list = getList4()
                break
            default : break
        }
        if tag == 3 || tag == 4 {
            // For custom height
            let vc = KTListPopup.getPopupController()
            vc.width = self.view.frame.width * 0.7
            vc.dataSource = list
            vc.callback = { item in
                print(item.title ?? "")
            }
            showPopupON(sender,vc)
        } else {
            showPopupOn(sender, list: list) { (item) in
                print(item.title ?? "")
            }
        }
    }
    func getList1() -> [KTItem] {
        let item1 = KTItem(id:nil, title:"Item 1", image:nil)
        let item2 = KTItem(id:nil, title:"Item 2", image:nil)
        let item3 = KTItem(id:nil, title:"Item 3", image:nil)
        return [item1,item2,item3]
    }
    func getList2() -> [KTItem] {
        let item1 = KTItem(id:nil, title:"Item 1", image:#imageLiteral(resourceName: "icon_light"))
        let item2 = KTItem(id:nil, title:"Item 2", image:#imageLiteral(resourceName: "icon_light"))
        let item3 = KTItem(id:nil, title:"Item 3", image:#imageLiteral(resourceName: "icon_light"))
        return [item1,item2,item3]
    }
    func getList3() -> [KTItem] {
        let item1 = KTItem(id:nil, title:"I don't think this will fit in one line, what do you think ?", image:nil)
        return [item1,item1,item1,item1,item1,item1,item1,item1,item1,item1,item1,item1]
    }
    func getList4() -> [KTItem] {
        let item1 = KTItem(id:nil, title:"I don't think this will fit in one line, Plus this item have icon too 😁", image:#imageLiteral(resourceName: "icon_light"))
        return [item1,item1,item1,item1,item1,item1,item1,item1,item1,item1,item1,item1]
    }
}

extension ViewController : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

