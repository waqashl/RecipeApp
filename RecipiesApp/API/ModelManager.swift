//
//  ModelManager.swift
//  RecipiesApp
//
//  Created by Waqas Hussain on 02/07/2019.
//  Copyright © 2019 Waqas Hussain. All rights reserved.
//

typealias SuccessCallback = ()->Void
typealias ErrorCallback = (String)->Void

import Foundation
import Alamofire

class RecipeManager {
    
    private static var sharedInstance : RecipeManager?
    static var shared : RecipeManager {
        guard let instance = RecipeManager.sharedInstance else {
            RecipeManager.sharedInstance = RecipeManager()
            return RecipeManager.sharedInstance!
        }
        return instance
    }
    
    // Requests for All the recipies on server... parse it to local Resource.
    func getAllRecipies(callback: @escaping SuccessCallback, errorCallback: ErrorCallback? = nil) {
        
        Alamofire.request("https://cdn.contentful.com/spaces/\(Helper.spaceId)/environments/\(Helper.environment)/entries?access_token=\(Helper.accessToken)&content_type=recipe").responseJSON { (res) in
            
            if let error = res.error {
                errorCallback?(error.localizedDescription)
                return
            }
            
            if let data = res.result.value as? Dictionary<String,Any> {
                print(data)
                let items = data["items"] as! [Dictionary<String,Any>]
                for item in items {
                    let fields = item["fields"] as! Dictionary<String,Any>
                    var recipe = Recipe.init(title: fields["title"] as! String, description: fields["description"] as! String, imageURL: "", calories: (fields["calories"] as! Int), tagIds: [], chefId: nil)
                    
                    let imageData = fields["photo"] as! Dictionary<String,Any>
                    recipe.imageURL = ((imageData["sys"] as! [String:Any])["id"] as! String)
                    if let tags = fields["tags"] as? [Dictionary<String,Any>] {
                        for tag in tags {
                            recipe.tagIds.append((tag["sys"] as! [String:Any])["id"] as! String)
                        }
                    }
                    if let chef = fields["chef"] as? Dictionary<String,Any> {
                        recipe.chefId = ((chef["sys"] as! [String:Any])["id"] as! String)
                    }
                    Resource.recipies.append(recipe)
                }
                let includes = data["includes"] as! Dictionary<String,Any>
                for asset in includes["Asset"] as! [Dictionary<String,Any>] {
                    let id = (asset["sys"] as! Dictionary<String,Any>)["id"] as! String
                    let assetFields = asset["fields"] as! Dictionary<String,Any>
                    if let index = Resource.recipies.firstIndex(where: { (_recipe) -> Bool in
                        return _recipe.imageURL == id
                    }) {
                        Resource.recipies[index].imageURL = "https:" + ((assetFields["file"] as! Dictionary<String,Any>)["url"] as! String)
                    }
                }
                for entry in includes["Entry"] as! [Dictionary<String,Any>] {
                    let entrySys = entry["sys"] as! Dictionary<String,Any>
                    let id = entrySys["id"] as! String
                    let type = ((entrySys["contentType"] as! [String:Any])["sys"] as! [String:Any])["id"] as! String
                    let name = (entry["fields"] as! Dictionary<String,Any>)["name"] as! String
                    
                    if type == "chef" {
                        Resource.chefs[id] = name
                    }
                    else {
                        Resource.tags[id] = name
                    }
                    
                }
                callback()
            }
            else {
                errorCallback?("Data not in correct format.")
                print(res.result.value ?? "Some Data")
            }
        }
        
    }
    
}
