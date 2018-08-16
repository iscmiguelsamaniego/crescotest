//
//  DetailViewController.swift
//  ChrescoTest
//
//  Created by miguel on 8/15/18.
//  Copyright © 2018 Samtech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var countrySelectedUILabel: UILabel!
    @IBOutlet weak var errorUILabel: UILabel!
    @IBOutlet weak var identificationUITextField: UITextField!
    
    let utils = Common()
    var data: JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = data["identification"]["name"]
        countrySelectedUILabel.text = name.stringValue
        
        self.hideKeyboardWhenTappedAround()
        identificationUITextField.delegate = self
        identificationUITextField.autocorrectionType = .no
        identificationUITextField.addTarget(self, action: #selector(DetailViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        errorUILabel.isHidden = true
    }
    
    @IBAction func openLinkUIButton(_ sender: Any) {
        let myUrl = data["identification"]["help_url"].stringValue
        if let url = URL(string: "\(myUrl)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func isValidIdentification(paramId: String, paramPattern: String) -> Bool{
        
        let regEx = paramPattern
        let pred = NSPredicate(format:"SELF MATCHES[c] %@", regEx)
        
        return pred.evaluate(with: paramId)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        utils.setNoError(paramTxtField: identificationUITextField, paramLabel: errorUILabel)
        
        let pattern = data["identification"]["pattern"].stringValue
        
        if !isValidIdentification(paramId: identificationUITextField.text!, paramPattern: pattern){
            utils.setError(paramTxtField: identificationUITextField, paramLabel: errorUILabel, paramMsg: Keys.incorrectValues)
        }
    }
}
