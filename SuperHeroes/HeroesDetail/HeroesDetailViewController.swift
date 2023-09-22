//
//  HeroesDetailViewController.swift
//  SuperHeroes
//
//  Created by Pablo Márquez Marín on 6/9/23.
//

import UIKit

class HeroesDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var heroeImage: UIImageView!
    @IBOutlet weak var heroeName: UILabel!
    @IBOutlet weak var heroeDescription: UILabel!
    @IBOutlet weak var transformationsButton: UIButton!
    
    var model: Hero
    
    init( model: Hero) {
        self.model = model
        super.init(nibName: nil, 
                   bundle: nil)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.syncModelwithView()
            self.transformationsButton.isHidden = true
            NetworkModel().getTransformations2(
                for: self.model
            ) {  result in
                switch result {
                    case let .success(transformations):
                        DispatchQueue.main.async {
                            print("ok! \(transformations)")
                            self.transformationsButton.isHidden = false
                        }
                    case let .failure(error):
                        print("\(error)")
                        
                }
            }
        }
    }
    // MARK: - Navigation
    @IBAction func transformationsAction(_ sender: Any) {
        let transformationTable = HeroesListTableViewController(model: [Transformation])
    }
    
}

extension HeroesDetailViewController {
    func syncModelwithView (){
        self.title = model.name
        heroeImage.setImage(for: model.photo)
        heroeName.text = model.name
        heroeDescription.text = model.description
    }
}
