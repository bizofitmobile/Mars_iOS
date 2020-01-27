//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

enum LeftMenu: Int {
    case Home = 0
    case SendRFS
    case SearchNutsPantry
    case RFSSummary
    case Profile
    case SignOut
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Home", "Search Flavours Pantry","Search Nuts Pantry", "RFS Summary", "Profile", "Sign Out"]
    var menuImages = ["home","rfq_icon","nuts_icon","send_icon","profile_icon","logout"]
    var mainViewController: UIViewController!
    var swiftViewController: UIViewController!
    var javaViewController: UIViewController!
    var nutsFilterViewController:UIViewController!
    var goViewController: UIViewController!
    var viewController: UIViewController!
    
    
    var nonMenuViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    let nameLabel = UILabel()
    let designationLabel = UILabel()
    
    let cancelButton = UIButton()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @objc func methodOfReceivedNotification(notification: NSNotification) {
        // Take Action on Notification
        print("methodOfReceivedNotification")
        if let name = UserDefaults.standard.string(forKey: "fname") {
            if let fname = UserDefaults.standard.string(forKey: "lname") {
                print(name)
                DispatchQueue.main.async {
                    self.nameLabel.text = name + " " + fname

                }
                
            }else{
                DispatchQueue.main.async {
                    self.nameLabel.text = name
                }
            }
            
        }
        if let name = UserDefaults.standard.string(forKey: "lname") {
            print(name)
        }
        if let name = UserDefaults.standard.string(forKey: "picture_url") {
            print(name)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(methodOfReceivedNotification(notification:)), name:NSNotification.Name(rawValue: "updateName"), object: nil)

        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        self.tableView.backgroundColor = UIColor.white
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let swiftViewController = storyboard.instantiateViewController(withIdentifier: "SwiftViewController") as! SwiftViewController
        self.swiftViewController = UINavigationController(rootViewController: swiftViewController)
        
        let javaViewController = storyboard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        javaViewController.isComingFrom = "LeftView"
        self.javaViewController = UINavigationController(rootViewController: javaViewController)
        
        let nutsFilterViewControler =
            storyboard.instantiateViewController(withIdentifier: "NutsFilterViewController") as! NutsFilterViewController
        nutsFilterViewControler.isComingFrom = "LeftView"
        self.nutsFilterViewController = UINavigationController(rootViewController: nutsFilterViewControler)
        
        let goViewController = storyboard.instantiateViewController(withIdentifier: "GoViewController") as! GoViewController
        goViewController.delegate = self

        self.goViewController = UINavigationController(rootViewController: goViewController)
        
        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
        nonMenuController.delegate = self
        self.nonMenuViewController = UINavigationController(rootViewController: nonMenuController)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        self.viewController = UINavigationController(rootViewController: viewController)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        
       
        
      //  nameLabel.text = "Arpit Lokwani "
        nameLabel.textColor = UIColor.white
        designationLabel.text = "MARS"
        designationLabel.textColor = UIColor.white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        designationLabel.font = UIFont.systemFont(ofSize: 18.0)
        

       // nameLabel.backgroundColor = UIColor.black
        self.imageHeaderView.addSubview(nameLabel)
        self.view.addSubview(self.imageHeaderView)
        self.view.addSubview(self.cancelButton)
        self.view.addSubview(self.designationLabel)

        
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        cancelButton.setBackgroundImage(UIImage(named: "close_icon"), for:.normal )
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        nameLabel.frame = CGRect(x: self.view.frame.width/2-40, y: self.imageHeaderView.frame.height/2, width: self.view.frame.width, height: 30)
        designationLabel.frame = CGRect(x: self.view.frame.width/2-40, y: self.imageHeaderView.frame.height/2+40, width: self.view.frame.width, height: 30)

        
        cancelButton.frame = CGRect(x: self.view.frame.width-40, y: 40, width: 20, height: 20)
        

        self.view.layoutIfNeeded()
    }
    
    @objc func cancelButtonPressed() -> Void{
        print("cancelButtonPressed")
        slideMenuController()?.closeLeft()
    }
    
    func changeViewController(_ menu: LeftMenu) {
      
       
        switch menu {
        case .Home:
        
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .SendRFS:
            self.slideMenuController()?.changeMainViewController(self.javaViewController, close: true)
            
        case .SearchNutsPantry:
            self.slideMenuController()?.changeMainViewController(self.nutsFilterViewController, close: true)
            
        case .RFSSummary:
           self.slideMenuController()?.changeMainViewController(self.swiftViewController, close: true)
        case .Profile:
            self.slideMenuController()?.changeMainViewController(self.goViewController, close: true)
       
        case .SignOut:
            let alert = UIAlertController(title: "Error", message: "Are you sure want to sign out?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("YES")
                    self.slideMenuController()?.changeMainViewController(self.viewController, close: true)
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            
            alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("NO")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func showAlertAction() -> Void {
        
    }
    
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .Home, .SendRFS,.SearchNutsPantry, .RFSSummary, .Profile, .SignOut:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .Home, .SendRFS,.SearchNutsPantry, .RFSSummary, .Profile, .SignOut:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.imageView?.image = UIImage(named: menuImages[indexPath.row] as String)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
