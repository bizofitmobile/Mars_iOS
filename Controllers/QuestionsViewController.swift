//
//  QuestionsViewController.swift
//  Mars
//
//  Created by Arpit Lokwani on 23/09/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController,UITextFieldDelegate {
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        
        let questionOne = "Which region do you want this for?"
        let questionTwo = "What is the application?"
        let questionThree = "Description of the flavor being sought."
        
        let questionOneAnswer = questionOneTextField.text
        let questionTwoAnswer = questionTwoTextField.text
        let questionThreeAnswer = questionThreeTextField.text
        
        
        
        if let user_id = UserDefaults.standard.string(forKey: "user_id") {
           // let postString = "user_id=\(user_id)&message=\(questionOne+questionOneAnswer!+questionTwo+questionTwoAnswer!+questionThree+questionThreeAnswer!)"
            
            let params = ["user_id":user_id,
                          "question1":questionOne,
                          "answer1":questionOneAnswer!,
                          "question2":questionTwo,
                          "answer2":questionTwoAnswer!,
                          "question3":questionThree,
                          "answer3":questionThreeAnswer!
                          ]

            
            // http://mars.bizofit.com/api/v1/user/getFlavoursList
            
            var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/sendFlavourFeedback")!)
            request.httpMethod = "POST"
            let jsonData: Data? = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
            
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
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Alert", message: jsonDict.value(forKey: "message") as? String, preferredStyle: .alert)
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
                        // loadingIndicator.stopAnimating()
                        print("error")
                    }
                    
                }
                catch {
                    
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Error", message: "Something went wrong !!", preferredStyle: .alert)
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
                       // loadingIndicator.stopAnimating()
                        print("error")
                    }
                }
            })
            task.resume()
            
        }
        
        
        
        
        
    }
    @IBOutlet weak var questionThreeTextField: UITextField!
    @IBOutlet weak var questionTwoTextField: UITextField!
    @IBOutlet weak var questionOneTextField: UITextField!
    
    @IBOutlet weak var ccTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var submitBtnAction: UIButton!
    @IBOutlet weak var SubmitBtn: UIButton!
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        questionThreeTextField.delegate = self
        questionTwoTextField.delegate = self
        questionOneTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        SubmitBtn.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
        SubmitBtn.layer.cornerRadius = 15
        navigationController?.navigationBar.isHidden = true
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
