//
//  ViewController.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 21/11/22.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    var didSendEventClosure: ((PokemonListViewController.Event,
                              Pokemon) -> Void)?
    let viewModel = PokemonListViewModel()
    var loadingIndicator: UIView?
    
    let pokemonTableView: UITableView = {
        let tv = UITableView()
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupTableView()
        self.setupBinders()
        self.showLoadingIndicator(onView: self.view)
        Task{
            await viewModel.fetchPokemonListData()
            await viewModel.fetchPokemonDetailData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Pokedex"
    }

    deinit {
        print("pokemonListViewController deinit")
    }
    
    private func setupBinders(){
        
        viewModel.pokemons.bind{ _ in
            
            DispatchQueue.main.async { [weak self] in
                self?.pokemonTableView.reloadData()
            }
        }
        
        viewModel.isLoading.bind{[weak self] isLoading in
            DispatchQueue.main.async {
                if let loading = isLoading as? Bool, loading == false{
                    self?.removeLoadingIndicator()
                }
            }
           
        }
        
        viewModel.errorAlert.bind{ [weak self] errorAlert in
            DispatchQueue.main.async {
                if let showAlert = errorAlert{
                    self?.showErrorAlert(error: showAlert ?? "")
                }
            }
            
        }
        
    }
    
    private func setupTableView(){
        
        self.view.addSubview(pokemonTableView)
        
        NSLayoutConstraint.activate([
            pokemonTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonTableView.topAnchor.constraint(equalTo: view.topAnchor),
            pokemonTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        pokemonTableView.isScrollEnabled = true
        pokemonTableView.register(PokemonListTableViewCell.self, forCellReuseIdentifier: PokemonListTableViewCell.identifier)
        
        self.pokemonTableView.dataSource = self
        self.pokemonTableView.delegate = self
    }
    
    func showErrorAlert(error: String){
        
        let errorMsg = "\(error) Please contact pokemon@gamefreak.com for customer support."
        let alert = UIAlertController(title: "Found Error", message: errorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            
        }))
                
        self.present(alert, animated: true, completion: nil)
    }

}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let data = viewModel.pokemons.value as? [Pokemon] else {
            return 0}
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = pokemonTableView.dequeueReusableCell(withIdentifier: PokemonListTableViewCell.identifier, for: indexPath) as? PokemonListTableViewCell else { return UITableViewCell() }
        guard let unwrappedPokemon = viewModel.pokemons.value as? [Pokemon] else { return UITableViewCell()}
        cell.pokemon = unwrappedPokemon[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 127
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pokemons = viewModel.pokemons.value as? [Pokemon] else { return }
        didSendEventClosure?(.detail, pokemons[indexPath.row])
    }
   
}

extension PokemonListViewController{
    enum Event{
        case detail
    }
    
    func showLoadingIndicator(onView: UIView){
        let indicatorView = UIView.init(frame: onView.bounds)
        indicatorView.backgroundColor = .white
        let activityIndicatorView = UIActivityIndicatorView.init(style: .large)
        activityIndicatorView.color = .black
        activityIndicatorView.startAnimating()
        activityIndicatorView.center = indicatorView.center
        
        DispatchQueue.main.async {
            indicatorView.addSubview(activityIndicatorView)
            onView.addSubview(indicatorView)
        }
        
        self.loadingIndicator = indicatorView
    }
    
    func removeLoadingIndicator(){
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator?.removeFromSuperview()
            self?.loadingIndicator = nil
        }
    }
}
