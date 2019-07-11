# KTListPopup


![Swift](https://img.shields.io/badge/Swift-v5.0-orange.svg) ![Xcode](https://img.shields.io/badge/XCode-10.2-blue.svg)

A Beautiful View Controller to present Menu Item in a list. It Shows a Popup with the list of items provided with dynamic content sizing and selection callback.

![KTListNewResize](https://user-images.githubusercontent.com/20557360/61028815-3d1b3480-a3d7-11e9-8293-ee6e6c18b97a.gif)

## How to use?
#### Step-1 - Copy the source folder into your project
#### Step-2 - Confirm to *"UIPopoverPresentationControllerDelegate"*
    // Confirm to UIPopoverPresentationControllerDelegate and implement this method in your view controller.
    extension ViewController : UIPopoverPresentationControllerDelegate {
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
    }
#### Step-3 - Create your DataSource
    let item1 = KTItem(id:"1", title:"Item 1", image:#imageLiteral(resourceName: "icon_light"))
    let item2 = KTItem(id:"2", title:"Item 2", image:#imageLiteral(resourceName: "icon_light"))
    let list = [item1,item2]
#### Step-3 - Call showPopupOn method from your view controller
    // Pass the view (sender) where you want to show the popup and your datasource (list)
    showPopupOn(sender, list: list) { (item) in
            print(item.title ?? "")
    }
### BONUS
##### You can also customize the width and other properties of the popup by creating a custom popup like this 

    let vc = KTListPopup.getPopupController()
    vc.width = self.view.frame.width * 0.7
    vc.dataSource = list
    vc.callback = { item in
        print(item.title ?? "")
    }
    showPopupON(sender,vc)
## MIT License

MIT License

Copyright (c) 2019 Kuldeep Tanwar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
