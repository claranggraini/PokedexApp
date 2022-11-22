//
//  PokemonListCollectionViewCell.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import UIKit

class MyPokemonCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "myPokemonCell"

    var pokemon: Pokemon?{
        didSet{
//            Task{ [weak self] in
//                guard let imageURL = URL(string: self?.pokemon?.sprite ?? "") else { return }
//                
//            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
