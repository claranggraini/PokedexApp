//
//  DetailPokemonViewController.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 21/11/22.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    var pokemon: Pokemon?{
        didSet{
            pokemonIV.image = pokemon?.sprite
            bioView.pokemon = pokemon
        }
    }
    
//    let nameLbl: UILabel = {
//       let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.text = "Welcome to Detail Pokemon!"
//        return lbl
//    }()
    
    let pokemonIV: UIImageView = {
       let iv = UIImageView()
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let bioView: PokemonBioView = {
        let bView = PokemonBioView()
        bView.clipsToBounds = true
        bView.backgroundColor = .lightGray
        bView.layer.opacity = 2
        bView.translatesAutoresizingMaskIntoConstraints = false
        return bView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = pokemon?.name?.capitalized ?? "Detail Pokemon"
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(pokemonIV)
        self.view.addSubview(bioView)
        
        NSLayoutConstraint.activate([
            pokemonIV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            pokemonIV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 72),
            pokemonIV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -72),
            pokemonIV.heightAnchor.constraint(equalToConstant: self.view.frame.height / 4),
            bioView.topAnchor.constraint(equalTo: pokemonIV.bottomAnchor, constant: 24),
            bioView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            bioView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            bioView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
}
