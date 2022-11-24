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
        bView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        bView.translatesAutoresizingMaskIntoConstraints = false
        return bView
    }()
    
    let movesTV: UITableView = {
       let tv = UITableView()
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Catch", style: .plain, target: self, action: #selector(catchPokemon))
        self.title = (viewModel.pokemon.value as? Pokemon)?.name?.capitalized ?? "Detail Pokemon"
        self.view.backgroundColor = .systemBackground
        self.setupBinders()
        self.view.addSubview(pokemonIV)
        self.view.addSubview(bioView)
        
        setupTableView()
        NSLayoutConstraint.activate([
            pokemonIV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            pokemonIV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 72),
            pokemonIV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -72),
            pokemonIV.heightAnchor.constraint(equalToConstant: self.view.frame.height / 4),
        
            bioView.topAnchor.constraint(equalTo: pokemonIV.bottomAnchor, constant: 4),
            bioView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            bioView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            bioView.heightAnchor.constraint(equalToConstant: 176)
        ])
    }
    
    private func setupTableView(){
        
        self.view.addSubview(movesTV)
        
        NSLayoutConstraint.activate([
            movesTV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movesTV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movesTV.topAnchor.constraint(equalTo: bioView.bottomAnchor, constant: 24),
            movesTV.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        movesTV.isScrollEnabled = true
        
        self.movesTV.dataSource = self
        self.movesTV.delegate = self
    }
    
    @objc private func catchPokemon(){
        
        guard let pokemon = viewModel.pokemon.value as? Pokemon else{
            return
        }
        
        let catchPokemonVC = CatchPokemonViewController()
        catchPokemonVC.viewModel.pokemon.value = pokemon
        catchPokemonVC.modalPresentationStyle = .fullScreen
        catchPokemonVC.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.pushViewController(catchPokemonVC, animated: true)
        
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
        cell.textLabel?.text = pokemonMoves[indexPath.row].name?.replacingOccurrences(of: "-", with: " ").capitalized
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
