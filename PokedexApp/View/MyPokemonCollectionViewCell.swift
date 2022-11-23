//
//  PokemonListCollectionViewCell.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import UIKit

class MyPokemonCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "myPokemonCell"

    var pokemon: Pokemon?{
        didSet{
            
            
        }
    }
    
    var pokemonIV: UIImageView = {
        var iv = UIImageView()
        iv.backgroundColor = .green
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameLbl: UILabel = {
       let lbl = UILabel()
        lbl.text = "Fletchinder"
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let typeBgView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = false
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let typeBgView2: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = false
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.isHidden = true
        return view
    }()
    
    let typeBgView3: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = false
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.isHidden = true
        return view
    }()
    
    let typeLbl: UILabel = {
        let lbl = UILabel ()
        lbl.text = "Psychic"
        lbl.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        lbl.clipsToBounds = true
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let typeLbl2: UILabel = {
        let lbl = UILabel ()
        lbl.text = "Flying"
        lbl.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        lbl.clipsToBounds = true
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let typeLbl3: UILabel = {
        let lbl = UILabel ()
        lbl.text = "Dragon"
        lbl.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        lbl.clipsToBounds = true
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let containerView: UIView = {
        let conView = UIView()

        conView.layer.cornerRadius = 10
        conView.layer.shadowColor = UIColor.black.cgColor
        conView.layer.shadowOpacity = 1
        conView.layer.shadowOffset = .zero
        conView.layer.shadowRadius = 10
        return conView
    }()
//
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(pokemonIV)
        self.contentView.addSubview(nameLbl)
        self.typeBgView.addSubview(typeLbl)
        self.contentView.addSubview(typeBgView)
        self.typeBgView2.addSubview(typeLbl2)
        self.contentView.addSubview(typeBgView2)
        self.typeBgView3.addSubview(typeLbl3)
        self.contentView.addSubview(typeBgView3)
        
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 1
        self.contentView.layer.shadowOffset = .zero
        self.contentView.layer.shadowRadius = 5
        self.contentView.layer.masksToBounds = false
        self.contentView.layer.backgroundColor = UIColor.blue.cgColor
        
        NSLayoutConstraint.activate([
            pokemonIV.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            pokemonIV.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            pokemonIV.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            pokemonIV.widthAnchor.constraint(equalToConstant: self.contentView.frame.width / 2),
            pokemonIV.heightAnchor.constraint(equalToConstant: self.contentView.frame.height-32),
            nameLbl.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            nameLbl.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24),
            nameLbl.trailingAnchor.constraint(equalTo: pokemonIV.leadingAnchor, constant: 0),
            typeBgView.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 16),
            typeBgView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            typeLbl.topAnchor.constraint(equalTo: typeBgView.topAnchor, constant: 4),
            typeLbl.bottomAnchor.constraint(equalTo: typeBgView.bottomAnchor, constant: -4),
            typeLbl.leadingAnchor.constraint(equalTo: typeBgView.leadingAnchor, constant: 8),
            typeLbl.trailingAnchor.constraint(equalTo: typeBgView.trailingAnchor, constant: -8),
            
            typeBgView2.topAnchor.constraint(equalTo: typeBgView.bottomAnchor, constant: 8),
            typeBgView2.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            
            typeLbl2.topAnchor.constraint(equalTo: typeBgView2.topAnchor, constant: 4),
            typeLbl2.bottomAnchor.constraint(equalTo: typeBgView2.bottomAnchor, constant: -4),
            typeLbl2.leadingAnchor.constraint(equalTo: typeBgView2.leadingAnchor, constant: 8),
            typeLbl2.trailingAnchor.constraint(equalTo: typeBgView2.trailingAnchor, constant: -8),
            
            typeBgView3.topAnchor.constraint(equalTo: typeBgView2.bottomAnchor, constant: 8),
            typeBgView3.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            
            typeLbl3.topAnchor.constraint(equalTo: typeBgView3.topAnchor, constant: 4),
            typeLbl3.bottomAnchor.constraint(equalTo: typeBgView3.bottomAnchor, constant: -4),
            typeLbl3.leadingAnchor.constraint(equalTo: typeBgView3.leadingAnchor, constant: 8),
            typeLbl3.trailingAnchor.constraint(equalTo: typeBgView3.trailingAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
