//
//  FilterViewController.swift
//  Mars
//
//  Created by Arpit Lokwani on 24/08/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit
import EasyTipView
class FilterViewController: UIViewController,TagListViewDelegate,EasyTipViewDelegate {
    func easyTipViewDidDismiss(_ tipView: EasyTipView) {
        
    }
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var ApplyButton: UIButton!
    @IBOutlet weak var tagListView: TagListView!
    var countryListDataArr = NSMutableArray()
    var flavorListDataArr = NSMutableArray()
    var flavorCatIdArr = NSMutableArray()
    var legacyListDataArr = NSMutableArray()
    var catiddictionary = NSMutableDictionary()
    var legacyIDArr = NSMutableArray()
    var countryIDArr = NSMutableArray()
    var legacyDict = [String:String]()
    var countryDict = [String:String]()
    var isComingFrom = ""
    var filterPreviousScreen = ""
    var flavourTagArr = NSMutableArray()
   // var selectedFlavorList = NSMutableArray()
    //var selectedLegacyIDList = NSMutableArray()
    //var selectedCountryIDList = NSMutableArray()
    
    var isAllCountrySelected = false
    var appDelegate = AppDelegate()
    
    @IBOutlet weak var checkButtonWithFilter: UIButton!
    
    
    
    @IBAction func applyNowBtnPressed(_ sender: Any) {
        
        if( self.appDelegate.selectedLegacyIDList.count == 0 &&
            self.appDelegate.selectedFlavorList.count == 0 &&
            self.appDelegate.selectedCountryIDList.count == 0){
            self.appDelegate.flavourTagArr.removeAllObjects()
            self.appDelegate.flavourTagArr.removeAllObjects()
        }
        
        
        
        if filterPreviousScreen == "Vendor" {
            navigationController?.popViewController(animated: true)
        }else{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "RightViewController") as! RightViewController
            
            let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
            
            UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
            
            leftViewController.mainViewController = nvc
            
            let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
            slideMenuController.automaticallyAdjustsScrollViewInsets = true
            slideMenuController.delegate = mainViewController
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
            UserDefaults.standard.setValue(self.appDelegate.selectedFlavorList, forKey: "selectedFlavourIDs")
            UserDefaults.standard.setValue(self.appDelegate.selectedLegacyIDList, forKey: "selectedLegacyIDList")
            UserDefaults.standard.setValue(self.appDelegate.selectedCountryIDList, forKey: "selectedCountryIDList")
            UserDefaults.standard.setValue(isAllCountrySelected, forKey: "isAllCountrySelected")
            
             UserDefaults.standard.setValue(self.appDelegate.selectedCatIdListArr, forKey: "selectedCatIdList")
            
            
            // vc?.selectedFlavourIDs =  selectedFlavorList
            self.navigationController?.pushViewController(vc!, animated: true)
            self.view.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
            self.view.window?.rootViewController = slideMenuController
        }
        
        navigationController?.navigationBar.isHidden = true
        
        
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
           self.appDelegate.isAllCountryBtnSelected = false
           UserDefaults.standard.setValue(self.appDelegate.isAllCountryBtnSelected, forKey: "isAllCountryBtnSelected")
            sender.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)
        }else{
            sender.isSelected = !sender.isSelected
            isAllCountrySelected = true
            self.appDelegate.isAllCountryBtnSelected = true
            UserDefaults.standard.setValue(self.appDelegate.isAllCountryBtnSelected, forKey: "isAllCountryBtnSelected")
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
    @objc func performAction() {
        //This function will perform after 2 seconds
       
       // HanselWrapper.logEvent(eventName: "Home_page_opened", properties: [:])
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
}
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
    UserDefaults.standard.setValue(self.appDelegate.isAllCountryBtnSelected, forKey: "isAllCountryBtnSelected")
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: "Futura-Medium", size: 13)!
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        if let isLaunched = UserDefaults.standard.string(forKey: "isFilterPageLaunched") {
            if (isLaunched == "YES"){
                // do nothing
            }else{
                UserDefaults.standard.set("YES", forKey: "isFilterPageLaunched")
            }
        }else{
            UserDefaults.standard.set("YES", forKey: "isFilterPageLaunched")
          //  EasyTipView.show(forView: tagListView,
//                             withinSuperview: self.navigationController?.view,
//                             text: "Apply filters to start your search for flavors and vendors. Click on Apply Now after selecting the filters",
//                             preferences: preferences,
//                             delegate: self)
        }
        
        // let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        checkButtonWithFilter.layer.borderWidth = 1
        checkButtonWithFilter.layer.borderColor = UIColor.lightGray.cgColor
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        
        let defaults = UserDefaults.standard

        
        if !defaults.bool(forKey: "isAllCountryBtnSelected") {
             checkButtonWithFilter.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)
            checkButtonWithFilter.isSelected =  false
        } else {
             checkButtonWithFilter.setBackgroundImage(UIImage(named: "check_box_fill"), for: .normal)
            checkButtonWithFilter.isSelected =  true

        }
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        // present(alert, animated: true, completion: nil)
        
        navigationController?.navigationBar.isHidden = true
        ApplyButton.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
        ApplyButton.layer.cornerRadius = 15
        
        
        let request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getFilterFlavourValues")!)
        
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
                let countryListArr:NSArray = dataDict.value(forKey: "country_list") as! NSArray
                let flavorListArr:NSArray = dataDict.value(forKey: "flavour_category_list") as! NSArray
                let legacyListArr:NSArray = dataDict.value(forKey: "legecy_list") as! NSArray
                
                print(countryListArr)
                print(flavorListArr)
                print(legacyListArr)
                
                
                if (flavorListArr.count>10){
                    for i in 0...9{
                        let dict:NSDictionary = flavorListArr.object(at: i) as! NSDictionary
                        self.flavorListDataArr.add(dict.value(forKey: "name")!)
                        self.flavorCatIdArr.add(dict.value(forKey: "category_id")!)
                        print(dict.value(forKey: "category_id")!)
                        print(dict.value(forKey: "name")!)
                        self.catiddictionary.setValue(dict.value(forKey: "category_id")!, forKey:dict.value(forKey: "name")! as! String )
                        print(self.catiddictionary)
                    }
                }else{
                    for i in 0...flavorListArr.count-1{
                        let dict:NSDictionary = flavorListArr.object(at: i) as! NSDictionary
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
                    tagView1.setTitle("Flavors                                                                                                                                  ", for: .normal)
                    tagView1.tagBackgroundColor = UIColor.white
                    tagView1.frame = CGRect(x: -10, y: tagView1.frame.origin.y, width: tagView1.frame.size.width, height: tagView1.frame.size.height)
                    tagView1.borderColor = UIColor.white
                    tagView1.textColor = UIColor.black
                    tagView1.isUserInteractionEnabled = false
                    self.tagListView.delegate = self
                  
                    
                }
                
                
                for i in 0...self.flavorListDataArr.count-1{
                    DispatchQueue.main.async {
                        let tagView1 = self.tagListView.addTag(self.flavorListDataArr.object(at: i) as! String)
                        
                        if(self.appDelegate.flavourTagArr.contains(self.flavorListDataArr.object(at: i) as! String)){
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
                    //                    DispatchQueue.main.async {
                    //
                    //                        self.tagListView.addTag(self.countryListDataArr.object(at: i) as! String)
                    //
                    //                    }
                    
                    DispatchQueue.main.async {
                        let tagView1 = self.tagListView.addTag(self.countryListDataArr.object(at: i) as! String)
                        
                        if(self.appDelegate.selectedCountryNameListArr.contains(self.countryListDataArr.object(at: i) as! String)){
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
//                    DispatchQueue.main.async {
//
//                        self.tagListView.addTag(self.legacyListDataArr.object(at: i) as! String)
//
//                    }
                    
                    DispatchQueue.main.async {
                        let tagView1 = self.tagListView.addTag(self.legacyListDataArr.object(at: i) as! String)
                        if(self.appDelegate.selectedLegacyNameListArr.contains(self.legacyListDataArr.object(at: i) as! String)){
                            tagView1.backgroundColor = UIColor(red: 0/255.0, green: 202/255.0, blue: 173/255.0, alpha: 1.0)
                            tagView1.tintColor = UIColor.white
                            tagView1.isSelected = true
                            

                            
                        }
                        
                        
                     
                    }
                   
                }
             //  HanselWrapper.logEvent(eventName: "filter_page_opened", properties: [:])
                
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
            
            if(self.appDelegate.selectedFlavorList.count>0){
                if(flavorListDataArr.contains(tagView.titleLabel!.text!)){
                    self.appDelegate.selectedFlavorList.remove(tagView.titleLabel!.text!)
                    self.appDelegate.flavourTagArr.remove(tagView.titleLabel!.text!)
                    let id = self.catiddictionary.value(forKey: tagView.titleLabel!.text!)
                    self.appDelegate.selectedCatIdListArr.remove(id)
                }
            }
            
            
            if(self.appDelegate.selectedLegacyIDList.count>0){
                if(legacyListDataArr.contains(tagView.titleLabel!.text!)){
                    let idVal = legacyDict[tagView.titleLabel!.text!]
                    print(idVal!)
                    self.appDelegate.selectedLegacyIDList.remove(idVal!)
                self.appDelegate.selectedLegacyNameListArr.remove(tagView.titleLabel!.text!)
                }
            }
            if(self.appDelegate.selectedCountryIDList.count>0){
                if(countryListDataArr.contains(tagView.titleLabel!.text!)){
                    let idVal = countryDict[tagView.titleLabel!.text!]
                    print(idVal!)
                    self.appDelegate.selectedCountryIDList.remove(idVal!)
                    self.appDelegate.selectedCountryNameListArr.remove(tagView.titleLabel!.text!)
                    //self.appDelegate.countryNameTagArr.remove(tagView.titleLabel!.text!)
                }
            }
            
            
            
        }else{
            // selectedFlavorList.add(tagView.titleLabel?.text ?? "")
            tagView.isSelected = !tagView.isSelected
            
            if(legacyListDataArr.contains(tagView.titleLabel!.text!)){
                let idVal = legacyDict[tagView.titleLabel!.text!]
                print(idVal!)
                self.appDelegate.selectedLegacyIDList.add(idVal!)
                self.appDelegate.selectedLegacyNameListArr.add(tagView.titleLabel!.text!)

            }
            
            if(flavorListDataArr.contains(tagView.titleLabel!.text!)){
                
                self.appDelegate.selectedFlavorList.add(tagView.titleLabel!.text!)
                self.appDelegate.flavourTagArr.add(tagView.titleLabel!.text!)
            
                let value:String = self.catiddictionary.value(forKey: tagView.titleLabel!.text!) as! String
                self.appDelegate.selectedCatIdListArr.add (value)
            }
            
            if(countryListDataArr.contains(tagView.titleLabel!.text!)){
                let idVal = countryDict[tagView.titleLabel!.text!]
                print(idVal!)
               self.appDelegate.selectedCountryIDList.add(idVal!)
                self.appDelegate.selectedCountryNameListArr.add(tagView.titleLabel!.text!)
                
            }
            
            
            
        }
        
        print(self.appDelegate.selectedFlavorList)
        
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
       
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}
