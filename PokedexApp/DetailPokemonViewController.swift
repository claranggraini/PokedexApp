//
//  DetailPokemonViewController.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 21/11/22.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    var pokemon: Pokemon?
    
    let nameLbl: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Welcome to Detail Pokemon!"
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = pokemon?.name?.capitalized ?? "Detail Pokemon"
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(nameLbl)
        NSLayoutConstraint.activate([
            nameLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nameLbl.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            
        ])
        
    }
    
}
