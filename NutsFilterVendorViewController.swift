//
//  NutsFilterVendorViewController.swift
//  Mars
//
//  Created by Arpit Lokwani on 01/10/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit

class NutsFilterVendorViewController: UIViewController,TagListViewDelegate {
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var ApplyButton: UIButton!
    @IBOutlet weak var tagListView: TagListView!
    var appDelegate = AppDelegate()
    var countryListDataArr = NSMutableArray()
    var flavorListDataArr = NSMutableArray()
    var legacyListDataArr = NSMutableArray()
    var legacyIDArr = NSMutableArray()
    var countryIDArr = NSMutableArray()
    var legacyDict = [String:String]()
    var countryDict = [String:String]()
    var isComingFrom = ""
    var filterPreviousScreen = ""
    var catiddictionary = NSMutableDictionary()
    var selectedFlavorList = NSMutableArray()
    var selectedLegacyIDList = NSMutableArray()
    var selectedCountryIDList = NSMutableArray()
    var isAllCountrySelected = false
    
    
    @IBOutlet weak var checkButtonWithFilter: UIButton!
    
    @IBAction func applyNowBtnPressed(_ sender: Any) {
        if( self.appDelegate.selectedVendorlegacyIDList.count == 0 &&
            self.appDelegate.selectedVendorFlavorList.count == 0 ){
            self.appDelegate.vendorFlavorTagArr.removeAllObjects()
        }
        
        print(self.appDelegate.selectedVendorFlavorList)
        print(self.appDelegate.selectedVendorlegacyIDList)
        print(self.appDelegate.selectedVendorCountryIDList)
       /*
         UserDefaults.standard.setValue(self.appDelegate.selectedNutsDescList, forKey: "vendorNutsSelectedFlavourIDs")
         UserDefaults.standard.setValue(self.appDelegate.selectedNutsLegacyIDList, forKey: "vendorNutsSelectedLegacyIDList")
         UserDefaults.standard.setValue(self.appDelegate.selectedNutsCountryIDList, forKey: "vendorNutsSelectedCountryIDList")
         UserDefaults.standard.setValue(self.appDelegate.selectedNutIDListArr, forKey: "selectedNutsCatIdList")
*/ UserDefaults.standard.setValue(self.appDelegate.selectedFlavorIDForVendor, forKey: "vendorNutsSelectedFlavourIDs")
        UserDefaults.standard.setValue(self.appDelegate.selectedVendorlegacyIDList, forKey: "vendorNutsSelectedLegacyIDList")
        UserDefaults.standard.setValue(self.appDelegate.selectedVendorCountryIDList, forKey: "vendorNutsSelectedCountryIDList")
        UserDefaults.standard.setValue(self.appDelegate.selectedVendorCatIdListArr, forKey: "selectedNutsCatIdList")
     
        navigationController?.popViewController(animated: true)
        
        
        
        
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let swiftViewController = storyboard.instantiateViewController(withIdentifier: "VendorViewController") as! VendorViewController
        //        // swiftViewController.selectedFlavorName =
        //       swiftViewController.selectedFlavourID = appDelegate.selectedFlavorIDForVendor
        //        self.navigationController?.pushViewController(swiftViewController, animated: true)
        // navigationController?.navigationBar.isHidden = true
        
        
    }
    @IBAction func cancelBtnPressed(_ sender: Any) {
        if isComingFrom == "LeftView" {
            slideMenuController()?.toggleLeft()
            
        }else{
            navigationController?.popViewController(animated: true)
            
        }
        
    }
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        print("checkButtonWithFilterPressed")
        if sender.isSelected {
            sender.isSelected = !sender.isSelected
            isAllCountrySelected = false
            self.appDelegate.isAllVendorCountryBtnSelected = false
            UserDefaults.standard.setValue(self.appDelegate.isAllCountryBtnSelected, forKey: "isAllVendorCountryBtnSelected")
            sender.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)
        }else{
            sender.isSelected = !sender.isSelected
            isAllCountrySelected = true
            self.appDelegate.isAllVendorCountryBtnSelected = true
            UserDefaults.standard.setValue(self.appDelegate.isAllCountryBtnSelected, forKey: "isAllVendorCountryBtnSelected")
            sender.setBackgroundImage(UIImage(named: "check_box_fill"), for: .selected)
            
            
            
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if isComingFrom == "Login" {
            cancelBtn.isHidden = true
        }else{
            cancelBtn.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        UserDefaults.standard.setValue(self.appDelegate.isAllVendorCountryBtnSelected, forKey: "isAllVendorCountryBtnSelected")
        // let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        checkButtonWithFilter.layer.borderWidth = 1
        checkButtonWithFilter.layer.borderColor = UIColor.lightGray.cgColor
        let defaults = UserDefaults.standard
        
        
        if !defaults.bool(forKey: "isAllVendorCountryBtnSelected") {
            checkButtonWithFilter.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)
            checkButtonWithFilter.isSelected =  false
        } else {
            checkButtonWithFilter.setBackgroundImage(UIImage(named: "check_box_fill"), for: .normal)
            checkButtonWithFilter.isSelected =  true
            
        }
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        // present(alert, animated: true, completion: nil)
        
        navigationController?.navigationBar.isHidden = true
        ApplyButton.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
        ApplyButton.layer.cornerRadius = 15
        
        
        let request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getFilterNutsVendorValues")!)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            //print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating();
                    //alert.view.isHidden = true
                    
                }
                let jsonDict:NSDictionary = json as NSDictionary
                print(jsonDict.value(forKey: "data") as Any)
                
                let dataDict:NSDictionary = jsonDict.value(forKey: "data")  as! NSDictionary
                let nutsListArr:NSArray = dataDict.value(forKey: "nuts_category_list") as! NSArray
                let countryListArr:NSArray = dataDict.value(forKey: "country_list") as! NSArray
                let legacyListArr:NSArray = dataDict.value(forKey: "legecy_list") as! NSArray
                
                //print(nutsList)
               // print(countryList)
                //print(legacyListArr)
                
                if (nutsListArr.count>10){
                    for i in 0...9{
                        let dict:NSDictionary = nutsListArr.object(at: i) as! NSDictionary
                        self.flavorListDataArr.add(dict.value(forKey: "name")!)
                        print(dict.value(forKey: "category_id")!)
                        print(dict.value(forKey: "name")!)
                        self.catiddictionary.setValue(dict.value(forKey: "category_id")!, forKey:dict.value(forKey: "name")! as! String )
                        print(self.catiddictionary)
                    }
                }else{
                    for i in 0...nutsListArr.count-1{
                        let dict:NSDictionary = nutsListArr.object(at: i) as! NSDictionary
                        self.flavorListDataArr.add(dict.value(forKey: "name")!)
                        print(dict.value(forKey: "category_id")!)
                        print(dict.value(forKey: "name")!)
                        self.catiddictionary.setValue(dict.value(forKey: "category_id")!, forKey:dict.value(forKey: "name")! as! String )
                        print(self.catiddictionary)
                        
                    }
                }
                for i in 0...countryListArr.count-1{
                    let dict:NSDictionary = countryListArr.object(at: i) as! NSDictionary
                    self.countryListDataArr.add(dict.value(forKey: "name")!)
                    self.countryIDArr.add(dict.value(forKey: "country_id")!)
                    
                }
                
                for i in 0...legacyListArr.count-1{
                    let dict:NSDictionary = legacyListArr.object(at: i) as! NSDictionary
                    self.legacyListDataArr.add(dict.value(forKey: "name")!)
                    self.legacyIDArr.add(dict.value(forKey: "legecy_id")!)
                    
                    
                    
                    
                }
                
                for i in 0...legacyListArr.count-1{
                    self.legacyDict.updateValue("\(self.legacyIDArr.object(at: i))", forKey: "\(self.legacyListDataArr.object(at: i))")
                }
                
                for i in 0...countryListArr.count-1{
                    self.countryDict.updateValue("\(self.countryIDArr.object(at: i))", forKey: "\(self.countryListDataArr.object(at: i))")
                }
                
                
                
                DispatchQueue.main.async {
                    let tagView1 = self.tagListView.addTag("")
                    tagView1.setTitle("Nuts                                                                                                                                                                                      ", for: .normal)
                    
                    tagView1.tagBackgroundColor = UIColor.white
                    tagView1.frame = CGRect(x: -10, y: tagView1.frame.origin.y, width: tagView1.frame.size.width, height: tagView1.frame.size.height)
                    tagView1.borderColor = UIColor.white
                    tagView1.textColor = UIColor.black
                    tagView1.textFont = UIFont.systemFont(ofSize: 14.0)
                    tagView1.isUserInteractionEnabled = false
                    self.tagListView.delegate = self
                    
                }
                
                for i in 0...self.flavorListDataArr.count-1{
                    DispatchQueue.main.async {
                        let tagView1 = self.tagListView.addTag(self.flavorListDataArr.object(at: i) as! String)
                        //self.tagListView.addTag(self.flavorListDataArr.object(at: i) as! String)
                        if(self.appDelegate.vendorFlavorTagArr.contains(self.flavorListDataArr.object(at: i) as! String)){
                            tagView1.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
                            tagView1.tintColor = UIColor.white
                            tagView1.isSelected = true
                            
                        }
                        
                        
                    }
                    
                }
                DispatchQueue.main.async {
                    
                    let tagView41 = self.tagListView.addTag("")
                    tagView41.setTitle("                                                                                                                            ", for: .normal)
                    tagView41.textFont = UIFont.systemFont(ofSize: 15.0)
                    
                    tagView41.tagBackgroundColor = UIColor.white
                    tagView41.borderColor = UIColor.white
                    
                    tagView41.onTap = { tagView in
                        print("Don’t tap me!")
                    }
                    
                    tagView41.borderColor = UIColor.white
                    tagView41.textColor = UIColor.black
                    tagView41.isUserInteractionEnabled = false
                    
                    let tagView2 = self.self.tagListView.addTag("Country")
                    tagView2.setTitle("Country                                                                                            ", for: .normal)
                    tagView2.frame = CGRect(x: -10, y: tagView2.frame.origin.y, width: tagView2.frame.size.width, height: tagView2.frame.size.height)
                    
                    tagView2.borderColor = UIColor.white
                    tagView2.textColor = UIColor.black
                    tagView2.isUserInteractionEnabled = false
                }
                for i in 0...self.countryListDataArr.count-1{
                    DispatchQueue.main.async {
                        
                        //self.tagListView.addTag(self.countryListDataArr.object(at: i) as! String)
                        
                        let tagView1 = self.tagListView.addTag(self.countryListDataArr.object(at: i) as! String)
                        
                        if(self.appDelegate.selectedVendorCountryNameListArr.contains(self.countryListDataArr.object(at: i) as! String)){
                            tagView1.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
                            tagView1.tintColor = UIColor.white
                            tagView1.isSelected = true
                            
                        }
                        
                        
                        
                    }
                    
                }
                
                DispatchQueue.main.async {
                    let tagView4 = self.tagListView.addTag("")
                    tagView4.setTitle("                                                                                                                            ", for: .normal)
                    
                    tagView4.tagBackgroundColor = UIColor.white
                    tagView4.borderColor = UIColor.white
                    
                    tagView4.onTap = { tagView in
                        print("Don’t tap me!")
                    }
                    
                    tagView4.borderColor = UIColor.white
                    tagView4.textColor = UIColor.black
                    tagView4.isUserInteractionEnabled = false
                    
                    
                    
                    let tagView3 = self.tagListView.addTag("Legacy")
                    tagView3.setTitle("Legacy                                                                                                                            ", for: .normal)
                    
                    tagView3.frame = CGRect(x: -10, y: tagView3.frame.origin.y, width: tagView3.frame.size.width, height: tagView3.frame.size.height)
                    tagView3.tagBackgroundColor = UIColor.white
                    tagView3.onTap = { tagView in
                        print("Don’t tap me!")
                    }
                    
                    tagView3.borderColor = UIColor.white
                    tagView3.textColor = UIColor.black
                    tagView3.isUserInteractionEnabled = false
                }
                
                for i in 0...self.legacyListDataArr.count-1{
                    DispatchQueue.main.async {
                        
                        //self.tagListView.addTag(self.legacyListDataArr.object(at: i) as! String)
                        
                        let tagView1 = self.tagListView.addTag(self.legacyListDataArr.object(at: i) as! String)
                        if(self.appDelegate.selectedVendorLegacyNameListArr.contains(self.legacyListDataArr.object(at: i) as! String)){
                            tagView1.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
                            tagView1.tintColor = UIColor.white
                            tagView1.isSelected = true
                            
                        }
                        
                        
                    }
                }
            } catch {
                print("error")
            }
        })
        
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        if tagView.isSelected {
            //selectedFlavorList.remove(tagView.titleLabel?.text ?? "")
            tagView.isSelected = !tagView.isSelected
            
            if(appDelegate.selectedVendorFlavorList.count>0){
                if(flavorListDataArr.contains(tagView.titleLabel!.text!)){
                    selectedFlavorList.remove(tagView.titleLabel!.text!)
                    self.appDelegate.selectedVendorFlavorList.remove(tagView.titleLabel!.text!)
                    self.appDelegate.vendorFlavorTagArr.remove(tagView.titleLabel!.text!)
                    
                    let id = self.catiddictionary.value(forKey: tagView.titleLabel!.text!)
                    self.appDelegate.selectedVendorCatIdListArr.remove(id as Any)
                    
                }
            }
            
            
            if(self.appDelegate.selectedVendorlegacyIDList.count>0){
                if(legacyListDataArr.contains(tagView.titleLabel!.text!)){
                    selectedLegacyIDList.remove(tagView.titleLabel!.text!)
                    let idVal = legacyDict[tagView.titleLabel!.text!]
                    print(idVal!)
                    self.appDelegate.selectedVendorlegacyIDList.remove(idVal!)
                    
                    self.appDelegate.selectedVendorLegacyNameListArr.remove(tagView.titleLabel!.text!)
                    
                }
            }
            if(self.appDelegate.selectedVendorCountryIDList.count>0){
                if(countryListDataArr.contains(tagView.titleLabel!.text!)){
                    selectedCountryIDList.remove(tagView.titleLabel!.text!)
                    
                    let idVal = countryDict[tagView.titleLabel!.text!]
                    print(idVal!)
                    self.appDelegate.selectedVendorCountryIDList.remove(idVal!)
                    
                    self.appDelegate.selectedVendorCountryNameListArr.remove(tagView.titleLabel!.text!)
                }
            }
            
            
            
        }else{
            // selectedFlavorList.add(tagView.titleLabel?.text ?? "")
            tagView.isSelected = !tagView.isSelected
            
            if(legacyListDataArr.contains(tagView.titleLabel!.text!)){
                let idVal = legacyDict[tagView.titleLabel!.text!]
                print(idVal!)
                selectedLegacyIDList.add(idVal!)
                self.appDelegate.selectedVendorlegacyIDList.add(idVal!)
                self.appDelegate.selectedVendorLegacyNameListArr.add(tagView.titleLabel!.text!)
            }
            
            if(flavorListDataArr.contains(tagView.titleLabel!.text!)){
                
                //selectedFlavorList.add(tagView.titleLabel!.text!)
                let value:String = self.catiddictionary.value(forKey: tagView.titleLabel!.text!) as! String
                selectedFlavorList.add (value)
                self.appDelegate.selectedVendorFlavorList.add(tagView.titleLabel!.text!)
                self.appDelegate.vendorFlavorTagArr.add(tagView.titleLabel!.text!)
                
                let values:String = self.catiddictionary.value(forKey: tagView.titleLabel!.text!) as! String
                self.appDelegate.selectedVendorCatIdListArr.add (values)
                
            }
            
            if(countryListDataArr.contains(tagView.titleLabel!.text!)){
                let idVal = countryDict[tagView.titleLabel!.text!]
                print(idVal!)
                selectedCountryIDList.add(idVal!)
                print(idVal!)
                self.appDelegate.selectedVendorCountryIDList.add(idVal!)
                self.appDelegate.selectedVendorCountryNameListArr.add(tagView.titleLabel!.text!)
                
                
            }
            
            
            
        }
        
        print(selectedFlavorList)
        
        
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}
