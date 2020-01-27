//
//  GoViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

class GoViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var profileImageView: UIImageView!
    weak var delegate: LeftMenuProtocol?

    @IBAction func editBtnPRessed(_ sender: Any) {
        nameValueLabel.isEnabled = true
        addressLabelValue.isEnabled = true
        contactNumberLabel.isEnabled = true
        nameValueLabel.isEnabled = true
        emailValueLabel.isEnabled = true
        submitBtn.isEnabled = true

        
    }
    @IBOutlet weak var companyValueLabel: UILabel!
    @IBOutlet weak var nameValueLabel: UITextField!
    @IBOutlet weak var addressLabelValue: UITextField!
    @IBOutlet weak var contactNumberLabel: UITextField!
    @IBOutlet weak var emailValueLabel: UITextField!
    @IBOutlet weak var profileBGView: UIView!
    @IBOutlet weak var addressSuperView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        delegate?.changeViewController(LeftMenu.Home)

        navigationController?.popViewController(animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       addressLabelValue.delegate = self
        contactNumberLabel.delegate = self
     emailValueLabel.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        nameValueLabel.isEnabled = false
        addressLabelValue.isEnabled = false
        contactNumberLabel.isEnabled = false
        nameValueLabel.isEnabled = false
        emailValueLabel.isEnabled = false
        submitBtn.isEnabled = false

      //  profileBGView.backgroundColor = UIColor(patternImage: UIImage(named: "rectangle_3")!)
        submitBtn.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
        submitBtn.layer.cornerRadius = 15
        addressSuperView.layer.cornerRadius = 20
        profileImageView.backgroundColor = UIColor.black
        profileImageView.layer.cornerRadius = 50
        profileImageView.center = headerView.center
        profileImageView.layer.masksToBounds = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 0.5)
        navigationController?.navigationBar.backgroundColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 1.0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        getProfile()
    }
    
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        let name = nameValueLabel.text
        var fullNameArr = name?.characters.split{$0 == " "}.map(String.init)
        
        let firstName: String = fullNameArr![0]
        let lastName: String? = fullNameArr![1]
        
        var userID = ""
        if let user_id = UserDefaults.standard.string(forKey: "user_id") {
        userID = user_id
        }
        
        let parameters:[String:Any] = ["user_id":"\(userID)",
            "fname": "\(firstName)",
            "email":"\(emailValueLabel.text!)",
            "lname":"\(lastName!)",
            "contact_number":"\(contactNumberLabel.text!)",
            "address":"\(addressLabelValue.text!)"
            
        ]
      
        var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/editProfile")!)
        request.httpMethod = "POST"
        let jsonData: Data? = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        request.httpBody = jsonData
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if (error != nil){
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating();
                    
                }
            }
            
            //  print(response!)
            do {
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating();
                    
                }
                
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
                let jsonDict:NSDictionary = json as NSDictionary
                print(jsonDict.value(forKey: "data") as Any)
                
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Alert", message: "Profile updated Successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("YES")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                    self.present(alert, animated: true, completion: nil)
                   // self.tableView.reloadData()
                    
                }
                
                
                
            } catch {
                DispatchQueue.main.async {
                loadingIndicator.stopAnimating();
                    
                }
                print("error")
            }
        })
        
        task.resume()
        
        
    }
    @IBOutlet weak var submitBtn: UIButton!
    
    func  getProfile() -> Void {
       // let params = ["username":"demo@test.com","passwd":"123456"] as Dictionary<String, Any>
        if let user_id = UserDefaults.standard.string(forKey: "user_id") {
            
            let postString = "user_id=\(user_id)"
            
            // http://mars.bizofit.com/api/v1/user/getFlavoursList
            
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
                    DispatchQueue.main.async {
                        
                        self.nameValueLabel.text = (dataDict.value(forKey: "fname") as! String) + " " + (dataDict.value(forKey: "lname") as! String)
                        self.emailValueLabel.text = dataDict.value(forKey: "email") as? String
                        self.addressLabelValue.text = dataDict.value(forKey: "address") as? String
                        self.contactNumberLabel.text = dataDict.value(forKey: "contact_number") as? String
                    }
                    
                    UserDefaults.standard.set(dataDict.value(forKey: "fname") as! String, forKey: "fname")
                    UserDefaults.standard.set(dataDict.value(forKey: "lname") as! String, forKey: "lname")
                    UserDefaults.standard.set(dataDict.value(forKey: "picture_url") as! String, forKey: "picture_url")
                    UserDefaults.standard.set(dataDict.value(forKey: "email") as! String, forKey: "email")
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateName"), object: nil)
                    
                    
                    
                } catch {
                    print("error")
                }
            })
            
            task.resume()
            
        }
        }
        
       
    
}
