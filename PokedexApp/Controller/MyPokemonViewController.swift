//
//  MyPokemonViewController.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 21/11/22.
//

import UIKit

class MyPokemonViewController: UIViewController {

    let viewModel = MyPokemonViewModel()
    
    lazy var pokemonCV: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupBinders()
        self.setupCollectionView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editPokemon))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "My Pokemon"
        viewModel.fetchPokemonData()
    }
    
    func setupCollectionView(){
        view.addSubview(pokemonCV)
        pokemonCV.isUserInteractionEnabled = true
        pokemonCV.allowsMultipleSelectionDuringEditing = true
        
        pokemonCV.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        NSLayoutConstraint.activate([
            pokemonCV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonCV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonCV.topAnchor.constraint(equalTo: view.topAnchor),
            pokemonCV.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        pokemonCV.delegate = self
        pokemonCV.dataSource = self
        
        pokemonCV.register(MyPokemonCollectionViewCell.self, forCellWithReuseIdentifier: MyPokemonCollectionViewCell.identifier)
    }
    
    private func setupBinders(){
        
        viewModel.pokemonEntity.bind{ [weak self] _ in
            
                self?.pokemonCV.reloadData()

        }
        
    }
    
    @objc func editPokemon(){
        
        if isEditing{
            self.isEditing = false
            pokemonCV.reloadData()
        }else{
            self.isEditing = true
            pokemonCV.reloadData()
            self.navigationItem.setRightBarButton(UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(deletePokemon)), animated: true)
        }
        
    }
    
    @objc func deletePokemon(){
        pokemonCV.reloadData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editPokemon))
        self.isEditing = false
    }
}

extension MyPokemonViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = viewModel.pokemonEntity.value as? [PokemonEntity] else {return 0}
        return data.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = pokemonCV.dequeueReusableCell(withReuseIdentifier: MyPokemonCollectionViewCell.identifier, for: indexPath) as? MyPokemonCollectionViewCell else {return UICollectionViewCell()}
        
        guard let unwrappedEntities = viewModel.pokemonEntity.value as? [PokemonEntity] else {return UICollectionViewCell()}
        
        cell.pokemonEntity = unwrappedEntities[indexPath.row]
        
        if isEditing{
            cell.deleteBtn.isHidden = false
            
        }else{
            cell.deleteBtn.isHidden = true
        }
        
        cell.deletePokemon = { [weak self] in
            
            self?.viewModel.deletePokemonData(toBeDeletedPokemonEntity: unwrappedEntities[indexPath.row])
            self?.viewModel.fetchPokemonData()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let width  = view.frame.width / 2 - 16
        let height = (view.frame.height)/4 - 32
        return CGSize(width: width, height: height)
    }
       
}
