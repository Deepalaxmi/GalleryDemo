//
//  UIViewController.swift
//  GalleryDemo
//
//  Created by Khangembam Deepalaxmi Devi on 02/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import UIKit

extension UIViewController{
    func showAlert(title:String , message :String) {
        let actionSheetController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        present(actionSheetController, animated: true)

    }
    
    func showToast(message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
}

