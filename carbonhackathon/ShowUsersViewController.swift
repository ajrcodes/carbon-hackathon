//
//  ShowUsersViewController.swift
//  carbonhackathon
//
//  Created by Roberts, Andrew on 6/8/17.
//  Copyright © 2017 Roberts, Andrew. All rights reserved.
//

import UIKit

class ShowUsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Fields
    
    var group: Group = Group()
    var users: [User] = []
    
    
    // MARK: - IBOutlets

    
    
    
    // MARK: - Lifecycle
    
    func tableViewSetup() {
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        users = DataHelper.
        // Do any additional setup after loading the view.
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
