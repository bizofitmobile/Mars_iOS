//
//  NewSampleRequestViewController.swift
//  Mars
//
//  Created by Arpit Lokwani on 23/09/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit

class NewSampleRequestViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var toTextField: UITextField!
    
    @IBOutlet weak var supplierNamelabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var ccTextField: UITextField!
    
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var submitBtnPressed: UIButton!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var selectedProductID = ""
    var selectedVendorID = ""
    var selectedFlavourID = ""
    var isComingFrom = ""
    var flavour = ""
    var categoryID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(categoryID)
        let string = "Hi,\nPlease send a __ gms sample of \(flavour) to :-"
        messageTextView.text = string
        submitBtnPressed.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
        submitBtnPressed.layer.cornerRadius = 15
       
        
        toTextField.layer.cornerRadius = toTextField.frame.size.height/2
        toTextField.clipsToBounds = true
        ccTextField.layer.cornerRadius = ccTextField.frame.size.height/2
        ccTextField.clipsToBounds = true
        nameLabel.layer.cornerRadius = 25
        nameLabel.layer.masksToBounds = true
        
        getProfile()
        
        
        // Do any additional setup after loading the view.
    }

    
    func  getProfile() -> Void {
        if let user_id = UserDefaults.standard.string(forKey: "user_id") {
            
            let postString = "user_id=\(user_id)"
            
            var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getProfile")!)
            request.httpMethod = "POST"
            
            request.httpBody = postString.data(using: .utf8)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
            print(request)
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                //print(response!)
                guard error == nil else {
                    print(error as Any)
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                    let jsonDict:NSDictionary = json as NSDictionary
                    print(jsonDict.value(forKey: "data") as Any)
                    let dataDict:NSDictionary = jsonDict.value(forKey: "data") as! NSDictionary
                    print(dataDict.value(forKey: "fname") as! String)
                    print(dataDict.value(forKey: "lname") as! String)
                    print(dataDict.value(forKey: "picture_url") as! String)
                    print(dataDict.value(forKey: "email") as! String)
                    UserDefaults.standard.set(dataDict.value(forKey: "fname") as! String, forKey: "fname")
                    UserDefaults.standard.set(dataDict.value(forKey: "lname") as! String, forKey: "lname")
                    UserDefaults.standard.set(dataDict.value(forKey: "picture_url") as! String, forKey: "picture_url")
                    UserDefaults.standard.set(dataDict.value(forKey: "email") as! String, forKey: "email")
                    UserDefaults.standard.set(dataDict.value(forKey: "address") as! String, forKey: "address")
                    UserDefaults.standard.set(dataDict.value(forKey: "contact_number") as! String, forKey: "contactNumber")
                    
                    
                    DispatchQueue.main.async {
                        self.addressLabel.text = dataDict.value(forKey: "address") as! String
                        self.phoneLabel.text = dataDict.value(forKey: "contact_number") as! String
                        
                       // self.supplierNamelabel.text = dataDict.value(forKey: "contact_number") as! String
                        
                        self.firstNameLabel.text = (dataDict.value(forKey: "fname") as! String) + " " + (dataDict.value(forKey: "lname") as! String)
                        
                        self.toTextField.text = "user@mars.com"
                        self.ccTextField.text = "user2@mars.com"
                        
                        
                    }
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateName"), object: nil)
                    
                    
                    
                } catch {
                    DispatchQueue.main.async {
                        // loadingIndicator.stopAnimating();
                        
                    }
                    print("error")
                }
            })
            
            task.resume()
            
            
        }
        
        // http://mars.bizofit.com/api/v1/user/getFlavoursList
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let subContentsVC = storyboard.instantiateViewController(withIdentifier: "NewRequestForSampleViewController") as! NewRequestForSampleViewController
        self.navigationController?.pushViewController(subContentsVC, animated: true)
        
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
