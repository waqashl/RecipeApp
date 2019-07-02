//
//  Helper.swift
//  RecipiesApp
//
//  Created by Waqas Hussain on 02/07/2019.
//  Copyright © 2019 Waqas Hussain. All rights reserved.
//

import UIKit


class Helper {
    
    static var accessToken = "7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c"
    static var spaceId = "kk2bw5ojx476"
    static var environment = "master"
    
    static func showAlert(with title: String, message: String, delegate: UIViewController? = nil, okAction: (()->Void)? = nil) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (_) in
            okAction?()
        }))
        (delegate ?? UIApplication.shared.keyWindow?.rootViewController)?.present(alert, animated: true, completion: nil)
    }

}

class Resource {
    static var recipies : [Recipe] = []
    static var tags : [String:String] = [:]
    static var chefs : [String:String] = [:]
}
