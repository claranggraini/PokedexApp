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
            
            if let unwrappedPokeType = pokemon?.types?[0]{
                typeBgView.pokemonType = unwrappedPokeType
                typeBgView.isHidden = false
            }
            if let unwrappedPokeType = pokemon?.types?[1]{
                typeBgView2.pokemonType = unwrappedPokeType
                typeBgView2.isHidden = false
            }
            if let unwrappedPokeType = pokemon?.types?[2]{
                typeBgView3.pokemonType = unwrappedPokeType
                typeBgView3.isHidden = false
            }
            
        }
    }
    
    let pokemonIV: UIImageView = {
        var iv = UIImageView()
        iv.backgroundColor = .green
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameLbl: UILabel = {
       let lbl = UILabel()
        lbl.text = "Poke Name"
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let typeBgView: PokemonTypeView = {
        let view = PokemonTypeView()
        view.size = .small
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let typeBgView2: PokemonTypeView = {
        let view = PokemonTypeView()
        view.size = .small
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let typeBgView3: PokemonTypeView = {
        let view = PokemonTypeView()
        view.size = .small
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(pokemonIV)
        self.contentView.addSubview(nameLbl)
        
        self.contentView.addSubview(typeBgView)
        self.contentView.addSubview(typeBgView2)
        self.contentView.addSubview(typeBgView3)
        
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 1
        self.contentView.layer.shadowOffset = .zero
        self.contentView.layer.shadowRadius = 5
        self.contentView.layer.masksToBounds = false
        self.contentView.layer.backgroundColor = UIColor.blue.cgColor
        
        NSLayoutConstraint.activate([
            pokemonIV.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            pokemonIV.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            pokemonIV.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            pokemonIV.widthAnchor.constraint(equalToConstant: self.contentView.frame.width / 2),
            pokemonIV.heightAnchor.constraint(equalToConstant: self.contentView.frame.height-32),
            
            nameLbl.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            nameLbl.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24),
            nameLbl.trailingAnchor.constraint(equalTo: pokemonIV.leadingAnchor, constant: 0),
            
            typeBgView.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 16),
            typeBgView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            typeBgView2.topAnchor.constraint(equalTo: typeBgView.bottomAnchor, constant: 8),
            typeBgView2.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            typeBgView3.topAnchor.constraint(equalTo: typeBgView2.bottomAnchor, constant: 8),
            typeBgView3.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
          
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
