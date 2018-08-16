//
//  ViewController.swift
//  ChrescoTest
//
//  Created by miguel on 8/14/18.
//  Copyright © 2018 Samtech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var countriesUITableView: UITableView!
    var arrValues = [[String:AnyObject]]()
    let utils = Common()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validateRequest()
    }
    
    func validateRequest(){
        
        if utils.isConnectionAvailable(){
            requestCountries()
        }else{
            utils.showAlertForOpenNetworkSettings(title: Keys.titleNoConn, msg: Keys.msgNoConn, msgBtn: Keys.actNoConn)
        }
    }
    
    func requestCountries() {
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        let todoEndpoint: String = Keys.urlBase + Keys.apiCountries
        
        Alamofire.request(todoEndpoint)
            .responseJSON { response in
                
                UIViewController.removeSpinner(spinner: sv)
                
                if((response.result.value) != nil) {
                    let swiftyJsonVar = JSON(response.result.value!)
                    let success = swiftyJsonVar["success"].bool
                    if(success)!{
                        if let resData = swiftyJsonVar["data"]["countries"].arrayObject {
                            self.arrValues = resData as! [[String:AnyObject]]
                        }
                        
                        if self.arrValues.count > 0 {
                            self.countriesUITableView.reloadData()
                        }
                    }
                }
        }
    }
    
    func requestCountryByCode(paramCode: String){
        let sv = UIViewController.displaySpinner(onView: self.view)
        let todoEndpoint: String = Keys.urlBase + Keys.apiCountryById + paramCode
        
        Alamofire.request(todoEndpoint)
            .responseJSON { response in
                
                UIViewController.removeSpinner(spinner: sv)
                
                if((response.result.value) != nil) {
                    let swiftyJsonVar = JSON(response.result.value!)
                    let data = swiftyJsonVar["data"]
                    
                    if data["identification"].count == 0 {
                        self.utils.showMessage(title: Keys.titleNoVal, msg: Keys.msgNoVal, actBtn: Keys.actNoVal)
                    }else{
                         let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController
                        detailVC?.data = data
                         self.navigationController?.pushViewController(detailVC!, animated: true)
                    }
                }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        var dict = arrValues[indexPath.row]
        cell.textLabel?.text = dict["name"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if utils.isConnectionAvailable(){
            var dictValues = arrValues[indexPath.row]
            let codeValue = dictValues["code"] as? String
            requestCountryByCode(paramCode: codeValue!)
            
        }else{
            utils.showAlertForOpenNetworkSettings(title: Keys.titleNoConn, msg: Keys.msgNoConn, msgBtn: Keys.actNoConn)
        }
    }
    
}

