//
//  LoginViewController.swift
//  SuperHeroes
//
//  Created by Pablo Márquez Marín on 29/8/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func continueAction(_ sender: Any) {
        let heroesList = HeroesListTableViewController()
        self.navigationController?.setViewControllers([heroesList],
                                                      animated: true)
        
    }
    
}
