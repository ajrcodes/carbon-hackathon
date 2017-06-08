//
//  AddNearByViewController.swift
//  carbonhackathon
//
//  Created by Roberts, Andrew on 6/7/17.
//  Copyright © 2017 Roberts, Andrew. All rights reserved.
//

import UIKit
import MapKit

class AddNearByViewController: UIViewController {
    let interval:Int = 2 // 2 seconds
    
    @IBOutlet weak var tableview: UITableView!
    
    //var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
        //locManager.requestWhenInUseAuthorization()
        
        //set timer
        let updateTimer = Timer.scheduledTimer(timeInterval: TimeInterval(interval), target: self, selector: #selector(self.sendLocation), userInfo: nil, repeats: true)
        
        //run timer immediately
        RunLoop.current.add(updateTimer, forMode: RunLoopMode.commonModes)
        
        //stop timer
        //updateTimer.invalidate()
        
        // Do any additional setup after loading the view.
        //sendLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //your function
    func sendLocation(){
        print("test")
    
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locManager.location
            print("in location")
        }
        
        var fname = ""
        var lname = ""
        var num = ""
        
        
        if let firstNameValue = UserDefaults.standard.string(forKey: "firstName") {
            fname = firstNameValue
        }
        
        if let lastNameValue = UserDefaults.standard.string(forKey: "lastName") {
            lname = lastNameValue
        }
        if let phoneNumValue = UserDefaults.standard.string(forKey: "phoneNum"){
            num = phoneNumValue
        }
        
        let dict = [
            "lat": currentLocation.coordinate.latitude,
            "lon": currentLocation.coordinate.longitude,
            "name": fname + " " + lname,
            "number": num,
            ] as [String: Any]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        
        let url = URL(string: baseURL + "/api/get-nearby")!
        var request = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error on data")
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                if(responseJSON["success"] as! Bool){
                    print("success")
                    let users = responseJSON["data"] as!  [[String: Any]]
                    
                    for user in users{
                        //add users to table
                        let name = user["name"] //format "firstname lastname"
                        let number = user["number"] //format "1234567890"
                        
                        //add name and number here
                    }
                    
                }
                else{
                    print("fail in response")
                }
            }
            else{
                print("fail no response")
            }
        }
        task.resume()
        
    }
    
    func deleteLocation(){
        
        var fname = ""
        var lname = ""
        var num = ""
        
        
        if let firstNameValue = UserDefaults.standard.string(forKey: "firstName") {
            fname = firstNameValue
        }
        
        if let lastNameValue = UserDefaults.standard.string(forKey: "lastName") {
            lname = lastNameValue
        }
        if let phoneNumValue = UserDefaults.standard.string(forKey: "phoneNum"){
            num = phoneNumValue
        }
        
        let url = URL(string: baseURL + "/api/remove-from-nearby/" + fname + lname + num)!
        
        var request = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error on data")
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                if(responseJSON["success"] as! Bool){
                    print("successful delete")
                }
                else{
                    print("fail in response")
                }
            }
            else{
                print("fail no response")
            }
        }
        task.resume()
        
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
