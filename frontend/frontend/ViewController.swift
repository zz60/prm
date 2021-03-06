//
//  ViewController.swift
//  frontend
//
//  Created by Ziyu Zhang on 4/7/17.
//  Copyright © 2017 Ziyu Zhang. All rights reserved.
//

import UIKit
import Alamofire //HTTP framework
import AlamofireObjectMapper

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    var contacts: [Contact] = [];
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailSegue" {
            if let indexPath = self.table.indexPathForSelectedRow {
                let controller = segue.destination as! DetailTabBarController;
                controller.contact = contacts[indexPath.row];
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell");
        cell.textLabel?.text = contacts[indexPath.row].firstName! + " " + (contacts[indexPath.row].lastName == "NULL" ? "" : contacts[indexPath.row].lastName)!;
        
        return cell;
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailSegue", sender: nil);
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getContacts();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContacts() {
        Alamofire.request("https://prm-backend.appspot.com/users/1/contacts", method: .get).responseArray {
            (response: DataResponse<[Contact]>) in
            
            self.contacts = response.result.value!;
            self.table.reloadData();
        }
    }

}

