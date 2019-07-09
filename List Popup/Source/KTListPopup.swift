//
//  KTListPopup.swift
//  Zento
//
//  Created by Kuldeep Tanwar on 05/07/19.
//  Copyright © 2019 AJM Softwares. All rights reserved.
//

import UIKit
struct KTItem {
    var id : String?
    var title : String!
}
typealias KTCallback = (KTItem) -> Void
class KTListPopup: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var dataSource : [KTItem] = []
    var callback : KTCallback?
    var font = UIFont.systemFont(ofSize: 16.0)
    var offset : CGFloat = 10.0
    let cellIdentifier = "Cell"
    var width : CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
    }
    private func setupTableview() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "KTTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    func getSizeFromDataSource() -> CGSize {
        var height : CGFloat = 0.0
        let leftOffset : CGFloat = 20.0
        let rightOffset : CGFloat = 10.0
        let topOffset : CGFloat = 12.0
        for item in dataSource {
            let cellWidth = getWidth() - (leftOffset + rightOffset)
            height = height + item.title.height(withConstrainedWidth: cellWidth, font: font)
            height = height + (topOffset * 2)
        }
        return CGSize(width: getWidth(), height: height)
    }
    func getWidth() ->CGFloat {
        return width ?? self.view.frame.size.width / 2
    }
    class func getPopupController() -> KTListPopup {
        let vc = KTListPopup(nibName: "KTListPopup", bundle: nil)
        vc.modalPresentationStyle = .popover;
        return vc
    }
}
extension KTListPopup : UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            guard let callback = self.callback else { return }
            callback(self.dataSource[indexPath.row])
            self.callback = nil
        }
    }
}
extension KTListPopup : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? KTTableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier) as? KTTableViewCell
        }
        cell?.titleLabel.font = font
        cell?.titleLabel.text  = dataSource[indexPath.row].title
        return cell ?? UITableViewCell()
    }
}
extension UIViewController {
    func showPopupOn(_ popupView:UIView,list:[KTItem],selectionCallback:KTCallback?){
        let vc = KTListPopup.getPopupController()
        vc.dataSource = list
        vc.callback = selectionCallback
        if let style = vc.popoverPresentationController {
            style.sourceView = popupView
            style.sourceRect = popupView.bounds
            vc.preferredContentSize = vc.getSizeFromDataSource()
            if let vc = self as? UIPopoverPresentationControllerDelegate {
                style.delegate = vc
            }
        }
        present(vc, animated: true, completion: nil)
    }
    func showPopupON(_ popupView:UIView,_ controller:KTListPopup){
        if let style = controller.popoverPresentationController {
            style.sourceView = popupView
            style.sourceRect = popupView.bounds
            controller.preferredContentSize = controller.getSizeFromDataSource()
            if let vc = self as? UIPopoverPresentationControllerDelegate {
                style.delegate = vc
            }
        }
        present(controller, animated: true, completion: nil)
    }
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}

