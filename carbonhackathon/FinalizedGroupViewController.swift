//
//  FinalizedGroupViewController.swift
//  carbonhackathon
//
//  Created by Roberts, Andrew on 6/7/17.
//  Copyright © 2017 Roberts, Andrew. All rights reserved.
//

import UIKit

let baseURL = "https://carbonhackathon.herokuapp.com"

class FinalizedGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var groupname: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var switchy: UISwitch!
    
    // MARK: - IBActions
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Contact Card Enabled", message: "If enabled, our service will send contact information as vCards via MMS.  This can take longer than traditional SMS, but it will save a click when received.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        createGroupFromAPI()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
    }
    
    
    // MARK: - Lifecycle
    
    func tableViewSetup() {
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewDidLoad() {
        tableViewSetup()
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
    
        // setup rounded edges on textView
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        textView.layer.borderWidth = 0.5
        textView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroup.users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userGroup", for: indexPath) as! UserGroupTableViewCell
        self.tableview.rowHeight = 75
        
        // setup the cell to be used in the table view
        cell.user = userGroup.users[indexPath.row]
        cell.delegate = self
        cell.index = indexPath.row
        cell.setupCell()
        
        return cell
    }
    
    func createGroupFromAPI(){
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        var people = [] as Array
        for user in userGroup.users {
            people.append([
                "fname":user.firstName,
                "lname":user.lastName,
                "numbers":[
                    ["type": "cell", "num": user.phoneNumber],
                ],
                ])
        }
        
        
        let dict = [
            "group": people,
            "note":textView.text,
            "mms": switchy.isOn
            ] as [String: Any]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        
        
        let url = URL(string: baseURL + "/api/send-group")!
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
                    self.dismiss(animated: false, completion: nil)
                }
                else{
                    print("fail")
                    self.dismiss(animated: false, completion: nil)
                }
            }
            else{
                print("fail")
                self.dismiss(animated: false, completion: nil)
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
