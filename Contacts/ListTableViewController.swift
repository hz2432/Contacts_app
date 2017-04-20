//
//  ListTableViewController.swift
//  Contacts
//
//  Created by haiki on 4/20/17.
//  Copyright © 2017 haiki. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    var personList = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData { (list) in
            self.personList += list
            self.tableView.reloadData()
        }
    }

    // asynchronous closure
    private func loadData(_ completion: @escaping (_ list: [Person])->()) -> (){
        DispatchQueue.global().async {
            print("loading")
            Thread.sleep(forTimeInterval: 1)
            var arrayM = [Person]()
            
            for i in 0..<20{
                let p = Person()
                p.name = "John - \(i)"
                p.phone = "1860" + String(format: "%06d", arc4random_uniform(100000))
                p.title = "friend"
                arrayM.append(p)
            }
            
            DispatchQueue.main.async(execute: {
                completion(arrayM);
            })
        }
    }
    
    @IBAction func newPerson(_ sender: Any) {
        performSegue(withIdentifier: "list2detail", sender: nil)
        
        
    }

    //MARK: Controller Jump method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        //Set choosed persom
        if let indexPath = sender as? IndexPath{
            vc.person = personList[indexPath.row]
            vc.completionCallBAck = {
                //refresh row
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
            //new Person
        else{
            vc.completionCallBAck = {
                //get detailcontroller person
                guard let p = vc.person else{
                    return
                }
                //insert new data
                self.personList.insert(p, at: 0)
                
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: Agent
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //run segue
        performSegue(withIdentifier: "list2detail", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = personList[indexPath.row].name
        cell.detailTextLabel?.text = personList[indexPath.row].phone
        return cell
    }
}
