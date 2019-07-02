//
//  ViewController.swift
//  RecipiesApp
//
//  Created by Waqas Hussain on 01/07/2019.
//  Copyright © 2019 Waqas Hussain. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        activityIndicator.startAnimating()
        RecipeManager.shared.getAllRecipies(callback: { // Success Response
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }) { (error) in // Error Handling
            Helper.showAlert(with: "Error", message: error)
            self.activityIndicator.stopAnimating()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rpDetails" {
            let dest = segue.destination as! RecipeDetailsViewController
            dest.recipe = Resource.recipies[tableView.indexPathForSelectedRow!.row]
        }
    }

}


// Adding TableView Delegate & DataSource
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Resource.recipies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipe") as! RecipeTableViewCell
        cell.imageV.kf.setImage(with: URL.init(string: Resource.recipies[indexPath.row].imageURL))
        cell.name.text = Resource.recipies[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "rpDetails", sender: nil)
    }
    
}
