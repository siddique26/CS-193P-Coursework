//
//  ConcentrationThemeChooserViewController.swift
//  concentration
//
//  Created by Siddique on 18/12/17.
//  Copyright © 2017 Siddique. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController ,UISplitViewControllerDelegate {
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
        "Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
 
    @IBAction func changeTheme(_ sender: Any) {if let cvc = splitViewDetailConcentrationViewController {
        if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
            cvc.theme = theme
        }
    } else if let cvc = lastSeguedToConcentrationViewController {
        if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
            cvc.theme = theme
        }
        navigationController?.pushViewController(cvc, animated: true)
    } else {
        performSegue(withIdentifier: "Choose Theme", sender: sender as! UIButton)
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController
        ) -> Bool
    {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            return cvc.theme == nil
        }
        return false
    }
  
    //MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "choose theme"{
                if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                    if let cvc = segue.destination as? ConcentrationViewController{
                        cvc.theme = theme
                    }
            }
        }
    }
    

}
