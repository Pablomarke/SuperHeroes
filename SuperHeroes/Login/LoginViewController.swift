//
//  LoginViewController.swift
//  SuperHeroes
//
//  Created by Pablo Márquez Marín on 29/8/23.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func continueAction(_ sender: Any) {
        let model = NetworkModel()
       
        model.login(
            user: userNameText.text ?? "",
            password: passwordText.text ?? ""
        ) { result in
            
            switch result {
                case let .success(token):
                    print("Token: \(token)")
                    model.getHeroes(token: token) {  result in
                        switch result {
                            case let .success(heroes):
                                let goku = heroes[3]
                                    model.getTransformations2(
                                        for: goku,
                                        token: token
                                    ) { Result in
                                        switch result {
                                            case let .success(transformations):
                                                print("---------->Transformaciones: \(transformations)")
                                                print("-------hasta aquí")
                                            case let .failure(error):
                                                print("Error: \(error)")
                                        }
                                    }
                                //print("Heroes: \(heroes)")
                            case let .failure(error):
                                print("error \(error)")
                        }
                    }
                case let .failure(error):
                    print("error \(error)")
            }
        }
        
        
       
        
       
        /*
        let heroesList = HeroesListTableViewController()
        self.navigationController?.setViewControllers([heroesList],
                                                    animated: true)
         }
         model.getTransformations(
             for: heroes[4]
         ) { result in
             
             switch result {
                 case let .success(transformations):
                     print("Aquí !! \(transformations)")
                 case let .failure(error):
                     print("Mi error es \(error)")
             }
         }
         */
    }
}
