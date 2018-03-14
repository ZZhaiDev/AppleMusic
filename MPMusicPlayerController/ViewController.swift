//
//  ViewController.swift
//  ZJMusicPlayerController
//
//  Created by Cognitive AI Technologies on 3/7/18.
//  Copyright © 2018 zijia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func buttonClicked(_ sender: Any) {
        self.present(ZJMusicPlayerController(), animated: true, completion: nil)
    }
    @IBAction func button2clicked(_ sender: Any) {
        let popVc = ZJViewControllerWhileNavigation()
        popVc.modalPresentationStyle = .custom
        let popoverAnimatorWhileNavigation : PopoverAnimatorWhileNavigation = PopoverAnimatorWhileNavigation {[weak self] (presented) -> () in
        }
        popVc.transitioningDelegate = popoverAnimatorWhileNavigation
        self.present(popVc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

