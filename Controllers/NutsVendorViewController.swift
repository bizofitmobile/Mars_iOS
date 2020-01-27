//
//  NutsVendorViewController.swift
//  Mars
//
//  Created by Arpit Lokwani on 29/09/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit

class NutsVendorViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,VendorCheckBoxDelegate  {
    
    @IBOutlet weak var noVendorScreen: UIView!
    var activeProductID = ""
    var activeFlavourID = ""
    var activeVendorID = ""
    var activeFlavourName = ""
    var activeCommodityID = ""
    var isAllCountryCheckBoxSelectedValue = ""
    var isAllCheckBoxSelected = false
    var isAllCountryCheckBoxSelected = false
    var appDelegate = AppDelegate()
    
    var selectedFlavourIDs = NSMutableArray()
    var selectedListIDArr = NSArray()
    var selectedCountryArr = NSArray()
    var selectedFlavourArr = NSArray()
    var selectedIndexForCategory = 0
    var selectedCatArr = NSArray()
    func didPressedRadioButton(button: UIButton) {
        
        print("selected Button is \(button.tag)")
        selectedIndexForCategory = button.tag
       // print(sourceTeamArr.object(at: button.tag))
       // print(vendorIDArr.object(at: button.tag))
//        activeProductID = self.productIDArr.object(at: button.tag) as! String
        activeFlavourID = self.flavorIDArr.object(at: button.tag) as! String
        activeVendorID = self.vendorIDArr.object(at: button.tag) as! String
        activeFlavourName = self.flavourName.object(at: button.tag) as! String
        activeCommodityID = self.commodityIDArr.object(at: button.tag) as! String
        print(activeProductID)
        print(activeFlavourID)
        print(activeVendorID)
        
        
        for i in 0...radioBtnsArr.count-1 {
            doneBtn.isEnabled = true
            doneBtn.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
            
            let btn:UIButton = radioBtnsArr.object(at: i) as! UIButton
            if (btn.tag == button.tag){
                btn.setBackgroundImage(UIImage(named: "radiobox"), for: .normal)
            }else{
                btn.setBackgroundImage(UIImage(named: "radiobox_uncheck"), for: .normal)
            }
            
        }
        
    }
    
    
    
    @IBAction func filterBtnAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NutsFilterVendorViewController") as? NutsFilterVendorViewController
        // vc?.filterPreviousScreen = "Vendor"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
     navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    @IBAction func doneBtnPressed(_ sender: Any) {
        print("doneBtnPressed")
        // let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewSampleRequestViewController") as? NewSampleRequestViewController
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "JavaViewController") as? JavaViewController
        vc?.isComingFrom = "Search"
        // vc?.categoryID = self.categoryIDArr.object(at: selectedIndexForCategory) as! String
        vc?.flavour = activeFlavourName
       // vc?.selectedProductID = activeProductID
        vc?.selectedVendorID = activeVendorID
        vc?.selectedFlavourID = activeFlavourID
        vc?.selectedCommodityID = activeCommodityID
        vc?.isComingFromVendor = "NutsVendor"
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBOutlet weak var doneBtn: UIButton!
    var vendorName = NSMutableArray()
    var flavourName = NSMutableArray()
    var legacyArr = NSMutableArray()
    var countryArr = NSMutableArray()
    var amountArr = NSMutableArray()
    var legacy_ID = NSMutableArray()
    var sourceTeamArr = NSMutableArray()
    var vendorIDArr = NSMutableArray()
    var flavorIDArr = NSMutableArray()
    var productIDArr = NSMutableArray()
    var categoryIDArr = NSMutableArray()
    var commodityIDArr = NSMutableArray()
    
    var radioBtnsArr = NSMutableArray()
    
    var selectedFlavourID = NSMutableArray()
    
    
    
    
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String){
        print("searchText \(searchBar.text!)")
        updateSearchData(value: searchBar.text!)
        
    }
    
    func updateSearchData(value:String)  {
        
        
        if(value.count>=3 || value.count == 0){
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            loadingIndicator.startAnimating();
            loadingIndicator.center = view.center
            view.addSubview(loadingIndicator)
            // let params = ["search":value,"page":"","per_page":"","flavour_id":"","country_id":"","legecy_id":"",] as Dictionary<String, String>
            let userdefaults = UserDefaults.standard
            //        var postString = ""
            //        postString = "flavour_name" + "="
            
            
//
//            if userdefaults.array(forKey: "vendorSelectedLegacyIDList") != nil{
//
//                selectedListIDArr = userdefaults.array(forKey: "vendorSelectedLegacyIDList")! as NSArray
//
//            }
//
//            if userdefaults.array(forKey: "vendorSelectedCountryIDList") != nil{
//
//                selectedCountryArr = userdefaults.array(forKey: "vendorSelectedCountryIDList")! as NSArray
//
//            }
//
//
//
//
//            if userdefaults.array(forKey: "vendorSelectedFlavourIDs") != nil{
//                selectedFlavourArr = userdefaults.array(forKey: "vendorSelectedFlavourIDs")! as NSArray
//            }
//            if userdefaults.bool(forKey: "isAllCountrySelectedVendor") != nil{
//                isAllCountryCheckBoxSelected = userdefaults.bool(forKey: "isAllCountrySelectedVendor")
//                if isAllCountryCheckBoxSelected == false{
//                    isAllCountryCheckBoxSelectedValue = "0"
//                }else{
//                    isAllCountryCheckBoxSelectedValue = "1"
//                }
//            }
//
//
//            let arr:NSArray = (selectedFlavourID as? NSArray)!
//
            if userdefaults.array(forKey: "vendorNutsSelectedLegacyIDList") != nil{
                
                selectedListIDArr = userdefaults.array(forKey: "vendorNutsSelectedLegacyIDList")! as NSArray
                
            }
            
            if userdefaults.array(forKey: "vendorNutsSelectedCountryIDList") != nil{
                
                selectedCountryArr = userdefaults.array(forKey: "vendorNutsSelectedCountryIDList")! as NSArray
                
            }
            
            
            
            
            if userdefaults.array(forKey: "vendorNutsSelectedFlavourIDs") != nil{
                selectedFlavourArr = userdefaults.array(forKey: "vendorNutsSelectedFlavourIDs")! as NSArray
            }
            
            if userdefaults.array(forKey: "selectedNutsCatIdList") != nil{
                selectedCatArr = userdefaults.array(forKey: "selectedNutsCatIdList")! as NSArray
            }
            
            
            
            let arr:NSArray = (selectedFlavourID as? NSArray)!
            
            
            
            
            let parameters = [
                "nut_id": arr,
                "legecy_id":selectedListIDArr,
                "country_id":selectedCountryArr,
                "search":value
                //"flavour_ids": arr
                
                
                ] as [String : Any]
            
            
            var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getNutsVendorsList")!)
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
                        
                      
                        DispatchQueue.main.async {
                            
                       //     self.noVendorScreen.isHidden = false
                            let alert = UIAlertController(title: "Alert", message: "No Vendor Found.Please search again.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
                                switch action.style{
                                case .default:
                                    print("YES")
                                    
                                case .cancel:
                                    print("cancel")
                                    
                                case .destructive:
                                    print("destructive")
                                    
                                    
                                }}))
                            //   self.present(alert, animated: true, completion: nil)
                            // self.tableView.reloadData()
                            
                        }
                        
                    }
                }else{
                   
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
                    
                    
                    let dataArr:NSArray = jsonDict.value(forKey: "data")  as! NSArray
                    
                    self.flavourName = NSMutableArray()
                    self.vendorName = NSMutableArray()
                    self.flavourName = NSMutableArray()
                    self.legacyArr = NSMutableArray()
                    self.countryArr = NSMutableArray()
                    self.amountArr = NSMutableArray()
                    self.categoryIDArr = NSMutableArray()
                    self.vendorIDArr = NSMutableArray()
                    self.sourceTeamArr = NSMutableArray()
                    self.flavorIDArr = NSMutableArray()
                    self.productIDArr = NSMutableArray()
                    
                    
                    if(dataArr.count>0){
                        DispatchQueue.main.async {
                            self.noVendorScreen.isHidden = true
                        }
                        for i in 0...dataArr.count-1{
                            let dict: NSDictionary = dataArr.object(at: i) as! NSDictionary
                            
                            self.flavourName.add(dict.value(forKey: "description")!)
                            self.vendorName.add(dict.value(forKey: "vendor_name")!)
                            self.legacyArr.add(dict.value(forKey: "legecy")!)
                            self.countryArr.add(dict.value(forKey: "country")!)
                            self.amountArr.add(dict.value(forKey: "price")!)
                            self.vendorIDArr.add(dict.value(forKey: "vendor_id")!)
                            // self.sourceTeamArr.add(dict.value(forKey: "mars_sourcing")!)
                            self.flavorIDArr.add(dict.value(forKey: "nut_id")!)
                            // self.productIDArr.add(dict.value(forKey: "product_id")!)
                            //                            self.categoryIDArr.add(dict.value(forKey: "category_id")!)
                            
                            
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.noVendorScreen.isHidden = false
                            
                            
                            let alert = UIAlertController(title: "Alert", message: "No Vendor Found.Please search again.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
                                switch action.style{
                                case .default:
                                    print("YES")
                                    
                                case .cancel:
                                    print("cancel")
                                    
                                case .destructive:
                                    print("destructive")
                                    
                                    
                                }}))
                            //  self.present(alert, animated: true, completion: nil)
                            // self.tableView.reloadData()
                            
                        }
                    }
                    print(self.flavourName)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                    
                   
                    
                } catch {
                    DispatchQueue.main.async {
                        loadingIndicator.stopAnimating();
                        self.noVendorScreen.isHidden = false
                        
                        
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Alert", message: "No Vendor Found.Please search again.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
                                switch action.style{
                                case .default:
                                    print("YES")
                                    
                                case .cancel:
                                    print("cancel")
                                    
                                case .destructive:
                                    print("destructive")
                                    
                                    
                                }}))
                            //   self.present(alert, animated: true, completion: nil)
                            // self.tableView.reloadData()
                            
                        }
                        
                    }
                    print("error")
                }
            })
            
            task.resume()
        }
        
    }
    
    
    @IBAction func selectAllPressed(_ sender: Any) {
        print("selectAllPressed")
    }
    
    var mainContens = ["data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10", "data11", "data12", "data13", "data14", "data15"]
    
    func getVendorsList() -> Void {
        
        
        let userdefaults = UserDefaults.standard
        //        var postString = ""
        //        postString = "flavour_name" + "="
        
        
        /*
         UserDefaults.standard.setValue(self.appDelegate.selectedFlavorIDForVendor, forKey: "vendorNutsSelectedFlavourIDs")
         UserDefaults.standard.setValue(self.appDelegate.selectedVendorlegacyIDList, forKey: "vendorNutsSelectedLegacyIDList")
         UserDefaults.standard.setValue(self.appDelegate.selectedVendorCountryIDList, forKey: "vendorNutsSelectedCountryIDList")
         
         
         UserDefaults.standard.setValue(self.appDelegate.selectedVendorCatIdListArr, forKey: "selectedVendorNutsCatIdList")
 */
        
        
        if userdefaults.array(forKey: "vendorNutsSelectedLegacyIDList") != nil{
            
            selectedListIDArr = userdefaults.array(forKey: "vendorNutsSelectedLegacyIDList")! as NSArray
            
        }
        
        if userdefaults.array(forKey: "vendorNutsSelectedCountryIDList") != nil{
            
            selectedCountryArr = userdefaults.array(forKey: "vendorNutsSelectedCountryIDList")! as NSArray
            
        }
        
        
        
        
        if userdefaults.array(forKey: "vendorNutsSelectedFlavourIDs") != nil{
            selectedFlavourArr = userdefaults.array(forKey: "vendorNutsSelectedFlavourIDs")! as NSArray
        }
        
        if userdefaults.array(forKey: "selectedNutsCatIdList") != nil{
            selectedCatArr = userdefaults.array(forKey: "selectedNutsCatIdList")! as NSArray
        }
        

        
        let arr:NSArray = (selectedFlavourID as? NSArray)!
        
        
        
        let parameters = [
            "nut_id": arr,
            "legecy_id":selectedListIDArr,
            "country_id":selectedCountryArr,
            "category_id": selectedCatArr,

            //"flavour_ids": arr
            
            
            ] as [String : Any]
        
        
        
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        
        
        
        
        var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getNutsVendorsList")!)
        request.httpMethod = "POST"
        let jsonData: Data? = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        request.httpBody = jsonData
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            ///print(response!)
            
            if (error != nil){
                DispatchQueue.main.async {
                    
                    self.noVendorScreen.isHidden = true
                }
                let alert = UIAlertController(title: "Error", message: "No Vendor found", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("YES")
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                            
                        }
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                        
                    }}))
                
                self.present(alert, animated: true, completion: nil)
                
            }else{
                DispatchQueue.main.async {
                    
                    self.noVendorScreen.isHidden = false
                }
            }
            
            do {
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating();
                    
                }
                if(data != nil){
                    DispatchQueue.main.async {
                        
                        self.noVendorScreen.isHidden = true
                    }
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                    let jsonDict:NSDictionary = json as NSDictionary
                    print(jsonDict.value(forKey: "data") as Any)
                    
                    let dataArr:NSArray = jsonDict.value(forKey: "data")  as! NSArray
                    self.flavourName = NSMutableArray()
                    self.vendorName = NSMutableArray()
                    self.flavourName = NSMutableArray()
                    self.legacyArr = NSMutableArray()
                    self.countryArr = NSMutableArray()
                    self.amountArr = NSMutableArray()
                    self.categoryIDArr = NSMutableArray()
                    self.vendorIDArr = NSMutableArray()
                    self.sourceTeamArr = NSMutableArray()
                    self.flavorIDArr = NSMutableArray()
                    self.productIDArr = NSMutableArray()
                    if(dataArr.count>0){
                        DispatchQueue.main.async {
                            
                            self.noVendorScreen.isHidden = true
                        }
                        for i in 0...dataArr.count-1{
                            let dict: NSDictionary = dataArr.object(at: i) as! NSDictionary
                            
                            self.flavourName.add(dict.value(forKey: "description")!)
                            self.vendorName.add(dict.value(forKey: "vendor_name")!)
                            self.legacyArr.add(dict.value(forKey: "legecy")!)
                            self.countryArr.add(dict.value(forKey: "country")!)
                            self.amountArr.add(dict.value(forKey: "price")!)
                            self.vendorIDArr.add(dict.value(forKey: "vendor_id")!)
                            self.commodityIDArr.add(dict.value(forKey: "commodity_id")!)
                           // self.sourceTeamArr.add(dict.value(forKey: "mars_sourcing")!)
                            self.flavorIDArr.add(dict.value(forKey: "nut_id")!)
                           // self.productIDArr.add(dict.value(forKey: "product_id")!)
//                            self.categoryIDArr.add(dict.value(forKey: "category_id")!)
                            
                            
                        }
                    }else{
                        DispatchQueue.main.async {
                            
                            self.noVendorScreen.isHidden = false
                        }
                    }
                  //  print(self.flavourName)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                }
                
                
                
                
            } catch {
                
                let alert = UIAlertController(title: "Error", message: "No Vendor found", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("YES")
                        self.navigationController?.popViewController(animated: true)
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                        
                        
                    }}))
                
                self.present(alert, animated: true, completion: nil)
                
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating();
                    
                }
                print("error")
            }
        })
        
        task.resume()
        
        
        // print(postString)
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.change(textFont: UIFont.systemFont(ofSize: 12))
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        self.appDelegate.vendorFlavorTagArr.removeAllObjects()
        self.appDelegate.selectedVendorLegacyNameListArr.removeAllObjects()
        self.appDelegate.selectedVendorCountryNameListArr.removeAllObjects()
        
       /*
         UserDefaults.standard.setValue(self.appDelegate.selectedFlavorIDForVendor, forKey: "vendorNutsSelectedFlavourIDs")
         UserDefaults.standard.setValue(self.appDelegate.selectedVendorlegacyIDList, forKey: "vendorNutsSelectedLegacyIDList")
         UserDefaults.standard.setValue(self.appDelegate.selectedVendorCountryIDList, forKey: "vendorNutsSelectedCountryIDList")
         UserDefaults.standard.setValue(self.appDelegate.selectedVendorCatIdListArr, forKey: "selectedVendorNutsCatIdList")
*/
       
        self.appDelegate.selectedFlavorIDForVendor.removeAllObjects()
        self.appDelegate.selectedVendorlegacyIDList.removeAllObjects()
        self.appDelegate.selectedVendorCountryIDList.removeAllObjects()
        self.appDelegate.selectedVendorCatIdListArr.removeAllObjects()
        UserDefaults.standard.setValue(self.appDelegate.selectedFlavorIDForVendor, forKey: "vendorNutsSelectedFlavourIDs")
        UserDefaults.standard.setValue(self.appDelegate.selectedVendorlegacyIDList, forKey: "vendorNutsSelectedLegacyIDList")
        UserDefaults.standard.setValue(self.appDelegate.selectedVendorCountryIDList, forKey: "vendorNutsSelectedCountryIDList")
        
        
        UserDefaults.standard.setValue(self.appDelegate.selectedVendorCatIdListArr, forKey: "selectedNutsCatIdList")
        
        
        /*
         
         if userdefaults.array(forKey: "vendorSelectedLegacyIDList") != nil{
         
         selectedListIDArr = userdefaults.array(forKey: "vendorSelectedLegacyIDList")! as NSArray
         
         }
         
         if userdefaults.array(forKey: "vendorSelectedCountryIDList") != nil{
         
         selectedCountryArr = userdefaults.array(forKey: "vendorSelectedCountryIDList")! as NSArray
         
         }
         
         
         
         
         if userdefaults.array(forKey: "vendorSelectedFlavourIDs") != nil{
         selectedFlavourArr = userdefaults.array(forKey: "vendorSelectedFlavourIDs")! as NSArray
         }
         */
        
        
        
        doneBtn.isEnabled = false
        doneBtn.backgroundColor = UIColor.lightGray
        self.searchBar.clipsToBounds = true
        searchBar.delegate = self
        
        searchBar.frame.size.height = 30
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = UIColor.lightGray
       
        view.backgroundColor = UIColor.white
        self.tableView.registerCellNib(VendorTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
       // let params = ["search":"","page":"","per_page":"","flavour_id":"","country_id":"","legecy_id":"",] as Dictionary<String, String>
        
        
        // let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        
        
        
        
        
        //getProfile()
    }
    
    func  getProfile() -> Void {
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
                    print("error")
                }
            })
            
            task.resume()
        }
        
        
        
    }
    
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //navigationController?.popViewController(animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        getVendorsList()
        
        // doneBtn.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
        
        // doneBtn.layer.cornerRadius = 15
        self.navigationItem.setHidesBackButton(true, animated:true);
        //  navigationController?.navigationBar.barTintColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 0.5)
        // navigationController?.navigationBar.backgroundColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 1.0)
        //self.setNavigationBarItemWithBackButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  79.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // selectedIndexForCategory = indexPath.row
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let subContentsVC = storyboard.instantiateViewController(withIdentifier: "VendorDetailViewController") as! VendorDetailViewController
        subContentsVC.productId = self.flavorIDArr[indexPath.row] as! String
//        subContentsVC.flavourName = (self.flavourName.object(at: indexPath.row) as! String)
        subContentsVC.isComingFrom = "NutsVendorPage"
        
        self.navigationController?.pushViewController(subContentsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vendorName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "VendorTableViewCell") as! VendorTableViewCell
        cell.delegate = self
        cell.selectionStyle = .none;
        
        /*
         self.vendorName.add(dict.value(forKey: "vendor_name")!)
         self.legacyArr.add(dict.value(forKey: "legecy")!)
         self.countryArr.add(dict.value(forKey: "country")!)
         self.amountArr.add(dict.value(forKey: "price")!)
         self.vendorIDArr.add(dict.value(forKey: "vendor_id")!)
         // self.sourceTeamArr.add(dict.value(forKey: "mars_sourcing")!)
         self.flavorIDArr.add(dict.value(forKey: "nut_id")!)
 */
        cell.flavorHeaderLabel.text = "NUTS"
        cell.amountLabel.text = "$" + (self.amountArr.object(at: indexPath.row) as! String)
        cell.countryDataLabel.text = (self.countryArr.object(at: indexPath.row) as! String)
        cell.legacyDataLabel.text = (self.legacyArr.object(at: indexPath.row) as! String)
        cell.flavorDataLabel.text = (self.flavourName.object(at: indexPath.row) as! String)
        cell.VendorNameLabel.text = (self.vendorName.object(at: indexPath.row) as! String)
        
        cell.vendorImageLabel.text = (self.vendorName.object(at: indexPath.row) as! String).characters.first?.description ?? ""
        cell.checkbuttonAction.tag = indexPath.row
        if !radioBtnsArr.contains(cell.checkbuttonAction) {
            radioBtnsArr.add(cell.checkbuttonAction)
        }
        
        
        // cell.vendorImage.isHidden = true
        // let data = DataTableViewCellData(imageUrl: "dummy", text: self.flavourName[indexPath.row] as! String)
        // cell.setData(data)
        return cell
    }
    
}
