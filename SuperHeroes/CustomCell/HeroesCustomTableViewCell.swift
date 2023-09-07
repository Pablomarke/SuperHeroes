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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //TODO
    func configure() {
        
        heroeName.text = "Goku"
        heroeDescription.text = "Aquí va la descripción"
    }
    
}
