//
//  DetailPokemonViewController.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 21/11/22.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    
    let viewModel = DetailPokemonViewModel()
    
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
    
    @objc let catchPokemonBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        btn.backgroundColor = .blue
        btn.tintColor = .black
        btn.setTitle("CATCH", for: .normal)
        btn.imageView?.image = UIImage(systemName: "circle.fill")
   
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let movesTV: UITableView = {
       let tv = UITableView()
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.title = (viewModel.pokemon.value as? Pokemon)?.name?.capitalized ?? "Detail Pokemon"
        self.view.backgroundColor = .systemBackground
        self.setupBinders()
        self.view.addSubview(pokemonIV)
        self.view.addSubview(bioView)
        self.view.addSubview(catchPokemonBtn)
        setupTableView()
        NSLayoutConstraint.activate([
            pokemonIV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            pokemonIV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 72),
            pokemonIV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -72),
            pokemonIV.heightAnchor.constraint(equalToConstant: self.view.frame.height / 4),
            
            catchPokemonBtn.topAnchor.constraint(equalTo: pokemonIV.bottomAnchor, constant: 4),
            catchPokemonBtn.widthAnchor.constraint(equalToConstant: 90),
            catchPokemonBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            bioView.topAnchor.constraint(equalTo: catchPokemonBtn.bottomAnchor, constant: 4),
            bioView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            bioView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            bioView.heightAnchor.constraint(equalToConstant: 176)
        ])
        
        catchPokemonBtn.addTarget(self, action: #selector(catchPokemon), for: .touchUpInside)
    }
    
    private func setupTableView(){
        
        self.view.addSubview(movesTV)
        
        NSLayoutConstraint.activate([
            movesTV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movesTV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movesTV.topAnchor.constraint(equalTo: bioView.bottomAnchor, constant: 24),
            movesTV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -82)
        ])
        
        movesTV.isScrollEnabled = true
        
        self.movesTV.dataSource = self
        self.movesTV.delegate = self
    }
    
    @objc private func catchPokemon(){
        print("catching pokemon...")
        let randomBool = Bool.random()
        guard let pokemon = viewModel.pokemon.value as? Pokemon else{
            return
        }
        if randomBool{
            print("Clara has caught \(pokemon.name ?? "Pokemon Name")")
        }else{
            print("\(pokemon.name ?? "Pokemon Name") Got Away")
        }
    }
    
    private func setupBinders(){
        
        viewModel.pokemon.bind{ [weak self] _ in
            let pokemon = self?.viewModel.pokemon.value as? Pokemon
            self?.pokemonIV.image = pokemon?.sprite
            self?.bioView.pokemon = pokemon
        }
  
        
    }
    
}

extension DetailPokemonViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = (viewModel.pokemon.value as? Pokemon)?.moves else { return 0 }
            
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoveCell") ?? UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "MoveCell")
        
        guard let pokemonMoves = (viewModel.pokemon.value as? Pokemon)?.moves else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.accessoryType = .none
        cell.textLabel?.text = pokemonMoves[indexPath.row].name
        cell.detailTextLabel?.text = "Learned at lvl \(pokemonMoves[indexPath.row].levelLearnedAt ?? 0)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .left
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Moves"
    }
}
