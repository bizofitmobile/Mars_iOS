//
//  JavaViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit
import EasyTipView
class JavaViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    @IBOutlet weak var ccTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var textView: UITextView!
    var selectedProductID = ""
    var selectedVendorID = ""
    var selectedFlavourID = ""
    var selectedCommodityID = ""
    var isComingFromVendor = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func backBtnPressed(_ sender: Any) {
        //slideMenuController()?.toggleLeft()
        navigationController?.popViewController(animated: false)


    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func sendNutsVendorRequest() {
//
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        
        let stringVal:String = textView.text!
        var gmValue = 0
        if let number = Int(stringVal.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            gmValue = number
            print(number)
            // Do something with this number
        }
        
        print(gmValue)
        // present(alert, animated: true, completion: nil)
        if let user_id = UserDefaults.standard.string(forKey: "user_id") {
            
            let dict = [ "gram": "\(gmValue)","nut_id": "\(selectedFlavourID)","commodity_id": "\(selectedCommodityID)","vendor_id": "\(selectedVendorID)","user_id": "\(user_id)","name": "\(nameTxtField.text!)","address": "\( addressTxtField.text!)","contact_number": "\(contactNumberTxtField.text!)","message":"\(textView.text!)"]
            
            
            var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/sampleRequestNuts")!)
            request.httpMethod = "POST"
            let jsonData = (try? JSONSerialization.data(withJSONObject: dict, options: []))
            request.httpBody = jsonData
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
            print(request)
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                //   print(response!)
                guard error == nil else {
                    DispatchQueue.main.async {
                        loadingIndicator.stopAnimating();
                    }
                    print(error as Any)
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                    let jsonDict:NSDictionary = json as NSDictionary
                    print(jsonDict.value(forKey: "message") as Any)
                    
                    DispatchQueue.main.async {
                        loadingIndicator.stopAnimating();
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let subContentsVC = storyboard.instantiateViewController(withIdentifier: "RequestSampleViewController") as! RequestSampleViewController
                        self.navigationController?.pushViewController(subContentsVC, animated: true)
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
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        HanselWrapper.logEvent(eventName: "email_page_opened", properties: [:])

    }
    
    
    func sendFlavorVendorRequest() {
        //
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        
        let stringVal:String = textView.text!
        var gmValue = 0
        if let number = Int(stringVal.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            gmValue = number
            print(number)
            // Do something with this number
        }
        
        print(gmValue)
        // present(alert, animated: true, completion: nil)
        if let user_id = UserDefaults.standard.string(forKey: "user_id") {
            
             let dict = [ "gram": "\(gmValue)","flavour_id": "\(selectedFlavourID)","product_id": "\(selectedProductID)","vendor_id": "\(selectedVendorID)","user_id": "\(user_id)","name": "\(nameTxtField.text!)","address": "\( addressTxtField.text!)","contact_number": "\(contactNumberTxtField.text!)","message":"\(textView.text!)"]
            
            
            var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/sampleRequest")!)
            request.httpMethod = "POST"
            let jsonData = (try? JSONSerialization.data(withJSONObject: dict, options: []))
            request.httpBody = jsonData
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
            print(request)
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                //   print(response!)
                guard error == nil else {
                    DispatchQueue.main.async {
                        loadingIndicator.stopAnimating();
                    }
                    print(error as Any)
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                    let jsonDict:NSDictionary = json as NSDictionary
                    print(jsonDict.value(forKey: "message") as Any)
                    
                    DispatchQueue.main.async {
                        loadingIndicator.stopAnimating();
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let subContentsVC = storyboard.instantiateViewController(withIdentifier: "RequestSampleViewController") as! RequestSampleViewController
                        self.navigationController?.pushViewController(subContentsVC, animated: true)
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
        
        
    }
    
    
    @IBAction func submitBtnAction(_ sender: Any) {
        
        if isComingFromVendor == "NutsVendor" {
            sendNutsVendorRequest()
        }else{
            sendFlavorVendorRequest()
        }
        
        
        
        
    }
    
    @IBOutlet weak var submitBtnPressed: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var contactNumberTxtField: UITextField!
    @IBOutlet weak var addressTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    var isComingFrom = ""
    
    
    
    @IBAction func editBtnPressed(_ sender: Any) {
        let button:UIButton = sender as! UIButton
        if (button.isSelected){
            nameTxtField.isEnabled = false
            addressTxtField.isEnabled = false
            contactNumberTxtField.isEnabled = false
            nameTxtFieldlinebottomLine.isHidden = true
            addressTxtFieldlinebottomLine.isHidden = true
            contactNumberTxtFieldbottomLine.isHidden = true
            button.isSelected = !button.isSelected
        }else{
            nameTxtField.becomeFirstResponder()
            nameTxtFieldlinebottomLine.isHidden = false
            addressTxtFieldlinebottomLine.isHidden = false
            contactNumberTxtFieldbottomLine.isHidden = false
            nameTxtField.isEnabled = true
            addressTxtField.isEnabled = true
            contactNumberTxtField.isEnabled = true
            
            button.isSelected = !button.isSelected
            
           

        }
            
    }
    
    func  getProfile() -> Void {
        //let params = ["username":"demo@test.com","passwd":"123456"] as Dictionary<String, Any>
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
                    DispatchQueue.main.async {
                        self.nameTxtField.text = dataDict.value(forKey: "fname") as! String
                        self.addressTxtField.text = dataDict.value(forKey: "address") as! String
                        self.contactNumberTxtField.text = dataDict.value(forKey: "contact_number") as! String
                    }
                    
                    UserDefaults.standard.set(dataDict.value(forKey: "fname") as! String, forKey: "fname")
                    UserDefaults.standard.set(dataDict.value(forKey: "lname") as! String, forKey: "lname")
                    UserDefaults.standard.set(dataDict.value(forKey: "picture_url") as! String, forKey: "picture_url")
                    UserDefaults.standard.set(dataDict.value(forKey: "email") as! String, forKey: "email")
                    
                    
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateName"), object: nil)
                    
//                    DispatchQueue.main.async {
//                        HanselWrapper.logEvent(eventName: "email_page_opened", properties: [:])
//
//                    }
                    
                } catch {
                    print("error")
                }
            })
            
            task.resume()
            
        }
        
//        let postString = "user_id=1"
        
        // http://mars.bizofit.com/api/v1/user/getFlavoursList
        
       
        
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
    @IBOutlet weak var flavorTxtField: UITextField!
    @IBOutlet weak var gmTextField: UITextField!
    var nameTxtFieldlinebottomLine = CALayer()
    var addressTxtFieldlinebottomLine = CALayer()
    var contactNumberTxtFieldbottomLine = CALayer()
    var flavour = ""
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate  = self
        ccTextField.isUserInteractionEnabled = false
        toTextField.isUserInteractionEnabled = false
      contactNumberTxtField.delegate = self
      addressTxtField.delegate = self
        nameTxtField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        getProfile()
        let string = "Hi,\nPlease send a __ gms sample of \(flavour) to :-"
        textView.text = string
        
        self.navigationItem.setHidesBackButton(true, animated:true);

        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: "Futura-Medium", size: 13)!
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
        
       
        
        if let isLaunched = UserDefaults.standard.string(forKey: "isJavaPageLaunched") {
            if (isLaunched == "YES"){
                // do nothing
            }else{
                UserDefaults.standard.set("YES", forKey: "isJavaPageLaunched")
            }
        }else{
            
            UserDefaults.standard.set("YES", forKey: "isJavaPageLaunched")
          //  EasyTipView.show(forView: textView,
//                             withinSuperview: self.navigationController?.view,
//                             text: " Edit the message and shipping address and add quantity on this screen. Click submit when the message is ready. ",
//                             preferences: preferences,
//                             delegate: nil)
        }
        
        nameTxtField.isEnabled = false
        addressTxtField.isEnabled = false
        contactNumberTxtField.isEnabled = false
        nameTxtFieldlinebottomLine.isHidden = true
        addressTxtFieldlinebottomLine.isHidden = true
        contactNumberTxtFieldbottomLine.isHidden = true
//        var gmTextFieldbottomLine = CALayer()
//        gmTextFieldbottomLine.frame = CGRect(x:0.0,y: gmTextField.frame.height - 1,width: gmTextField.frame.width, height:1.0)
//        gmTextFieldbottomLine.backgroundColor = UIColor.darkGray.cgColor
//        gmTextField.borderStyle = UITextBorderStyle.none
//        gmTextField.layer.addSublayer(gmTextFieldbottomLine)
//        
//        var linebottomLine = CALayer()
//        linebottomLine.frame = CGRect(x:0.0,y: flavorTxtField.frame.height - 1,width: flavorTxtField.frame.width, height:1.0)
//        linebottomLine.backgroundColor = UIColor.darkGray.cgColor
//        flavorTxtField.borderStyle = UITextBorderStyle.none
//        flavorTxtField.layer.addSublayer(linebottomLine)
        
       
        nameTxtFieldlinebottomLine.frame = CGRect(x:0.0,y: nameTxtField.frame.height - 1,width: nameTxtField.frame.width, height:1.0)
        nameTxtFieldlinebottomLine.backgroundColor = UIColor.darkGray.cgColor
        nameTxtField.borderStyle = UITextBorderStyle.none
        nameTxtField.layer.addSublayer(nameTxtFieldlinebottomLine)
        
        
        
        
        addressTxtFieldlinebottomLine.frame = CGRect(x:0.0,y: addressTxtField.frame.height - 1,width: addressTxtField.frame.width, height:1.0)
        addressTxtFieldlinebottomLine.backgroundColor = UIColor.darkGray.cgColor
        addressTxtField.borderStyle = UITextBorderStyle.none
        addressTxtField.layer.addSublayer(addressTxtFieldlinebottomLine)
        
        
       
        contactNumberTxtFieldbottomLine.frame = CGRect(x:0.0,y: contactNumberTxtField.frame.height - 1,width: contactNumberTxtField.frame.width, height:1.0)
        contactNumberTxtFieldbottomLine.backgroundColor = UIColor.darkGray.cgColor
        contactNumberTxtField.borderStyle = UITextBorderStyle.none
        contactNumberTxtField.layer.addSublayer(contactNumberTxtFieldbottomLine)
//
//        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 0.5)
//        navigationController?.navigationBar.backgroundColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 1.0)
    }
 
    override func viewWillAppear(_ animated: Bool) {
        submitBtn.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
        submitBtn.layer.cornerRadius = 15
        if isComingFrom == "Search" {
            self.navigationController?.navigationBar.isHidden = true
            backBtn.isHidden = false
            titleLabel.isHidden = false
        }else{
            self.navigationController?.navigationBar.isHidden = false
            backBtn.isHidden = true
            titleLabel.isHidden = true

        }
        
        super.viewWillAppear(animated)
        
        self.setNavigationBarItem()
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 1.0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.popViewController(animated: false)
        

    }
    override func viewDidDisappear(_ animated: Bool) {

    }
    
    
}
extension Int {
    static func parse(from string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}
