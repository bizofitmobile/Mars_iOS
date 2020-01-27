//
//  AppDelegate.swift
//  Mars
//
//  Created by Arpit Lokwani on 19/08/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var flavourTagArr = NSMutableArray()
    var vendorFlavorTagArr = NSMutableArray()
    var nutsTagArr = NSMutableArray()
    
    var countryNameTagArr = NSMutableArray()
    var selectedCountryIDListArr = NSMutableArray()
    var selectedCountryNameListArr = NSMutableArray()
    var selectedVendorCountryNameListArr = NSMutableArray()
    var selectedNutsCountryNameListArr = NSMutableArray()

    var selectedLegacyIDList = NSMutableArray()
    var selectedVendorlegacyIDList = NSMutableArray()
    
    var selectedLegacyNameListArr = NSMutableArray()
    var selectedVendorLegacyNameListArr = NSMutableArray()
    var selectedNutsLegacyNameListArr = NSMutableArray()
    
    var selectedCatIdListArr = NSMutableArray()
    var selectedVendorCatIdListArr = NSMutableArray()
    var selectedNutsLegacyIDList = NSMutableArray()

    var isAllCountryBtnSelected = false
    var isAllVendorCountryBtnSelected = false
    
    
    var selectedFlavorList = NSMutableArray()
    var selectedVendorFlavorList = NSMutableArray()
    
    var selectedCountryIDList = NSMutableArray()
    var selectedVendorCountryIDList = NSMutableArray()
    var selectedNutsCountryIDList = NSMutableArray()
    var selectedFlavorIDForVendor = NSMutableArray()

    //nuts
     var selectedNutsDescList = NSMutableArray()
     var selectedNutIDListArr = NSMutableArray()
    func onHanselSynced(_ state:Bool) {
        
        print(state)
        /* Every time the updated values are synced to the SDK,
         this listener is triggered.
         You can use this to confirm that a sync has taken place,
         and run additional tasks you may have after every sync.
         */
        
    }
    fileprivate func createMenuView() {

        // create viewController code...
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
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UserDefaults.standard.set("NO", forKey: "isFilterLaunched")
        //EN04998L50L9TWLCFHH5BDMKZ
        //0QSJU7M1H1SM19IWTBDY2CX5FVLYUW6LU4TSQE50HL3C0KNVYP - app key
        Hansel.initializeSDK("EN04998L50L9TWLCFHH5BDMKZ", "0QSJU7M1H1SM19IWTBDY2CX5FVLYUW6LU4TSQE50HL3C0KNVYP")
//        let hanselSyncHandler = HanselSyncHandler();
//
//
//        //Register the instance with this line:
//        Hansel.setHanselSyncStateListener(hanselSyncHandler, forRequest:RequestType.Configs);
//        // Override point for customization after application launch.
       // self.createMenuView()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

