//
//  NonMenuController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit



class NonMenuController: UIViewController {
    
    weak var delegate: LeftMenuProtocol?
    @IBOutlet weak var doneBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  self.setNavigationBarItem()
        doneBtn.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
        doneBtn.layer.cornerRadius = 30
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 0.5)
        navigationController?.navigationBar.backgroundColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 1.0)
        self.setNavigationBarItem()
      //  self.removeNavigationBarItem()
    }
  
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            guard let vc = (self.slideMenuController()?.mainViewController as? UINavigationController)?.topViewController else {
                return
            }
            if vc.isKind(of: NonMenuController.self)  {
                self.slideMenuController()?.removeLeftGestures()
                self.slideMenuController()?.removeRightGestures()
            }
        })
    }
  
    @IBAction func didTouchToMain(_ sender: UIButton) {
        delegate?.changeViewController(LeftMenu.Home)
    }
}
