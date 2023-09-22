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
            user: userNameText.text ?? "markedevelop@gmail.com",
            password: passwordText.text ?? "abcd1234"
        ) { [weak self] result in
            switch result {
                case let .success(token):
                    self?.model.getHeroes {  result in
                        switch  result {
                            case let .success(heroes): 
                                DispatchQueue.main.async {
                                    let heroesList = HeroesListTableViewController(model: heroes)
                                    self?.navigationController?.setViewControllers([heroesList],
                                                                                animated: true)
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
