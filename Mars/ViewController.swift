//
//  ViewController.swift
//  Mars
//
//  Created by Arpit Lokwani on 19/08/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    var iconClick = true
    var isRemeberSelected = false
    let usernameTxtField = UITextField()
    var passHintValue = ""

    let passwordTxtField = UITextField()
    var checkButton = UIButton()
    var tableView = UITableView()
    
    var passwordDict = NSMutableDictionary()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    
    }
    
  override  func viewDidAppear(_ animated: Bool) {
    HanselWrapper.logEvent(eventName: "filter_page_opened", properties: [:])

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTxtField.text = "sandeepsidhwani26@gmail.com"
        passwordTxtField.text = "123456"
        // HanselWrapper.logEvent(eventName: "filter_page_opened", properties: [:])
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        navigationController?.navigationBar.isHidden = true
       // view.backgroundColor = UIColor.lightGray
        
        let loginSubView = UIView()
        loginSubView.frame = CGRect(x: 20, y: Int(view.frame.size.height/2-190), width: Int(view.frame.size.width-40), height: 270)
        loginSubView.backgroundColor = UIColor.white
        loginSubView.layer.cornerRadius = 10
        view.addSubview(loginSubView)
        loginSubView.layer.masksToBounds = false
        loginSubView.layer.shadowRadius = 3.0
        loginSubView.layer.shadowColor = UIColor.lightGray.cgColor
        loginSubView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        loginSubView.layer.shadowOpacity = 1.0
        
        
        let usernameLabel = UILabel()
        usernameLabel.frame = CGRect(x: 20, y:20, width: Int(loginSubView.frame.size.width-40), height: 30)
        usernameLabel.layer.cornerRadius = 2
        usernameLabel.text = "Username"
        loginSubView.addSubview(usernameLabel)
        usernameLabel.font = UIFont.init(name: "HelveticaNeue-Light", size: 14.0)

        usernameTxtField.delegate = self
        usernameTxtField.frame = CGRect(x: 20, y:60, width: Int(loginSubView.frame.size.width-40), height: 30)
        usernameTxtField.layer.cornerRadius = 2
        usernameTxtField.layer.borderColor = UIColor.lightGray.cgColor
        usernameTxtField.layer.borderWidth = 0.3
        loginSubView.addSubview(usernameTxtField)
        usernameTxtField.layer.masksToBounds = false
        usernameTxtField.layer.shadowRadius = 3.0
        usernameTxtField.layer.shadowColor = UIColor.lightGray.cgColor
        usernameTxtField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        usernameTxtField.layer.shadowOpacity = 1.0
        
        let userTxtFieldLeftView = UIView()
        userTxtFieldLeftView.frame = CGRect(x: 0, y: 0, width: 5, height: 30)
        userTxtFieldLeftView.backgroundColor = UIColor.orange.withAlphaComponent(0.6)
        userTxtFieldLeftView.layer.cornerRadius = 4
        
        usernameTxtField.addSubview(userTxtFieldLeftView)
        
        
        let userpaddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        usernameTxtField.leftView = userpaddingView
        usernameTxtField.leftViewMode = .always
        usernameTxtField.tag = 0
        
        let passwordLabel = UILabel()
        passwordLabel.frame = CGRect(x: 20, y:100, width: Int(loginSubView.frame.size.width-40), height: 30)
        passwordLabel.layer.cornerRadius = 2
        loginSubView.addSubview(passwordLabel)
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont.init(name: "HelveticaNeue-Light", size: 14.0)

        
       
        

        
        let passwordTxtFieldLeftView = UIView()
        passwordTxtFieldLeftView.frame = CGRect(x: 0, y: 0, width: 5, height: 30)
        passwordTxtFieldLeftView.backgroundColor = UIColor.orange.withAlphaComponent(0.6)
        passwordTxtFieldLeftView.layer.cornerRadius = 4

        passwordTxtField.addSubview(passwordTxtFieldLeftView)
        passwordTxtField.delegate = self
        passwordTxtField.frame = CGRect(x: 20, y:140, width: Int(loginSubView.frame.size.width-40), height: 30)
        passwordTxtField.layer.cornerRadius = 2
        passwordTxtField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTxtField.layer.borderWidth = 0.3
        passwordTxtField.isSecureTextEntry = true
        passwordTxtField.layer.masksToBounds = false
        passwordTxtField.layer.shadowRadius = 3.0
        passwordTxtField.layer.shadowColor = UIColor.lightGray.cgColor
        passwordTxtField.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        passwordTxtField.layer.shadowOpacity = 1.0
        passwordTxtField.tag = 1
        loginSubView.addSubview(passwordTxtField)
        
        tableView.frame = CGRect(x: 20, y: 170, width: Int(loginSubView.frame.size.width-40), height: 80)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.borderWidth = 0.5
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.backgroundColor = UIColor.white
        tableView.isHidden = true
        
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        passwordTxtField.leftView = paddingView
        passwordTxtField.leftViewMode = .always
        
        let paddingRightView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        passwordTxtField.rightView = paddingRightView
        passwordTxtField.rightViewMode = .always

        
        let passeyeButton = UIButton()
        passeyeButton.frame = CGRect(x: Int(loginSubView.frame.size.width-60), y:148, width: 20, height: 12)
        passeyeButton.setBackgroundImage(UIImage(named: "eye"), for: .normal)
       // passeyeButton.layer.borderColor = UIColor.lightGray.cgColor
        //passeyeButton.layer.borderWidth = 1
        loginSubView.addSubview(passeyeButton)
        passeyeButton.addTarget(self, action: #selector(passeyeButtonPressed(_:)), for: .touchUpInside)
        
        
        checkButton.frame = CGRect(x: 20, y:190, width: 20, height: 20)
        checkButton.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)
        loginSubView.addSubview(checkButton)
        checkButton.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
        
        let rememberMeLabel = UILabel()
        rememberMeLabel.frame = CGRect(x: 50, y:185, width: Int(loginSubView.frame.size.width-90), height: 30)
        rememberMeLabel.layer.cornerRadius = 2
        rememberMeLabel.text = "Remember me"
        loginSubView.addSubview(rememberMeLabel)
        rememberMeLabel.font = UIFont.init(name: "HelveticaNeue-Light", size: 14.0)

        let forgotPasswordButton = UIButton()
        forgotPasswordButton.frame = CGRect(x: Int(loginSubView.frame.size.width-150), y:190, width: 120, height: 20)
       
      //  loginSubView.addSubview(forgotPasswordButton)
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.setTitleColor(UIColor.blue, for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
        
        let loginButton = UIButton()
        loginButton.frame = CGRect(x: Int(loginSubView.frame.size.width/2-60), y:Int(loginSubView.frame.size.height-20), width: 120, height: 40)
        loginButton.layer.borderColor = UIColor.lightGray.cgColor
       // loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 20
        loginButton.layer.cornerRadius = 20
        loginButton.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
        loginButton.setTitle("Login", for: .normal)
        loginSubView.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        loginSubView.addSubview(tableView)

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func checkButtonPressed() -> Void{
        print("checkButtonPressed")
        if isRemeberSelected {
            checkButton.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)
            
           
            isRemeberSelected = false
        }else{
            checkButton.setBackgroundImage(UIImage(named: "check_box_fill"), for: .normal)
            isRemeberSelected = true
        }
    }
    
    @objc func forgotPasswordButtonPressed() -> Void{
        print("forgotPasswordButtonPressed")
    }
    
    @objc func loginButtonPressed() -> Void{
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController
//        vc?.isComingFrom = "Login"
//        self.navigationController?.pushViewController(vc!, animated: true)
        
        
        if (usernameTxtField.text?.count==0 || passwordTxtField.text?.count==0) {
            if(usernameTxtField.text?.count == 0){
                let alert = UIAlertController(title: "Alert", message: "Username can't be empty.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                        
                    }}))
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Alert", message: "Password can't be empty.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                        
                    }}))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            //let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            loadingIndicator.startAnimating();
            loadingIndicator.center = view.center
            view.addSubview(loadingIndicator)
           // present(alert, animated: true, completion: nil)
            
           // let params = ["username":"\(usernameTxtField.text)","passwd":"\(passwordTxtField.text)"] as Dictionary<String, Any>
            let postString = "username=\(usernameTxtField.text!)&passwd=\(passwordTxtField.text!)"
            
            // http://mars.bizofit.com/api/v1/user/getFlavoursList
            
            var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/login")!)
            request.httpMethod = "POST"
            
            request.httpBody = postString.data(using: .utf8)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
            print(request)
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
             //   print(response!)
                guard error == nil else {
                    print(error as Any)
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                    let jsonDict:NSDictionary = json as NSDictionary
                    print(jsonDict.value(forKey: "message") as Any)
                    let code:String = jsonDict.value(forKey: "code") as! String
                    print(code)
                    
                    if (code == "1"){
                    
                    print(jsonDict.value(forKey: "data") as Any)
                    let dataDict:NSDictionary = jsonDict.value(forKey: "data") as! NSDictionary
                    print(dataDict.value(forKey: "user_id") as! String)
                    UserDefaults.standard.setValue(dataDict.value(forKey: "user_id") as! String, forKey: "user_id")

                    let userID:String = dataDict.value(forKey: "user_id") as! String
                        
                        
                    
                    if(userID.count>0){
                        DispatchQueue.main.async {
                            loadingIndicator.stopAnimating();

                            if(self.isRemeberSelected){
                               
                               
                                    self.passwordDict[self.usernameTxtField.text!] = self.passwordTxtField.text!
                                 UserDefaults.standard.set(self.passwordDict, forKey: "passDict")
                                
                            }
                            
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController
                            vc?.isComingFrom = "Login"
                            self.navigationController?.pushViewController(vc!, animated: true)
                        }
                        
                        
                    }
                    }else{
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Error", message: "Invalid Username and password", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                switch action.style{
                                case .default:
                                    print("default")
                                    
                                case .cancel:
                                    print("cancel")
                                    
                                case .destructive:
                                    print("destructive")
                                    
                                    
                                }}))
                            self.present(alert, animated: true, completion: nil)
                            loadingIndicator.stopAnimating()
                            print("error")
                        }
                       
                    }
                    
                } catch {
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: "Invalid Username and password", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            switch action.style{
                            case .default:
                                print("default")
                                
                            case .cancel:
                                print("cancel")
                                
                            case .destructive:
                                print("destructive")
                                
                                
                            }}))
                        self.present(alert, animated: true, completion: nil)
                        loadingIndicator.stopAnimating()
                        print("error")
                    }
                }
            })
            
            
            task.resume()
            
        }
        
        
        

    }
    
    @objc func passeyeButtonPressed(_ sender:AnyObject) -> Void{
    if(iconClick == true) {
    passwordTxtField.isSecureTextEntry = false
    } else {
    passwordTxtField.isSecureTextEntry = true
    }
    
    iconClick = !iconClick
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0){
        passwordTxtField.text = passHintValue
        }
        tableView.isHidden = true
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = passHintValue
        cell?.textLabel?.text = String(passHintValue.characters.map { _ in return "•" })
        return cell!
        }
    
//    var activeTextField = UITextField()
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
//        self.activeTextField = textField
        let index = textField.tag
        
        let keyArr:NSArray = passwordDict.allKeys as NSArray
        
        if UserDefaults.standard.value(forKey: "passDict") != nil {
            let dict:NSMutableDictionary = UserDefaults.standard.value(forKey: "passDict") as! NSMutableDictionary
            print(dict)
            
            if index == 1{
                if let val = dict["\(usernameTxtField.text!)"] {
                    // now val is not nil and the Optional has been unwrapped, so use it
                    
                    let value:String = dict.value(forKey: "\(usernameTxtField.text!)") as! String
                    passHintValue = value
                    tableView.reloadData()
                    tableView.isHidden = false
                }
                
                
            }else{
                tableView.isHidden = true
                
            }
        }
       
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        tableView.isHidden = false
//    }
    


}

