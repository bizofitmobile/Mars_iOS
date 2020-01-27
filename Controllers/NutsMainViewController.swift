//
//  NutsMainViewController.swift
//  Mars
//
//  Created by Arpit Lokwani on 28/09/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit
import PDFKit
import WebKit

class NutsMainViewController: UIViewController,UISearchBarDelegate,DataCellDelegate {
    @IBOutlet weak var restartSearchBtn: UIButton!
    let imageCache = NSCache<NSString, UIImage>()
    var nutsImageArr = NSMutableArray()
    var pdfArr = NSMutableArray()
    var webView = WKWebView()
    @IBAction func filterBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let swiftViewController = storyboard.instantiateViewController(withIdentifier: "NutsFilterViewController") as! NutsFilterViewController
        navigationController?.pushViewController(swiftViewController, animated: true)
    }
    @IBAction func menuBtnPressed(_ sender: Any) {
         slideMenuController()?.toggleLeft()
    }
    @IBAction func clickHereBtnPressed(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QuestionsViewController") as? QuestionsViewController
        
        navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func restartHereBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NutsFilterViewController") as? NutsFilterViewController
        
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBOutlet weak var clickhereBtn: UIButton!
    @IBOutlet weak var noFlavorView: UIView!
    
    @IBAction func resetBtnPRessed(_ sender: Any) {
        selectAllBtn.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)
        isAllCheckBoxSelected = false
        selectedVendorLabel.text = "0" + " Selected"
        reset()
    }
    
    
    func reset()  {
        
        
        self.appDelegate.selectedNutsLegacyIDList.removeAllObjects()
        self.appDelegate.selectedNutsCountryIDList.removeAllObjects()
        self.appDelegate.selectedNutsDescList.removeAllObjects()
        self.appDelegate.nutsTagArr.removeAllObjects()
        self.appDelegate.selectedNutsLegacyNameListArr.removeAllObjects()
      //  self.appDelegate.selectedLegacyNameListArr.removeAllObjects()
        self.appDelegate.selectedNutsCountryNameListArr.removeAllObjects()
        self.flavour_ID.removeAllObjects()
        self.country_ID.removeAllObjects()
        self.legacy_ID.removeAllObjects()
        self.plantDescArr.removeAllObjects()
        self.descriptionArr.removeAllObjects()
        self.flavourName.removeAllObjects()
        self.vendorIDArr.removeAllObjects()
        self.legacyNameArr.removeAllObjects()
        
        UserDefaults.standard.setValue(self.appDelegate.selectedNutsLegacyIDList, forKey: "selectedNutsLegacyIDList")
        UserDefaults.standard.setValue(self.appDelegate.selectedNutsCountryIDList, forKey: "selectedNutsCountryIDList")
        // UserDefaults.standard.setValue(isAllCountrySelected, forKey: "isAllCountrySelected")
        UserDefaults.standard.setValue(self.appDelegate.selectedNutsDescList, forKey: "selectedNutsDescList")
        

        selectedRows.removeAll()
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
//        let parameters = [
//            "flavour_name": "",
//            "legecy_id":"",
//            "country_id":"",
//            "is_allowed_country":"0"
//
//        ]
        
        let parameters = NSMutableDictionary()
        
        
        var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getNutsList")!)
        request.httpMethod = "POST"
        // request.httpBody = postString.data(using: .utf8)
        let jsonData: Data? = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        request.httpBody = jsonData
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            if (error != nil){
                
                DispatchQueue.main.async {
                    self.noFlavorView.isHidden = false
                    
                    loadingIndicator.stopAnimating();
                    
                    let alert = UIAlertController(title: "Alert", message: "\(error)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("YES")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                }
                
                
            }else{
                DispatchQueue.main.async {
                    self.noFlavorView.isHidden = true
                    
                }
            }
            //print(response!)
            do {
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating();
                    
                }
                let responseString = String(data: data!, encoding: .utf8)
                
                
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
                let jsonDict:NSDictionary = json as NSDictionary
                print(jsonDict.value(forKey: "data") as Any)
                
                let dataArr:NSArray = jsonDict.value(forKey: "data")  as! NSArray
                
                self.flavour_ID = NSMutableArray()
                self.country_ID = NSMutableArray()
                self.legacy_ID = NSMutableArray()
                self.legacyNameArr = NSMutableArray()
                
                self.descriptionArr = NSMutableArray()
                self.flavourName = NSMutableArray()
                
                if(dataArr.count>0){
                    DispatchQueue.main.async {
                        self.noFlavorView.isHidden = true
                        
                    }
                    
                    for i in 0...dataArr.count-1{
                        let dict: NSDictionary = dataArr.object(at: i) as! NSDictionary
                       
                        self.flavour_ID.add(dict.value(forKey: "nut_id")!)
                        self.country_ID.add(dict.value(forKey: "country_id")!)
                        self.legacy_ID.add(dict.value(forKey: "legecy_id")!)
                        self.plantDescArr.add(dict.value(forKey: "country")!)
                        self.descriptionArr.add(dict.value(forKey: "description")!)
                        self.flavourName.add(dict.value(forKey: "description")!)
                        self.vendorIDArr.add(dict.value(forKey: "vendor_id")!)
                        self.legacyNameArr.add(dict.value(forKey: "legecy")!)
                        
                    }}else{
                    
                    DispatchQueue.main.async {
                        loadingIndicator.stopAnimating();
                        self.noFlavorView.isHidden = false
                        
                        
                        
                        let alert = UIAlertController(title: "Alert", message: "No Vendor(s) Found", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                            switch action.style{
                            case .default:
                                print("YES")
                                
                            case .cancel:
                                print("cancel")
                                
                            case .destructive:
                                print("destructive")
                                
                                
                            }}))
                        // self.present(alert, animated: true, completion: nil)
                        
                    }
                }
                
                
                print(self.flavourName)
                print(self.descriptionArr)
                print(self.flavour_ID)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
                
                
                
            } catch {
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating();
                    
                    let alert = UIAlertController(title: "Alert", message: "No Vendor(s) Found", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("YES")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                    // self.present(alert, animated: true, completion: nil)
                    
                }
                
                
                print("error")
            }
        })
        
        task.resume()
        
    }
    
    func didPressedVendorButton(button: UIButton) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NutsVendorViewController") as? NutsVendorViewController
        selectedFlavourIDs = NSMutableArray()
        if(flavour_ID.count>0){
            selectedFlavourIDs.add(flavour_ID.object(at: button.tag))
        }
        
        
        vc?.selectedFlavourID = selectedFlavourIDs
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    var selectedRows:[IndexPath] = []
    @IBOutlet weak var tableView: UITableView!
    var selectFlavourList = NSMutableArray()
    @IBOutlet weak var searchBar: UISearchBar!
    var isAllCheckBoxSelected = false
    var isAllCountryCheckBoxSelected = false
    var isAllCountryCheckBoxSelectedValue = ""
    var appDelegate = AppDelegate()
    
    var selectedFlavourIDs = NSMutableArray()
    var selectedListIDArr = NSArray()
    var selectedCountryArr = NSArray()
    var selectedFlavourArr = NSArray()
    var plantDescArr = NSMutableArray()
    
    @IBOutlet weak var doneButton: UIButton!
    var checkBoxButtonArr = NSMutableArray()
    @IBAction func doneBtnPressed(_ sender: Any) {
        print("doneBtnPressed")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let swiftViewController = storyboard.instantiateViewController(withIdentifier: "NutsVendorViewController") as! NutsVendorViewController
        // swiftViewController.selectedFlavorName =
        swiftViewController.selectedFlavourID = selectedFlavourIDs
        self.navigationController?.pushViewController(swiftViewController, animated: true)
        
    }
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var selectedVendorLabel: UILabel!
    var flavourName = NSMutableArray()
    var descriptionArr = NSMutableArray()
    var flavour_ID = NSMutableArray()
    var country_ID = NSMutableArray()
    var legacy_ID = NSMutableArray()
    var legacyNameArr = NSMutableArray()
    var vendorIDArr = NSMutableArray()
    var nutsImagesArr = NSMutableArray()
    
    @objc  func cancelBtnPressed() -> Void {
        webView.removeFromSuperview()
    }
    @IBOutlet weak var selectAllBtn: UIButton!
    //http://mars.bizofit.com/api/v1/user/getNutsList
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfArr = ["Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec","Oil Roasted Peanut Split Raw Materials Spec -  All","US - White Blanched Runner Split Specs -  All","1139210 Munch Spec"]
       // nutsImageArr = ["dry_roasted_whole_almonds-2_1_1","whole_hazelnuts","New-Peanuts-Rev1","dry_roasted_whole_almonds-2_1_1","whole_hazelnuts","New-Peanuts-Rev1","dry_roasted_whole_almonds-2_1_1","whole_hazelnuts","New-Peanuts-Rev1","dry_roasted_whole_almonds-2_1_1","whole_hazelnuts","New-Peanuts-Rev1","dry_roasted_whole_almonds-2_1_1","whole_hazelnuts","New-Peanuts-Rev1","dry_roasted_whole_almonds-2_1_1","whole_hazelnuts","New-Peanuts-Rev1","dry_roasted_whole_almonds-2_1_1","whole_hazelnuts","New-Peanuts-Rev1","dry_roasted_whole_almonds-2_1_1","whole_hazelnuts","New-Peanuts-Rev1","dry_roasted_whole_almonds-2_1_1","whole_hazelnuts","New-Peanuts-Rev1","dry_roasted_whole_almonds-2_1_1","whole_hazelnuts","New-Peanuts-Rev1","dry_roasted_whole_almonds-2_1_1","whole_hazelnuts","New-Peanuts-Rev1","dry_roasted_whole_almonds-2_1_1","whole_hazelnuts","New-Peanuts-Rev1","dry_roasted_whole_almonds-2_1_1","whole_hazelnuts","New-Peanuts-Rev1","dry_roasted_whole_almonds-2_1_1","whole_hazelnuts","New-Peanuts-Rev1"]
       
        self.noFlavorView.isHidden = true
        doneBtn.isEnabled = false
        doneBtn.backgroundColor = UIColor.lightGray
      //  var lineView = UIView(frame: CGRect(x:-5,y:restartSearchBtn.frame.size.height+1,width: restartSearchBtn.frame.size.width+10,height:1))
       // lineView.backgroundColor=UIColor.lightGray
       // restartSearchBtn.addSubview(lineView)
      //  addDoneButtonOnKeyboard()
        clickhereBtn.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
        clickhereBtn.layer.cornerRadius = 15
        
        searchBar.change(textFont: UIFont.systemFont(ofSize: 12))
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        doneBtn.isEnabled = false
        self.searchBar.clipsToBounds = true
        searchBar.delegate = self
        // print(selectedFlavourIDs)
        searchBar.frame.size.height = 30
        selectAllBtn.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)
        
        //selectAllBtn.layer.borderColor = UIColor.lightGray.cgColor
        // selectAllBtn.layer.borderWidth = 1
        navigationController?.navigationBar.isHidden = false
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        tableView.delegate = self
        tableView.dataSource = self
        
        let userdefaults = UserDefaults.standard
        //        var postString = ""
        //        postString = "flavour_name" + "="
        
        
      
        
        if userdefaults.array(forKey: "selectedNutsLegacyIDList") != nil{
            
            selectedListIDArr = userdefaults.array(forKey: "selectedNutsLegacyIDList")! as NSArray
            
        }
        
        if userdefaults.array(forKey: "selectedNutsCountryIDList") != nil{
            
            selectedCountryArr = userdefaults.array(forKey: "selectedNutsCountryIDList")! as NSArray
            
        }
        
        
        
        
//        if userdefaults.array(forKey: "selectedNutsDescList") != nil{
//            selectedFlavourArr = userdefaults.array(forKey: "selectedNutsDescList")! as NSArray
//        }
        
        if userdefaults.array(forKey: "selectedNutsCatIdList") != nil{
            selectedFlavourArr = userdefaults.array(forKey: "selectedNutsCatIdList")! as NSArray
        }
        
//        if userdefaults.bool(forKey: "isAllCountrySelected") != nil{
//            isAllCountryCheckBoxSelected = userdefaults.bool(forKey: "isAllCountrySelected")
//            if isAllCountryCheckBoxSelected == false{
//                isAllCountryCheckBoxSelectedValue = "0"
//            }else{
//                isAllCountryCheckBoxSelectedValue = "1"
//            }
//        }
        
        
        let parameters = [
            "category_id": selectedFlavourArr,
            "legecy_id":selectedListIDArr,
            "country_id":selectedCountryArr,
        
            ] as [String : Any]
        
        
        
        
        var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getNutsList")!)
        request.httpMethod = "POST"
        // request.httpBody = postString.data(using: .utf8)
        let jsonData: Data? = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        request.httpBody = jsonData
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            if (error != nil){
                DispatchQueue.main.async {
                   // self.noFlavorView.isHidden = false
                    
                    loadingIndicator.stopAnimating();
                    
                    let alert = UIAlertController(title: "Alert", message: "\(error)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("YES")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                }
                
                
            }else{
                DispatchQueue.main.async {
                    //self.noFlavorView.isHidden = true
                }
                
            }
            //print(response!)
            do {
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating();
                    
                }
                if(data != nil){
                    let responseString = String(data: data!, encoding: .utf8)
                    
                    
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                    let jsonDict:NSDictionary = json as NSDictionary
                    print(jsonDict.value(forKey: "data") as Any)
                    
                    let dataArr:NSArray = jsonDict.value(forKey: "data")  as! NSArray
                    self.flavour_ID = NSMutableArray()
                    self.country_ID = NSMutableArray()
                    self.legacy_ID = NSMutableArray()
                    self.plantDescArr = NSMutableArray()
                    self.descriptionArr = NSMutableArray()
                    self.flavourName = NSMutableArray()
                    self.vendorIDArr = NSMutableArray()
                    self.legacyNameArr = NSMutableArray()
                    self.nutsImagesArr = NSMutableArray()
                    if(dataArr.count>0){
                        DispatchQueue.main.async {
                            //self.noFlavorView.isHidden = true
                            
                        }
                        for i in 0...dataArr.count-1{
                            let dict: NSDictionary = dataArr.object(at: i) as! NSDictionary
                         
                            self.flavour_ID.add(dict.value(forKey: "nut_id")!)
                            self.country_ID.add(dict.value(forKey: "country_id")!)
                            self.nutsImagesArr.add(dict.value(forKey: "picture")!)
                            self.legacy_ID.add(dict.value(forKey: "legecy_id")!)
                            self.plantDescArr.add(dict.value(forKey: "country")!)
                            self.descriptionArr.add(dict.value(forKey: "description")!)
                            self.flavourName.add(dict.value(forKey: "description")!)
                            self.vendorIDArr.add(dict.value(forKey: "vendor_id")!)
                            self.legacyNameArr.add(dict.value(forKey: "legecy")!)
                            
                            
                        }}else{
                        
                        DispatchQueue.main.async {
                            loadingIndicator.stopAnimating();
                            self.noFlavorView.isHidden = false
                            
                            
                            let alert = UIAlertController(title: "Alert", message: "No Vendor(s) Found", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                switch action.style{
                                case .default:
                                    print("YES")
                                    
                                case .cancel:
                                    print("cancel")
                                    
                                case .destructive:
                                    print("destructive")
                                    
                                    
                                }}))
                            // self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                    
                    
                   
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        HanselWrapper.logEvent(eventName: "nuts_pantry_opened", properties: [:])

                        
                    }
                    
                }
                
            } catch {
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating();
                    
                    let alert = UIAlertController(title: "Alert", message: "No Vendor(s) Found", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("YES")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                    // self.present(alert, animated: true, completion: nil)
                    
                }
                
                
                print("error")
            }
        })
        
        task.resume()
        
        
        
        //        if userdefaults.array(forKey: "selectedFlavourIDs") != nil{
        //            let arr : NSArray = userdefaults.array(forKey: "selectedFlavourIDs")! as NSArray
        //            if(arr.count>0){
        //            for i in 0...arr.count-1{
        //
        //                let val:String = arr.object(at: i) as! String
        //
        //                postString.append(val)
        //                if (i != arr.count-1){
        //                    postString.append(",")
        //                }
        //
        //            }
        //            }
        //        } else {
        //             postString = "flavour_name" + "=" + "APPLE FLAVOR"
        //        }
        //        print(postString)
        // let params = ["search":"","page":"","per_page":"","flavour_id":"\(selectFlavourList)","country_id":"","legecy_id":"",] as Dictionary<String, String>
        
        
        // let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        //        present(alert, animated: true, completion: nil)
        //
        
        
        // http://mars.bizofit.com/api/v1/user/getFlavoursList
        
        
        
        
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = UIColor.lightGray
        view.backgroundColor = UIColor.white
        self.tableView.registerCellNib(DataTableViewCell.self)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
       // setNavigationBarItem()
     
        
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
    @IBAction func selectAllPressed(_ sender: Any) {
        print("selectAllPressed")
        if isAllCheckBoxSelected == false {
            
            self.selectedRows = getAllIndexPaths()
            self.tableView.reloadData()
            
            selectedFlavourIDs = NSMutableArray()
            if(selectedRows.count>0){
                for i in 0...selectedRows.count-1{
                    let indexpath:IndexPath = selectedRows[i]
                    print(indexpath.row)
                    selectedFlavourIDs.add(flavour_ID.object(at: indexpath.row))
                    
                }}
            
            isAllCheckBoxSelected = true
            selectAllBtn.setBackgroundImage(UIImage(named: "check_box_fill"), for: .normal)
            //            isAllCheckBoxSelected = true
            //
            //            for i in 0...checkBoxButtonArr.count-1{
            //                let btn: UIButton = checkBoxButtonArr.object(at: i) as! UIButton
            //                btn.setBackgroundImage(UIImage(named: "check_box_fill"), for: .normal)
            //                buttonStateDictionary.setValue("selected", forKey: "\(i)")
            //            }
        }else{
            
            self.selectedRows.removeAll()
            self.tableView.reloadData()
            
            
            selectAllBtn.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)
            isAllCheckBoxSelected = false
            //            for i in 0...checkBoxButtonArr.count-1{
            //                let btn: UIButton = checkBoxButtonArr.object(at: i) as! UIButton
            //                btn.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)
            //                buttonStateDictionary.setValue("unselected", forKey: "\(i)")
        }
        
        selectedVendorLabel.text = "\(selectedRows.count)" + " Selected"
        print(selectedRows)
        
        if selectedRows.count>0 {
            doneBtn.isEnabled = true
            doneBtn.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
        }else{
            doneBtn.isEnabled = false
            doneBtn.backgroundColor = UIColor.lightGray
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProfile()
//        navigationController?.navigationBar.isHidden = false
//        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 0.5)
//        navigationController?.navigationBar.backgroundColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 1.0)
//        self.setNavigationBarItem()
        
    }
    
    func didPressedPDFBtn(button: UIButton) {
        print("nuts pdf called")
        let url = Bundle.main.url(forResource: "\(pdfArr.object(at: button.tag))", withExtension: "pdf")
        
        if let url = url {
             webView.frame = view.frame
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
            view.addSubview(webView)
            let cancelBtn = UIButton()
            cancelBtn.frame =  CGRect(x: view.frame.size.width-40, y: 40, width: 20, height: 20)
            
            cancelBtn.setBackgroundImage(UIImage(named: "close"), for: .normal)
            cancelBtn.addTarget(self, action: #selector(cancelBtnPressed), for: .touchUpInside)
            webView.addSubview(cancelBtn)
        }
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


extension NutsMainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DataTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let subContentsVC = storyboard.instantiateViewController(withIdentifier: "VendorDetailViewController") as! VendorDetailViewController
        //        self.navigationController?.pushViewController(subContentsVC, animated: true)
    }
    
    
}

extension NutsMainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flavourName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.identifier) as! DataTableViewCell
        cell.delegate = self 
        if !checkBoxButtonArr.contains(cell.checkBtn) {
            checkBoxButtonArr.add(cell.checkBtn)
            
        }
       // cell.dataImage.image = UIImage(named: "\(nutsImageArr.object(at: indexPath.row))")
        cell.pdfBtn.isHidden = false
        
        cell.vendorImage.tag = (indexPath.section * 1000) + indexPath.row
        cell.checkBtn.tag = (indexPath.section * 1000) + indexPath.row
        // cell.imageLabel.text = "C"
        cell.imageLabel.textAlignment = .center
        cell.pdfBtn.tag = indexPath.row
 
      //  print("cell.checkBtn.tag.Tag = \(cell.checkBtn.tag)")
        let text:String = "\(self.flavourName[indexPath.row] as! String)"  + "\n" + "\(self.plantDescArr[indexPath.row] as! String)" + "," + "\(self.legacyNameArr[indexPath.row] as! String)" 
        
        cell.imageLabel.isHidden = false
        //cell.dataImage.layer.borderColor = UIColor.lightGray.cgColor
        //cell.dataImage.layer.borderWidth = 0.3
        cell.dataImage.contentMode = .scaleAspectFill
        cell.dataImage.tag = (indexPath.section * 1000) + indexPath.row
        print("dataImage.tag = \(cell.dataImage.tag)")
       // cell.dataImage.imageFromUrl(urlString: self.nutsImageArr.object(at: indexPath.row) as! String)
        
       print(" indexPath = \(indexPath)")
        print(" indexPath row\(indexPath.row)")

        //buttonStateDictionary.setValue("unselected", forKey: "\(indexPath.row)")
        let data = DataTableViewCellData(imageUrl: self.nutsImagesArr.object(at: indexPath.row) as! String, text: text)
        
        
        
        cell.setData(data)
        cell.imageLabel.text = text.characters.first?.description ?? ""
        
        var imageURL = ""
        imageURL = data.imageUrl
        if imageURL.count == 0  {
            imageURL = "test"
            cell.imageLabel.isHidden = false
        }else{
            
            cell.imageLabel.isHidden = true
        }
        cell.dataImage.downloadImage(from: imageURL)

        //        var showImage = false
//
//
//
//
//
//            var urlString = ""
//            urlString = data.imageUrl
//
//            if(urlString.count==0){
//                urlString = "test"
//                showImage = false
//            }else{
//                showImage = true
//            }
//
//            let url = URL(string:
//                urlString)
//
//
//            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
//                guard let data = data, error == nil else { return }
//
//                DispatchQueue.main.async() {
//                    // execute on main thread
//                        if indexPath.row == cell.dataImage.tag {
//                    if(showImage){
//                        cell.dataImage.image = UIImage(data: data)
//                        cell.imageLabel.isHidden = true
//                    }else{
//                        cell.imageLabel.isHidden = false
//                        cell.imageLabel.text = text.characters.first?.description ?? ""
//
//                            }
//                    }
//                }
//            }
//
//            task.resume()
        
        
        
        
        
        //        if buttonState == "unselected" {
        //            cell.checkBtn.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)
        //
        //        }else{
        //            cell.checkBtn.setBackgroundImage(UIImage(named: "check_box_fill"), for: .normal)
        
        if selectedRows.contains(indexPath){
            cell.checkBtn.setBackgroundImage(UIImage(named: "check_box_fill"), for: .normal)
            
        }
        else{
            cell.checkBtn.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)
            
            
        }
        
        
        
        return cell
        
    }
    
    
    func didPressedCheckBoxButton(button: UIButton) {
        print("new tag = \(button.tag)")
        
        
        let selectedIndexPath = IndexPath(row: button.tag, section: 0)
        if self.selectedRows.contains(selectedIndexPath){
            self.selectedRows.remove(at: self.selectedRows.index(of: selectedIndexPath)!)
        }else{
            self.selectedRows.append(selectedIndexPath)
        }
        self.tableView.reloadData()
        
        
        
        
        if selectedRows.count == flavour_ID.count {
            selectAllBtn.setBackgroundImage(UIImage(named: "check_box_fill"), for: .normal)
            
        }else{
            selectAllBtn.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)
            
        }
        
        selectedVendorLabel.text = "\(selectedRows.count)" + " Selected"
        print(selectedRows)
        selectedFlavourIDs = NSMutableArray()
        if(selectedRows.count>0){
            for i in 0...selectedRows.count-1{
                let indexpath:IndexPath = selectedRows[i]
                print(indexpath.row)
                selectedFlavourIDs.add(flavour_ID.object(at: indexpath.row))
                
            }}
        
        
        if selectedRows.count>0 {
            doneBtn.isEnabled = true
            doneBtn.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
        }else{
            doneBtn.isEnabled = false
            doneBtn.backgroundColor = UIColor.lightGray
            
        }
        
        
    }
}

extension NutsMainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
    
    
    
    func getAllIndexPaths()->[IndexPath]{
        
        var indexPaths:[IndexPath] = []
        for j in 0..<tableView.numberOfRows(inSection:0){
            indexPaths.append(IndexPath(row: j, section: 0))
        }
        return indexPaths
    }
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        searchBar.inputAccessoryView = doneToolbar
    }
    @objc func doneButtonAction(){
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String){
        print("searchText \(searchBar.text)")
        updateSearchData(value: searchBar.text!)
        
    }
    
    func updateSearchData(value:String)  {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        
        
        let userdefaults = UserDefaults.standard
        //        var postString = ""
        //        postString = "flavour_name" + "="
        
        
        if userdefaults.array(forKey: "selectedNutsLegacyIDList") != nil{
            
            selectedListIDArr = userdefaults.array(forKey: "selectedNutsLegacyIDList")! as NSArray
            
        }
        
        if userdefaults.array(forKey: "selectedNutsCountryIDList") != nil{
            
            selectedCountryArr = userdefaults.array(forKey: "selectedNutsCountryIDList")! as NSArray
            
        }
        
        

        if userdefaults.array(forKey: "selectedNutsCatIdList") != nil{
            selectedFlavourArr = userdefaults.array(forKey: "selectedNutsCatIdList")! as NSArray
        }
//
//        if userdefaults.array(forKey: "selectedNutsDescList") != nil{
//            selectedFlavourArr = userdefaults.array(forKey: "selectedNutsDescList")! as NSArray
//        }
        
        
        
        
        let parameters = [
            "category_id": selectedFlavourArr,
            "legecy_id":selectedListIDArr,
            "country_id":selectedCountryArr,
             "search":value
            
            ] as [String : Any]
        
        
        
        //let postString = "search=\(value)"
        
        var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getNutsList")!)
        request.httpMethod = "POST"
        let jsonData: Data? = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            // print(response!)
            
            if(error != nil){
                DispatchQueue.main.async {
                     self.noFlavorView.isHidden = false
                    
                    loadingIndicator.stopAnimating();
                    
                }
            }else{
                DispatchQueue.main.async {
                    self.noFlavorView.isHidden = true
                }
                
            }
            do {
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating();
                    
                }
                
                if (data != nil){
                    
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                    let jsonDict:NSDictionary = json as NSDictionary
                    print(jsonDict.value(forKey: "data") as Any)
                    
                    let dataArr:NSArray = jsonDict.value(forKey: "data")  as! NSArray
                    
                    self.flavour_ID = NSMutableArray()
                    self.country_ID = NSMutableArray()
                    self.legacy_ID = NSMutableArray()
                    self.plantDescArr = NSMutableArray()
                    self.descriptionArr = NSMutableArray()
                    self.flavourName = NSMutableArray()
                    self.vendorIDArr = NSMutableArray()
                    self.legacyNameArr = NSMutableArray()
                    if(dataArr.count>0){
                        DispatchQueue.main.async {
                            self.noFlavorView.isHidden = true
                            
                        }
                        for i in 0...dataArr.count-1{
                            let dict: NSDictionary = dataArr.object(at: i) as! NSDictionary
                            
                            self.flavour_ID.add(dict.value(forKey: "nut_id")!)
                            self.country_ID.add(dict.value(forKey: "country_id")!)
                            self.legacy_ID.add(dict.value(forKey: "legecy_id")!)
                            self.plantDescArr.add(dict.value(forKey: "country")!)
                            self.descriptionArr.add(dict.value(forKey: "description")!)
                            self.flavourName.add(dict.value(forKey: "description")!)
                            self.vendorIDArr.add(dict.value(forKey: "vendor_id")!)
                            self.legacyNameArr.add(dict.value(forKey: "legecy")!)
                            
                            
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            
                        }
                    }else{
                        DispatchQueue.main.async {
                               self.noFlavorView.isHidden = false
                            
                        }
                    }
                    print(self.flavourName)
                    print(self.descriptionArr)
                    print(self.flavour_ID)
                    
                    
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
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func downloadImage(from imgURL: String!) {
        let url = URLRequest(url: URL(string: imgURL)!)
        
        // set initial image to nil so it doesn't use the image from a reused cell
        image = nil
        
        // check if the image is already in the cache
        if let imageToCache = imageCache.object(forKey: imgURL! as NSString) {
            self.image = imageToCache
            return
        }
        
        // download the image asynchronously
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                // create UIImage
                let imageToCache = UIImage(data: data!)
                // add image to cache
                imageCache.setObject(imageToCache!, forKey: imgURL! as NSString)
                self.image = imageToCache
            }
        }
        task.resume()
    }
}


