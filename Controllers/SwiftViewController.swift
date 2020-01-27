//
//  SwiftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//



import UIKit

class SwiftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    @IBOutlet weak var rfsSummaryLabel: UILabel!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RFSSummarViewController") as? RFSSummarViewController
        vc?.requestID = self.requestIDArr.object(at: indexPath.row) as! String
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RFSSummaryTableViewCell") as! RFSSummaryTableViewCell
       
        cell.accessoryType = .disclosureIndicator

        cell.personNameLabel.text = (nameArr.object(at: indexPath.row) as! String)
        cell.supplierNameLabel.text = (self.vendorNameArr.object(at: indexPath.row) as! String)
        cell.contentNameLabel.text = (self.messageArr.object(at: indexPath.row) as! String)
        
        cell.dataNameLabel.text = (self.updatedTimeArr.object(at: indexPath.row) as! String)
        cell.imageLabel.text = (self.nameArr.object(at: indexPath.row) as! String).characters.first?.description ?? ""
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    var nameArr = NSMutableArray()
    var contactNumArr = NSMutableArray()
    var AddressArr = NSMutableArray()
    var vendorNameArr = NSMutableArray()
    var messageArr = NSMutableArray()
    var updatedTimeArr = NSMutableArray()
    var requestIDArr = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            
            // Do any additional setup after loading the view.
        
       
        
        
        
        //getProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let rfsSummaryLabelBottomLine = CALayer()
        rfsSummaryLabelBottomLine.frame = CGRect(x:0.0,y: rfsSummaryLabel.frame.height - 1,width: rfsSummaryLabel.frame.width, height:0.7)
        rfsSummaryLabelBottomLine.backgroundColor = UIColor.lightGray.cgColor
        rfsSummaryLabel.layer.addSublayer(rfsSummaryLabelBottomLine)
        
        
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 0.5)
        navigationController?.navigationBar.backgroundColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 1.0)
        self.setNavigationBarItem()
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = UIColor.lightGray
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = UIColor.white
        self.tableView.registerCellNib(RFSSummaryTableViewCell.self)
        let params = ["search":"","page":"","per_page":"","flavour_id":"","country_id":"","legecy_id":"",] as Dictionary<String, String>
        
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        // present(alert, animated: true, completion: nil)
        
         nameArr = NSMutableArray()
         contactNumArr = NSMutableArray()
         AddressArr = NSMutableArray()
         vendorNameArr = NSMutableArray()
         messageArr = NSMutableArray()
         updatedTimeArr = NSMutableArray()
        
        if let user_id = UserDefaults.standard.string(forKey: "user_id") {
            
          //  let postString = "user_id=\(user_id)"
            
            let dict = [ "user_id": "\(user_id)"]
            
            
            var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getSampleRequestsList")!)
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
                    
                    let dataArr:NSArray = (jsonDict.value(forKey: "data") as? NSArray)!
                    print(dataArr)
                    self.requestIDArr = NSMutableArray()
                    self.nameArr = NSMutableArray()
                    self.contactNumArr = NSMutableArray()
                    self.AddressArr = NSMutableArray()
                    self.vendorNameArr = NSMutableArray()
                    self.messageArr = NSMutableArray()
                    self.updatedTimeArr = NSMutableArray()

                    
                    if(dataArr.count>0){
                        for i in 0...dataArr.count-1{
                            
                            let dataDict:NSDictionary = dataArr.object(at: i) as! NSDictionary
                            
                            print(dataDict.value(forKey: "name")!)
                            print(dataDict.value(forKey: "vendor_name")!)
                            print(dataDict.value(forKey: "message")!)
                            print(dataDict.value(forKey: "address")!)
                            print(dataDict.value(forKey: "contact_number")!)
                            self.nameArr.add(dataDict.value(forKey: "name")!)
                            self.contactNumArr.add(dataDict.value(forKey: "contact_number")!)
                            self.AddressArr.add(dataDict.value(forKey: "address")!)
                            self.vendorNameArr.add(dataDict.value(forKey: "vendor_name")!)
                            self.messageArr.add(dataDict.value(forKey: "message")!)
                            self.updatedTimeArr.add(dataDict.value(forKey: "updatetime")!)
                            self.requestIDArr.add(dataDict.value(forKey: "request_id")!)
                            DispatchQueue.main.async {
                                loadingIndicator.stopAnimating()
                                self.tableView.reloadData()
                            }
                            
                            
                        }
                    }
                    
                    
                    //                    print(dataDict.value(forKey: "fname") as! String)
                    //                    print(dataDict.value(forKey: "lname") as! String)
                    //                    print(dataDict.value(forKey: "picture_url") as! String)
                    //                    print(dataDict.value(forKey: "email") as! String)
                    
                    
                    
                    
                    
                } catch {
                    print("error")
                }
            })
            
            task.resume()
            
            
            
        }
        
       
        
        
        self.setNavigationBarItem()
    }
    
}
