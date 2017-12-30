//
//  CasiniViewController.swift
//  cassini
//
//  Created by Siddique on 30/12/17.
//  Copyright © 2017 Siddique. All rights reserved.
//

import UIKit

class CasiniViewController: UIViewController {


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier{
            if let url = DemoURLs.NASA[identifier] {
                if let imageVC = segue.destination.contents as? ImageViewController{
                    imageVC.imageURL = url
                    imageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }
    

}

extension UIViewController{
    var contents: UIViewController{
        if let navcon = self as? UINavigationController{
            return navcon.visibleViewController ?? navcon
        }else{
            return self
        }
    }
}
