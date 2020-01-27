//
//  RequestSampleViewController.swift
//  Mars
//
//  Created by Arpit Lokwani on 04/09/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit
import EasyTipView
class RequestSampleViewController: UIViewController {
    @IBAction func gotoHomeBtnAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBOutlet weak var goToHomeBtn: UIButton!
    
    @IBAction func backBtnPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        HanselWrapper.logEvent(eventName: "Email_sent_page_opened", properties: [:])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.isHidden = true
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: "Futura-Medium", size: 13)!
        preferences.drawing.foregroundColor = UIColor.white
        preferences.drawing.backgroundColor = UIColor(hue:0.46, saturation:0.99, brightness:0.6, alpha:1)
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.bottom
       
        var lineView = UIView(frame: CGRect(x:0,y:goToHomeBtn.frame.size.height+1,width: goToHomeBtn.frame.size.width,height:1))
        lineView.backgroundColor=UIColor.lightGray
        goToHomeBtn.addSubview(lineView)
       
        if let isLaunched = UserDefaults.standard.string(forKey: "isRequestPageLaunched") {
            if (isLaunched == "YES"){
                // do nothing
            }else{
                UserDefaults.standard.set("YES", forKey: "isRequestPageLaunched")
            }
        }else{
            UserDefaults.standard.set("YES", forKey: "isRequestPageLaunched")
//            EasyTipView.show(forView: (navigationController?.view)!,
//                             withinSuperview: self.navigationController?.view,
//                             text: "Message is sent. Please go to Main Menu on top left corner and select Search Flavors Pantry to start your search again. ",
//                             preferences: preferences,
//                             delegate: nil)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
