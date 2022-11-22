//
//  MyPokemonViewController.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 21/11/22.
//

import UIKit

class MyPokemonViewController: UIViewController {
    
    let nameLbl: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Welcome to My Pokémon!"
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(nameLbl)
        NSLayoutConstraint.activate([
            nameLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nameLbl.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "My Pokemon"
    }
}
