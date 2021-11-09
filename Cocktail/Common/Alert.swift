//
//  Alert.swift
//  Cocktail
//
//  Created by Abdul Rahim on 09/11/21.
//

import UIKit

//MARK:- General Alert pop up

struct Alert {
    static func showErrorAlertWithMsg(title:String, msg:String, showOn vc: UIViewController){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okAction)
        vc.parent?.present(alert, animated: true, completion: nil)
    }
}
