//
//  RecipeDetailsViewController.swift
//  RecipiesApp
//
//  Created by Waqas Hussain on 02/07/2019.
//  Copyright © 2019 Waqas Hussain. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {

    //Outlets
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var chef: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var image: UIImageView!

    //Variables used
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting values to outlets
        
        image.kf.indicatorType = .activity
        image.kf.setImage(with: URL.init(string: recipe.imageURL))
        name.text = recipe.title
        calories.text = "\(recipe.calories!)"
        desc.text = recipe.description
        chef.text = recipe.chefId != nil ? Resource.chefs[recipe.chefId!]! : "Anonymous"
        tags.text = recipe.tagIds.count == 0 ? "No tags to show" : recipe.tagIds.map({ (_id) -> String in
            return Resource.tags[_id]!
        }).joined(separator: ", ")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
