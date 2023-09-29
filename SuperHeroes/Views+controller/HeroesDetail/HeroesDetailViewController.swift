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
    @IBOutlet weak var favoriteImageButton: UIButton!
    
    // MARK: - Init
    var model: HeroesAndTransformations
    var modelTransformations: [HeroesAndTransformations] = []
    var conect = NetworkModel()
    
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
            self.hiddenFavoriteButton()
            self.transformationsButton.isHidden = true
            self.conect.getTransformations(
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
    
    @IBAction func favoriteAction(_ sender: Any) {
        conect.heroeFavorite(id: model.id) { result in
            switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.favoriteImageButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    }
                case let .failure(error):
                    print("error: \(error)")
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
        isFavorite()
    }
    
    func hiddenFavoriteButton() {
        let myType = type(of: model)
        if myType == Transformation.self {
            self.favoriteImageButton.isHidden = true
        }
    }
    
    func isFavorite() {
        if model.favorite == true {
            self.favoriteImageButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else if model.favorite == false {
            self.favoriteImageButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
