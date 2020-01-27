//
//  RFSSummarViewController.swift
//  Mars
//
//  Created by Arpit Lokwani on 07/09/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit

class RFSSummarViewController: UIViewController {
    
    @IBOutlet weak var backBtnActions: UIButton!
    
    
    @IBAction func backBtnAcction(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
   
    @IBOutlet weak var personNameLabel: UILabel!
    
    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var supplierNameLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    var requestID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        imageLabel.layer.cornerRadius = 25
        imageLabel.layer.masksToBounds = true
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        // present(alert, animated: true, completion: nil)
        
        
        let dict = [ "request_id": "\(requestID)"]
        
        
        var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getSampleRequestsDetails")!)
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
                print(error as Any)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
                let jsonDict:NSDictionary = json as NSDictionary
                
                let dataDict:NSDictionary = (jsonDict.value(forKey: "data") as? NSDictionary)!
                print(dataDict)
                
               
                        
                        print(dataDict.value(forKey: "message")!)
                        print(dataDict.value(forKey: "name")!)
                        print(dataDict.value(forKey: "contact_number")!)
                        print(dataDict.value(forKey: "vendor_name")!)
                        print(dataDict.value(forKey: "contact_number")!)
                        
                        DispatchQueue.main.async {
                            loadingIndicator.stopAnimating()
                            self.contactNumberLabel.text = (dataDict.value(forKey: "contact_number") as! String)
                            self.personNameLabel.text = (dataDict.value(forKey: "name")! as? String)
                            self.contactNumberLabel.text = dataDict.value(forKey: "contact_number")! as? String
                            self.addressLabel.text = dataDict.value(forKey: "address")! as! String
                            self.messageLabel.text = dataDict.value(forKey: "message")! as! String
                            self.supplierNameLabel.text = dataDict.value(forKey: "vendor_name")! as! String
                            
                            self.imageLabel.text = (dataDict.value(forKey: "name")! as? String)?.characters.first?.description ?? ""
                           
                        }
                        
                        
                    
                }
                
                
            
                
                
                
                
             catch {
                print("error")
            }
        })
        
        task.resume()
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false

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
