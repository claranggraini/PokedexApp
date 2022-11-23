//
//  PokemonTypeView.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 23/11/22.
//

import UIKit

//enum PokemonType: String{
//    case normal
//    case fire
//    case water
//    case grass
//    case electric
//    case ice
//    case fighting
//    case poison
//    case ground
//    case flying
//    case psychic
//    case bug
//    case rock
//    case ghost
//    case dark
//    case dragon
//    case steel
//    case fairy
//
//}

enum TypeSize{
    case small
    case big
}

class PokemonTypeView: UIView {

    var pokemonType: PokemonType?{
        didSet{
            self.typeLbl.text = pokemonType?.name?.capitalized
            self.backgroundColor = pokemonType?.color
        }
    }
    
    var size: TypeSize = .small{
        didSet{
            switch size{
            case .small:
                self.layer.cornerRadius = 8
                self.typeLbl.font = UIFont.systemFont(ofSize: 10, weight: .medium)
            case .big:
                self.layer.cornerRadius = 16
                self.typeLbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            }
        }
    }
    
    let typeLbl: UILabel = {
        let lbl = UILabel ()
        lbl.text = "Poke Type"
        lbl.setContentHuggingPriority(.required, for: .horizontal)
        lbl.setContentCompressionResistancePriority(.required, for: .horizontal)
        lbl.textColor = .white
        lbl.clipsToBounds = true
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .lightGray
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(typeLbl)
        
        NSLayoutConstraint.activate([
            typeLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            typeLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            typeLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            typeLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
