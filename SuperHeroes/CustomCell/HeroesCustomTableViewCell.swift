//
//  HeroesCustomTableViewCell.swift
//  SuperHeroes
//
//  Created by Pablo Márquez Marín on 6/9/23.
//

import UIKit

class HeroesCustomTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var heroeImage: UIImageView!
    @IBOutlet weak var heroeName: UILabel!
    @IBOutlet weak var heroeDescription: UILabel!
    
    static let identifier = "HeroesCustomTableViewCell"
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }
    
    // MARK: - Función para sincronizar modelo y vista
    func configure(with heroe: any HeroesAndTransformations) {
        heroeName.text = heroe.name
        heroeDescription.text = heroe.description
        heroeImage.setImage(for: heroe.photo)
    }
}



