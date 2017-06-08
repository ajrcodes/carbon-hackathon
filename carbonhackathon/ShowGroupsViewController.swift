//
//  ShowGroupsViewController.swift
//  carbonhackathon
//
//  Created by Roberts, Andrew on 6/8/17.
//  Copyright © 2017 Roberts, Andrew. All rights reserved.
//

import UIKit

class ShowGroupsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Fields
    
    var groups: [Group] = []
    var valueToPass: Group = Group(name: "default", descrip: "default")
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableview: UITableView!
    
    
    // MARK: - Lifecycle
    
    func tableViewSetup() {
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        groups = DataHelper.retrieveGroupsFromCoreData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Tableview methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupTableViewCell
        self.tableview.rowHeight = 75
        
        // setup the cell to be used in the table view
        cell.group = groups[indexPath.row]
        cell.delegate = self
        cell.setupCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as! GroupTableViewCell
        
        valueToPass = currentCell.group
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if (segue.identifier == "showUsersFromGroup") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! ShowUsersViewController
            // your new view controller should have property that will store passed value
            viewController.group = valueToPass
        }
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
