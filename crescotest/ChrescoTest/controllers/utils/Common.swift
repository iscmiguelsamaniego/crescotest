//
//  Network.swift
//  ChrescoTest
//
//  Created by miguel on 8/14/18.
//  Copyright © 2018 Samtech. All rights reserved.
//

import Foundation
import Alamofire

class Common {
    func showAlertForOpenNetworkSettings(title: String, msg: String, msgBtn: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title : msgBtn, style: UIAlertActionStyle.default)
        { action -> Void in
            self.openNetworkSettings()
        })
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    func showMessage(title: String, msg: String, actBtn: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title : actBtn, style: UIAlertActionStyle.default, handler: nil))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    func openNetworkSettings(){
        if let url = URL(string:"App-Prefs:root=WIFI") {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    func isConnectionAvailable() -> Bool{
        return NetworkReachabilityManager()!.isReachable
    }
    
    func setNoError(paramTxtField: UITextField, paramLabel: UILabel){
        DispatchQueue.main.async {
            paramLabel.isHidden = true
            let normalColor = UIColor.black
            paramLabel.textColor = normalColor
            paramLabel.textDropShadow()
            paramTxtField.layer.borderColor = normalColor.cgColor
        }
    }
    
    func setError(paramTxtField: UITextField, paramLabel: UILabel, paramMsg: String){
        DispatchQueue.main.async {
            paramLabel.isHidden = false
            let errorColor = UIColor.orange
            paramLabel.textColor = errorColor
            paramLabel.textDropShadow()
            paramLabel.text = paramMsg
            paramTxtField.layer.borderColor = errorColor.cgColor
            paramTxtField.shake()
        }
    }
}
