//
//  PokemonListTableViewCell.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import UIKit

class PokemonListTableViewCell: UITableViewCell {

    static let identifier = "PokemonListCell"
    
    var pokemon: Pokemon?{
        didSet{
            pokemonIV.image = pokemon?.sprite
            let idString = String(format: "%03d", pokemon?.id ?? 0)
            pokemonIdLabel.text = "#\(idString)"
            pokemonNameLabel.text = pokemon?.name?.capitalized ?? "PokemonName"
            
            if pokemon?.wasCaught ?? false{
                pokeballIV.isHidden = false
            }
        }
    }
    
    var pokemonIV: UIImageView = {
        var iv = UIImageView()
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var pokemonIdLabel: UILabel = {
       var lbl = UILabel()
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.sizeToFit()
        return lbl
    }()
    
    var pokemonNameLabel: UILabel = {
       var lbl = UILabel()
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.sizeToFit()
        return lbl
    }()
    
    var pokeballIV: UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "myPokemon-icon")
        iv.tintColor = .red
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isHidden = true
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(pokemonIV)
        self.contentView.addSubview(pokemonIdLabel)
        self.contentView.addSubview(pokemonNameLabel)
        self.contentView.addSubview(pokeballIV)
        
        NSLayoutConstraint.activate([
            pokemonIV.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            pokemonIV.widthAnchor.constraint(equalToConstant: 97),
            pokemonIV.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            pokemonIV.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            pokemonIdLabel.leadingAnchor.constraint(equalTo: pokemonIV.trailingAnchor, constant: 16),
            pokemonIdLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            pokemonNameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: pokemonIdLabel.trailingAnchor, constant: 8),
            pokeballIV.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 48),
            pokeballIV.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -48),
            pokeballIV.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            
            pokeballIV.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
