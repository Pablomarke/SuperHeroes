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
    
    private let model = NetworkModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func continueAction(_ sender: Any) {
        model.login(
            user: userNameText.text ?? "",
            password: passwordText.text ?? ""
        ) { [weak self] result in
            switch result {
                case let .success(token):
                   // print("Token: \(token)")
                    self?.model.getHeroes {  result in
                        switch  result {
                            case let .success(heroes):
                                //print("Heroes: \(heroes)")
                                let goku = heroes[3]
                                self?.model.getTransformations2(
                                        for: goku
                                    ) { Result in
                                        switch result {
                                            case let .success(transformations):
                                                print("---------->Transformaciones: \(transformations)")
                                                print("-------hasta aquí")
                                            case let .failure(error):
                                                print("Error: \(error)")
                                        }
                                    }
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
