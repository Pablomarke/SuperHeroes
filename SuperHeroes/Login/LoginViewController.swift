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
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Boton
    @IBAction func continueAction(_ sender: Any) {
        model.login(
            user: userNameText.text ?? "",
            password: passwordText.text ?? ""
        ) { [weak self] result in
            switch result {
                case let .success(token):
                    self?.model.getHeroes {  result in
                        switch  result {
                            case let .success(heroes): 
                                DispatchQueue.main.async {
                                    self?.navigationHeroes(heroes: heroes)
                                }
                            case let .failure(error):
                                print("error \(error)")
                        }
                    }
                case let .failure(error):
                    print("error \(error)")
            }
        }
    }
}
extension LoginViewController {
    func navigationHeroes(heroes: [Hero] ) {
            let heroesList = HeroesListTableViewController(model: heroes)
            self.navigationController?.setViewControllers([heroesList],
                                                        animated: true)
    }
}
