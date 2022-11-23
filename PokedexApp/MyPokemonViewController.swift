//
//  MyPokemonViewController.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 21/11/22.
//

import UIKit

class MyPokemonViewController: UIViewController {

    
    lazy var pokemonCV: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "My Pokemon"
    }
    
    func setupCollectionView(){
        view.addSubview(pokemonCV)
        
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
}

extension MyPokemonViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = pokemonCV.dequeueReusableCell(withReuseIdentifier: MyPokemonCollectionViewCell.identifier, for: indexPath) as? MyPokemonCollectionViewCell else {return UICollectionViewCell()}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let width  = view.frame.width / 2 - 16
        let height = (view.frame.height)/4 - 32
        return CGSize(width: width, height: height)
    }
}
