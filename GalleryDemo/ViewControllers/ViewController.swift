//
//  ViewController.swift
//  GalleryDemo
//
//  Created by Khangembam Deepalaxmi Devi on 01/12/18.
//  Copyright © 2018 Khangembam Deepalaxmi Devi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Gallery Demo"
        self.nameTextField.delegate = self
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        guard nameTextField.hasText else {
            self.showAlert(title: "Alert", message: "Please enter your name to proceed.")
            return
        }
        
        let galleryVC = GalleryViewController()
        galleryVC.fullName = nameTextField.text
        self.navigationController?.pushViewController(galleryVC, animated: true)
    }
    
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

