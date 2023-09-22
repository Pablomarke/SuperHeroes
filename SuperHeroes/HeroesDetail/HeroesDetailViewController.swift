//
//  HeroesDetailViewController.swift
//  SuperHeroes
//
//  Created by Pablo Márquez Marín on 6/9/23.
//

import UIKit

class HeroesDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var horoeImage: UIImageView!
    @IBOutlet weak var heroeName: UILabel!
    @IBOutlet weak var heroeDescription: UILabel!
    @IBOutlet weak var transformationsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detalle Heroe"
        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation

    @IBAction func transformationsAction(_ sender: Any) {
    }
    
}
