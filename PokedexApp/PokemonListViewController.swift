//
//  ViewController.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 21/11/22.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    var didSendEventClosure: ((PokemonListViewController.Event) -> Void)?
    let viewModel = PokemonListViewViewModel()
    
    let nameLbl: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Welcome to Pokedex!"
        return lbl
    }()

    let detailBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Go to Detail", for: .normal)
        btn.backgroundColor = .red
        btn.tintColor = .systemBlue
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupBinders()
        Task{
            await viewModel.fetchPokemonListData()
            await viewModel.fetchPokemonDetailData()
        }
        self.view.addSubview(nameLbl)
        self.view.addSubview(detailBtn)
        NSLayoutConstraint.activate([
            nameLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nameLbl.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            detailBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            detailBtn.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 16),
            detailBtn.heightAnchor.constraint(equalToConstant: 50),
            detailBtn.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        detailBtn.addTarget(self, action: #selector(didTapDetailBtn(_ :)), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Discover"
    }
    
    @objc private func didTapDetailBtn (_ sender: Any){
        didSendEventClosure?(.detail)
    }
    
    deinit {
        print("pokemonListViewController deinit")
    }
    
    private func setupBinders(){
        
    }

}

extension PokemonListViewController{
    enum Event{
        case detail
    }
}

