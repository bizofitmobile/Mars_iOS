//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.

// Home page with flavour Pantry page

import UIKit

import EasyTipView

class MainViewController: UIViewController,UISearchBarDelegate,DataCellDelegate {
    func didPressedPDFBtn(button: UIButton) {
        //do nothing
    }
    
    
    
    @IBOutlet weak var restartSearchBtn: UIButton!
    
    @IBAction func clickHereBtnPressed(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QuestionsViewController") as? QuestionsViewController
        
        navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func restartHereBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController
        
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
    func didPressedVendorButton(button: UIButton) {
 
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "VendorViewController") as? VendorViewController
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
    
    var checkBoxButtonArr = NSMutableArray()
    @IBAction func doneBtnPressed(_ sender: Any) {
        print("doneBtnPressed")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let swiftViewController = storyboard.instantiateViewController(withIdentifier: "VendorViewController") as! VendorViewController
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
    
    
    @IBOutlet weak var selectAllBtn: UIButton!
    
    
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
        
        
        if userdefaults.array(forKey: "selectedLegacyIDList") != nil{
            
            selectedListIDArr = userdefaults.array(forKey: "selectedLegacyIDList")! as NSArray
            
        }
        
        if userdefaults.array(forKey: "selectedCountryIDList") != nil{
            
            selectedCountryArr = userdefaults.array(forKey: "selectedCountryIDList")! as NSArray
            
        }
        
        
        
        
        if userdefaults.array(forKey: "selectedCatIdList") != nil{
            selectedFlavourArr = userdefaults.array(forKey: "selectedCatIdList")! as NSArray
        }
        if userdefaults.bool(forKey: "isAllCountrySelected") != nil{
            isAllCountryCheckBoxSelected = userdefaults.bool(forKey: "isAllCountrySelected")
            if isAllCountryCheckBoxSelected == false{
                isAllCountryCheckBoxSelectedValue = "0"
            }else{
                isAllCountryCheckBoxSelectedValue = "1"
            }
        }
        
        
        let params = [
            "category_id": selectedFlavourArr,
            "legecy_id":selectedListIDArr,
            "country_id":selectedCountryArr,
            "is_allowed_country":isAllCountryCheckBoxSelectedValue,
            "search":value
            
            ] as [String : Any]
        
        
        
        //let postString = "search=\(value)"

        var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getFlavoursList")!)
        request.httpMethod = "POST"
        let jsonData: Data? = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
           // print(response!)
            
            if(error != nil){
                DispatchQueue.main.async {
                   // self.noFlavorView.isHidden = false

                    loadingIndicator.stopAnimating();
                    
                }
            }else{
                DispatchQueue.main.async {
                    //self.noFlavorView.isHidden = true
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
               
                if(dataArr.count>0){
                    
                    DispatchQueue.main.async {
                      //  self.noFlavorView.isHidden = true

                    }
                    self.flavourName = NSMutableArray()
                    self.descriptionArr = NSMutableArray()
                    self.flavour_ID = NSMutableArray()
                    self.legacyNameArr = NSMutableArray()
                    self.plantDescArr = NSMutableArray()
                    self.country_ID = NSMutableArray()
                    self.legacy_ID = NSMutableArray()
                    
                    
                for i in 0...dataArr.count-1{
                    let dict: NSDictionary = dataArr.object(at: i) as! NSDictionary
                    print(dict.value(forKey: "flavour_id")!)
                    print(dict.value(forKey: "country_id")!)
                    print(dict.value(forKey: "legecy_id")!)
                    print(dict.value(forKey: "country_legecy")!)
                    
                    print(dict.value(forKey: "description")!)
                    print(dict.value(forKey: "name")!)
                    self.flavour_ID.add(dict.value(forKey: "flavour_id")!)
                    self.country_ID.add(dict.value(forKey: "country_id")!)
                    self.legacy_ID.add(dict.value(forKey: "legecy_id")!)
                    self.legacyNameArr.add(dict.value(forKey: "country_legecy")!)
                    self.descriptionArr.add(dict.value(forKey: "description")!)
                    self.flavourName.add(dict.value(forKey: "name")!)
                    self.plantDescArr.add(dict.value(forKey: "plant_name")!)
                    
                }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                }else{
                    DispatchQueue.main.async {
                     //   self.noFlavorView.isHidden = false
                        
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
    



    
    var mainContens = ["data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10", "data11", "data12", "data13", "data14", "data15"]
   
    override open func viewDidAppear(_ animated: Bool) {
        // HanselWrapper.logEvent(eventName: "Home_page_opened", properties: [:])

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.noFlavorView.isHidden = true
        
        var lineView = UIView(frame: CGRect(x:-5,y:restartSearchBtn.frame.size.height+1,width: restartSearchBtn.frame.size.width+10,height:1))
        lineView.backgroundColor=UIColor.lightGray
        restartSearchBtn.addSubview(lineView)
        addDoneButtonOnKeyboard()
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

        
        let userdefaults = UserDefaults.standard
//        var postString = ""
//        postString = "flavour_name" + "="
        
        
        if userdefaults.array(forKey: "selectedLegacyIDList") != nil{
            
            selectedListIDArr = userdefaults.array(forKey: "selectedLegacyIDList")! as NSArray
            
        }
        
        if userdefaults.array(forKey: "selectedCountryIDList") != nil{
            
            selectedCountryArr = userdefaults.array(forKey: "selectedCountryIDList")! as NSArray
            
        }
        
        
        
        
        if userdefaults.array(forKey: "selectedCatIdList") != nil{
            selectedFlavourArr = userdefaults.array(forKey: "selectedCatIdList")! as NSArray
        }
        if userdefaults.bool(forKey: "isAllCountrySelected") != nil{
            isAllCountryCheckBoxSelected = userdefaults.bool(forKey: "isAllCountrySelected")
            if isAllCountryCheckBoxSelected == false{
                isAllCountryCheckBoxSelectedValue = "0"
            }else{
                isAllCountryCheckBoxSelectedValue = "1"
            }
        }
        
        
        let parameters = [
            "category_id": selectedFlavourArr,
            "legecy_id":selectedListIDArr,
            "country_id":selectedCountryArr,
            "is_allowed_country":isAllCountryCheckBoxSelectedValue
            
            ] as [String : Any]
       
        
        
        
        var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getFlavoursList")!)
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
                if(data != nil){
                let responseString = String(data: data!, encoding: .utf8)
                
                
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
                let jsonDict:NSDictionary = json as NSDictionary
                print(jsonDict.value(forKey: "data") as Any)
                
                let dataArr:NSArray = jsonDict.value(forKey: "data")  as! NSArray
                if(dataArr.count>0){
                    DispatchQueue.main.async {
                        self.noFlavorView.isHidden = true

                    }
                    for i in 0...dataArr.count-1{
                        let dict: NSDictionary = dataArr.object(at: i) as! NSDictionary
                        print(dict.value(forKey: "flavour_id")!)
                        print(dict.value(forKey: "country_id")!)
                        print(dict.value(forKey: "legecy_id")!)
                        print(dict.value(forKey: "country_legecy")!)
                        
                        print(dict.value(forKey: "description")!)
                        print(dict.value(forKey: "name")!)
                        self.flavour_ID.add(dict.value(forKey: "flavour_id")!)
                        self.country_ID.add(dict.value(forKey: "country_id")!)
                        self.legacy_ID.add(dict.value(forKey: "legecy_id")!)
                        self.legacyNameArr.add(dict.value(forKey: "country_legecy")!)
                        self.plantDescArr.add(dict.value(forKey: "plant_name")!)
                        self.descriptionArr.add(dict.value(forKey: "description")!)
                        self.flavourName.add(dict.value(forKey: "name")!)
                        
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
                    HanselWrapper.logEvent(eventName: "Home_page_opened", properties: [:])
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
        
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: "Futura-Medium", size: 13)!
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.bottom
     
       
        
        if let isLaunched = UserDefaults.standard.string(forKey: "isFlavorPageLaunched") {
            if (isLaunched == "YES"){
                // do nothing
            }else{
                UserDefaults.standard.set("YES", forKey: "isFlavorPageLaunched")
            }
        }else{
            UserDefaults.standard.set("YES", forKey: "isFlavorPageLaunched")
//            EasyTipView.show(forView: searchBar,
//                             withinSuperview: self.navigationController?.view,
//                             text: "Select any one or more flavors to find the relevant vendor on next screen. Click on Done once you have selected the flavors ",
//                             preferences: preferences,
//                             delegate: nil)
        }
        
        
    }
    
    func reset()  {
        
        self.appDelegate.selectedFlavorList.removeAllObjects()
        self.appDelegate.selectedLegacyIDList.removeAllObjects()
        self.appDelegate.selectedLegacyNameListArr.removeAllObjects()
        self.appDelegate.selectedCountryIDList.removeAllObjects()
        self.appDelegate.selectedCountryNameListArr.removeAllObjects()
        self.appDelegate.selectedCountryIDList.removeAllObjects()
        self.appDelegate.selectedCatIdListArr.removeAllObjects()
        self.flavourName = NSMutableArray()
        self.descriptionArr = NSMutableArray()
        self.flavour_ID = NSMutableArray()
        self.legacyNameArr = NSMutableArray()
        self.plantDescArr = NSMutableArray()
        self.country_ID = NSMutableArray()
        self.legacy_ID = NSMutableArray()
        self.appDelegate.flavourTagArr.removeAllObjects()
        
        
        UserDefaults.standard.setValue(self.appDelegate.selectedFlavorList, forKey: "selectedFlavourIDs")
        UserDefaults.standard.setValue(self.appDelegate.selectedLegacyIDList, forKey: "selectedLegacyIDList")
        UserDefaults.standard.setValue(self.appDelegate.selectedCountryIDList, forKey: "selectedCountryIDList")
            UserDefaults.standard.setValue(false, forKey: "isAllCountrySelected")
        UserDefaults.standard.setValue(self.appDelegate.selectedCatIdListArr, forKey: "selectedCatIdList")
        
            self.appDelegate.isAllCountryBtnSelected = false
        UserDefaults.standard.setValue(self.appDelegate.isAllCountryBtnSelected, forKey: "isAllCountryBtnSelected")

        selectedRows.removeAll()
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        let parameters = [
            "flavour_name": "",
            "legecy_id":"",
            "country_id":"",
            "is_allowed_country":"0"
            
            ]
        
        
        
        
        var request = URLRequest(url: URL(string: "http://mars.bizofit.com/api/v1/user/getFlavoursList")!)
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
                        print(dict.value(forKey: "flavour_id")!)
                        print(dict.value(forKey: "country_id")!)
                        print(dict.value(forKey: "legecy_id")!)
                        print(dict.value(forKey: "country_legecy")!)
                        
                        print(dict.value(forKey: "description")!)
                        print(dict.value(forKey: "name")!)
                        self.flavour_ID.add(dict.value(forKey: "flavour_id")!)
                        self.country_ID.add(dict.value(forKey: "country_id")!)
                        self.legacy_ID.add(dict.value(forKey: "legecy_id")!)
                        self.legacyNameArr.add(dict.value(forKey: "country_legecy")!)
                        self.plantDescArr.add(dict.value(forKey: "plant_name")!)

                        self.descriptionArr.add(dict.value(forKey: "description")!)
                        self.flavourName.add(dict.value(forKey: "name")!)
                        
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
    
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProfile()

        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 0.5)
         navigationController?.navigationBar.backgroundColor = UIColor(red: 31/255.0, green: 0/255.0, blue: 168/255.0, alpha: 1.0)
        self.setNavigationBarItem()
        
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
    }

}


extension MainViewController : UITableViewDelegate {
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

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flavourName.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: DataTableViewCell.identifier) as! DataTableViewCell
        cell.delegate = self
        if !checkBoxButtonArr.contains(cell.checkBtn) {
            checkBoxButtonArr.add(cell.checkBtn)

        }
        cell.vendorImage.tag = (indexPath.section * 1000) + indexPath.row
        cell.checkBtn.tag = (indexPath.section * 1000) + indexPath.row
       // cell.imageLabel.text = "C"
        cell.imageLabel.textAlignment = .center
        
//        for i in 0...flavour_ID.count-1{
//            let btn:UIButton = checkBoxButtonArr.object(at: i) as! UIButton
//            print("buttonTag = \(btn.tag)")
//            print("ivalue = \(i)")
//
//            if(btn.tag != i){
//                print("added")
//                checkBoxButtonArr.add(cell.checkBtn)
//            }
//            else{
//                checkBoxButtonArr.add(cell.checkBtn)
//
//            }
//        }
        
        print("indexpath = \(indexPath.row)")
        let text:String = "\(self.flavourName[indexPath.row] as! String)"  + "\n" + "\(self.legacyNameArr[indexPath.row] as! String)" + ",(Location: " + "\(self.plantDescArr[indexPath.row] as! String)" + ")"
       
        
        
        //buttonStateDictionary.setValue("unselected", forKey: "\(indexPath.row)")
        let data = DataTableViewCellData(imageUrl: "dummy", text: text)
        
        
        
        cell.setData(data)
    
        
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
}

extension MainViewController : SlideMenuControllerDelegate {
    
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
    
    
}
extension UISearchBar {
    
    func change(textFont : UIFont?) {
        
        for view : UIView in (self.subviews[0]).subviews {
            
            if let textField = view as? UITextField {
                textField.font = textFont
            }
        }
    } }
