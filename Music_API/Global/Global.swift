//
//  Global.swift
//  Music_API
//
//  Created by Mr. Naveen Kumar on 15/04/21.
//


import Foundation
import UIKit

class Global: NSObject {
   static let shared = Global()
   
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            debugPrint("ok")
        }))
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}




