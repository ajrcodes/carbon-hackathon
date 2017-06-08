//
//  FinalizedGroupViewController.swift
//  carbonhackathon
//
//  Created by Roberts, Andrew on 6/7/17.
//  Copyright © 2017 Roberts, Andrew. All rights reserved.
//

import UIKit

class FinalizedGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var groupname: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    
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
