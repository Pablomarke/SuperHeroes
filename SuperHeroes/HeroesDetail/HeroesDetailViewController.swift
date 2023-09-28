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
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var transformationsButton: UIButton!
    @IBOutlet weak var heroesDescriptionText: UITextView!
    @IBOutlet weak var favoriteImage: UIImageView!
    
    // MARK: - Init
    var model: HeroesAndTransformations
    var modelTransformations: [HeroesAndTransformations] = []
    
    init( model: HeroesAndTransformations) {
        self.model = model
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.syncModelwithView()
            self.transformationsButton.isHidden = true
            NetworkModel().getTransformations(
                for: self.model
            ) {  result in
                switch result {
                    case let .success(transformations):
                        DispatchQueue.main.async {
                            self.modelTransformations.append(contentsOf: transformations)
                            if self.modelTransformations.count > 0 {
                                self.transformationsButton.isHidden = false
                                self.bottomView.isHidden = false
                            }
                        }
                    case let .failure(error):
                        print("\(error)")
                }
            }
        }
    }
    
    // MARK: - Navigation
    @IBAction func transformationsAction(_ sender: Any) {
        let navigationToTransforms = HeroesListTableViewController(model: modelTransformations)
        self.navigationController?.show(navigationToTransforms,
                                        sender: nil)
    }
}

// MARK: - Extensiones
extension HeroesDetailViewController {
    func syncModelwithView (){
        self.title = model.name
        heroeImage.setImage(for: model.photo)
        heroeName.text = model.name
        heroesDescriptionText.text = model.description
        if model.favorite == true {
            favoriteImage.image = UIImage(systemName: "star.fill")
        } else {
            favoriteImage.image = UIImage(systemName: "star")
        }
    }
    
}
