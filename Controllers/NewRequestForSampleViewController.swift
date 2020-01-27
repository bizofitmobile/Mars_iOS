//
//  NewRequestForSampleViewController.swift
//  Mars
//
//  Created by Arpit Lokwani on 23/09/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit

class NewRequestForSampleViewController: UIViewController {
    @IBOutlet weak var toTextField: UITextField!
    
    @IBAction func backbtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    @IBAction func goToHomePressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func submitBtnPRessed(_ sender: Any) {
        
    }
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var ccTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toTextField.text = "user@mars.com"
        self.ccTextField.text = "user2@mars.com"
        submitBtn.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
        submitBtn.layer.cornerRadius = 15
        
        
        toTextField.layer.cornerRadius = toTextField.frame.size.height/2
        toTextField.clipsToBounds = true
        ccTextField.layer.cornerRadius = ccTextField.frame.size.height/2
        ccTextField.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
