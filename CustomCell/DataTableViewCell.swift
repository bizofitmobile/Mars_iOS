//
//  DataTableViewCell.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/8/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

protocol DataCellDelegate {
    func didPressedVendorButton(button:UIButton)
    func didPressedCheckBoxButton(button:UIButton)
    func didPressedPDFBtn(button:UIButton)
    
    
}
struct DataTableViewCellData {
    
    init(imageUrl: String, text: String) {
        self.imageUrl = imageUrl
        self.text = text
    }
    var imageUrl: String
    var text: String
}

class DataTableViewCell : BaseTableViewCell {
    
    @IBAction func pdfBtnPressed(_ sender: Any) {
        print("pdf pressed")
        
        delegate?.didPressedPDFBtn(button: sender as! UIButton)
    }
    @IBOutlet weak var pdfBtn: UIButton!
    @IBOutlet weak var subheaderLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var vendorImage: UIButton!
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var dataText: UILabel!
    var delegate:DataCellDelegate?
    @IBAction func venderIconBtnPressed(_ sender: Any) {
      //  print("venderIconBtnPressed")
        delegate?.didPressedVendorButton(button: sender as! UIButton)
    }
    @IBAction func checkBtnAction(_ sender: Any) {
        delegate?.didPressedCheckBoxButton(button:sender as! UIButton)

       // print("CheckBtnAction")
    }
    override func prepareForReuse() {
        // invoke superclass implementation
        super.prepareForReuse()
       // checkBtn.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)

        
    }
    @IBOutlet weak var checkBtn: UIButton!
    override func awakeFromNib() {
        
       // self.pdfBtn.isHidden = false
        self.dataText?.font = UIFont.systemFont(ofSize: 16.0)
       // self.dataText?.textColor = UIColor(hex: "9E9E9E")
        checkBtn.setBackgroundImage(UIImage(named: "uncheck_box"), for: .normal)

      //  checkBtn.layer.borderWidth = 1
       // checkBtn.layer.borderColor = UIColor.lightGray.cgColor
    }
 
    override class func height() -> CGFloat {
        return 60
    }
    
    override func setData(_ data: Any?) {
        if let data = data as? DataTableViewCellData {
          //  self.dataImage.setRandomDownloadImage(80, height: 80)
            self.dataImage.layer.cornerRadius = 19
            self.dataImage.layer.masksToBounds = true;
            self.dataImage.backgroundColor = UIColor.randomColor(randomAlpha: false)
            

           // self.dataText.text = data.text
            let fullNameArr = data.text.characters.split{$0 == "\n"}.map(String.init)
            // or simply:

            subheaderLabel.text = fullNameArr[1]
             self.dataText.text = fullNameArr[0]
          // let attributedText = NSMutableAttributedString(string: fullNameArr[0], attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12.0), NSAttributedStringKey.foregroundColor: UIColor.gray
//            ])
//
//            attributedText.append(NSAttributedString(string: fullNameArr[1], attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12.0), NSAttributedStringKey.foregroundColor: UIColor.lightGray]))
//
//

            self.imageLabel.text = data.text.characters.first?.description ?? ""
            
        }
    }
}

extension UIColor {
    
    class func randomColor(randomAlpha randomApha:Bool = false)->UIColor{
        
        let redValue = CGFloat(arc4random_uniform(255)) / 255.0;
        let greenValue = CGFloat(arc4random_uniform(255)) / 255.0;
        let blueValue = CGFloat(arc4random_uniform(255)) / 255.0;
        let alphaValue = randomApha ? CGFloat(arc4random_uniform(255)) / 255.0 : 1;
        
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
        
    }
}
