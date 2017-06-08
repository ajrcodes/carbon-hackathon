//
//  AddNearByViewController.swift
//  carbonhackathon
//
//  Created by Roberts, Andrew on 6/7/17.
//  Copyright © 2017 Roberts, Andrew. All rights reserved.
//

import UIKit
import MapKit

class AddNearByViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var usersForTable: [User] = []

    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func addSelectedPressed(_ sender: Any) {
    }
    
    @IBAction func cancelSelectedPressed(_ sender: Any) {
    }
    
    let interval:Int = 2 // 2 seconds
    
    
    //var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
        tableViewSetup()
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
                    
                    for userHere in users{
                        let name = String(describing: userHere["name"]!) //format "firstname lastname"
                        var nameArray = name.components(separatedBy: " ")
                        let number = String(describing: userHere["number"]!) //format "1234567890"
                        let currentUser = User(firstName: nameArray[0], lastName: nameArray[1], phoneNumber: number)
                        
                        var flag = false
                        for compareUser in self.usersForTable {
                            if compareUser.phoneNumber == currentUser.phoneNumber {
                                flag = true
                            }
                        }
                        
                        if !flag {
                            self.usersForTable.append(currentUser)
                            self.tableview.reloadData()
                        }
                        
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
    
    
    // MARK: - Table view methods
    
    func tableViewSetup() {
        tableview.delegate = self
        tableview.dataSource = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersForTable.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addNearby", for: indexPath) as! AddNearbyTableViewCell
        self.tableview.rowHeight = 75
        
        // setup the cell to be used in the table view
        cell.user = usersForTable[indexPath.row]
        cell.setupCell()
        
        return cell
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
