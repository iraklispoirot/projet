//
//  GuiTools.swift
//  mesCourses
//
//  Created by etudiant on 21/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//
import UIKit
import Foundation

func alert(titre: String, message: String, boutonTitre: String) -> UIAlertController
{
    let alertController = UIAlertController(title: titre, message:
        message, preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: boutonTitre, style: UIAlertActionStyle.default,handler: nil))
    return alertController
    
}

extension UIViewController{
    func presentAlert(withError error:Error) {
        self.presentAlertDialog(withTitle: "Error_Occured".localizedLowercase, andMessage: error.localizedDescription)
    }
    
    func presentAlertDialog(withTitle title: String, andMessage msg:String){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
}

