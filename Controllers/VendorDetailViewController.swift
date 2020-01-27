//
//  VendorDetailViewController.swift
//  Mars
//
//  Created by Arpit Lokwani on 05/09/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit

class VendorDetailViewController: UIViewController {
    @IBAction func backBtnAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var backBtnPressed: UIButton!
    @IBOutlet weak var countryNameLabel: UILabel!
    var productId = ""
    var flavourName = ""
    var isComingFrom = ""
    
    
   // @IBOutlet weak var marsSourcingValueLabel: UILabel!
   // @IBOutlet weak var supplierEmailLabel: UILabel!
    @IBOutlet weak var priceUSDLabel: UILabel!
    @IBOutlet weak var volumeValueLabel: UILabel!
    @IBOutlet weak var commodityFlavorLabel: UILabel!
    @IBOutlet weak var legacyLabel: UILabel!
    @IBOutlet weak var itemDescValueLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var plantLabel: UILabel!
    @IBOutlet weak var subcountryLabel: UILabel!
    @IBOutlet weak var vendorNameLabel: UILabel!
    
    func getNutsVendorPage() -> Void {
        
        
       // let postString = "nut_id=\(productId)"
        let dict = [ "nut_id": "\(productId)"]

        // http://mars.bizofit.com/api/v1/user/getFlavoursList
        
        var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getNutsVendorDetails")!)
        request.httpMethod = "POST"
        let jsonData = (try? JSONSerialization.data(withJSONObject: dict, options: []))
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        print(request)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
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
                print(dataDict.value(forKey: "commodity") as! String)
                print(dataDict.value(forKey: "country") as! String)
                print(dataDict.value(forKey: "email") as! String)
                print(dataDict.value(forKey: "nut_description") as! String)
                print(dataDict.value(forKey: "legecy") as! String)
                print(dataDict.value(forKey: "location") as! String)
                print(dataDict.value(forKey: "mars_sourcing") as! String)
                print(dataDict.value(forKey: "name") as! String)
                print(dataDict.value(forKey: "price") as! String)
                print(dataDict.value(forKey: "nut_name") as! String)
                print(dataDict.value(forKey: "region") as! String)
                print(dataDict.value(forKey: "volume") as! String)
                
                
                DispatchQueue.main.async {
                    self.countryNameLabel.text = (dataDict.value(forKey: "country") as! String)
                    self.plantLabel.text = (dataDict.value(forKey: "location") as! String)
                    //self.marsSourcingValueLabel.text = (dataDict.value(forKey: "mars_sourcing") as! String)
                    // self.supplierEmailLabel.text = (dataDict.value(forKey: "email") as! String)
                    self.volumeValueLabel.text = dataDict.value(forKey: "volume") as? String
                    self.commodityFlavorLabel.text = dataDict.value(forKey: "commodity") as? String
                    self.itemDescValueLabel.text = dataDict.value(forKey: "nut_description") as? String
                    self.itemLabel.text = dataDict.value(forKey: "nut_name") as? String
                    self.subcountryLabel.text = dataDict.value(forKey: "region") as? String
                    self.vendorNameLabel.text = dataDict.value(forKey: "name") as? String
                    
                    let price:String = dataDict.value(forKey: "price") as! String
                    self.priceUSDLabel.text = "$ "  + price
                    
                    
                    
                }
                
            } catch {
                print("error")
            }
        })
        
        task.resume()
        
        
    }
    
    func getFlavorVendorPage() -> Void {
        
        let postString = "product_id=\(productId)"
        
        // http://mars.bizofit.com/api/v1/user/getFlavoursList
        
        var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getVendorDetails")!)
        request.httpMethod = "POST"
        
        request.httpBody = postString.data(using: .utf8)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        print(request)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
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
                print(dataDict.value(forKey: "commodity") as! String)
                print(dataDict.value(forKey: "country") as! String)
                print(dataDict.value(forKey: "email") as! String)
                print(dataDict.value(forKey: "flavour_name") as! String)
                print(dataDict.value(forKey: "legecy") as! String)
                print(dataDict.value(forKey: "location") as! String)
                print(dataDict.value(forKey: "mars_sourcing") as! String)
                print(dataDict.value(forKey: "name") as! String)
                print(dataDict.value(forKey: "price") as! String)
                print(dataDict.value(forKey: "product_name") as! String)
                print(dataDict.value(forKey: "region") as! String)
                print(dataDict.value(forKey: "volume") as! String)
                
                
                DispatchQueue.main.async {
                    self.countryNameLabel.text = (dataDict.value(forKey: "country") as! String)
                    self.plantLabel.text = (dataDict.value(forKey: "location") as! String)
                    //self.marsSourcingValueLabel.text = (dataDict.value(forKey: "mars_sourcing") as! String)
                    // self.supplierEmailLabel.text = (dataDict.value(forKey: "email") as! String)
                    self.volumeValueLabel.text = dataDict.value(forKey: "volume") as? String
                    self.commodityFlavorLabel.text = dataDict.value(forKey: "commodity") as? String
                    self.itemDescValueLabel.text = dataDict.value(forKey: "flavour_name") as? String
                    self.itemLabel.text = dataDict.value(forKey: "product_name") as? String
                    self.subcountryLabel.text = dataDict.value(forKey: "region") as? String
                    self.vendorNameLabel.text = dataDict.value(forKey: "name") as? String
                    
                    let price:String = dataDict.value(forKey: "price") as! String
                    self.priceUSDLabel.text = "$ "  + price
                    
                    
                    
                }
                
            } catch {
                print("error")
            }
        })
        
        task.resume()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
       
        if isComingFrom == "NutsVendorPage" {
            getNutsVendorPage()
        }else{
            getFlavorVendorPage()
        }
        
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false

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
