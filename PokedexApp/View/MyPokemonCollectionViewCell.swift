//
//  PokemonListCollectionViewCell.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import UIKit

class MyPokemonCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "myPokemonCell"

    var pokemonEntity: PokemonEntity?{
        didSet{
           
            nameLbl.text = pokemonEntity?.name?.capitalized
            if let decodedData = Data(base64Encoded: pokemonEntity?.sprite ?? "") {
                pokemonIV.image = UIImage(data: decodedData)
            }
            
            if let unwrappedPokeType = pokemonEntity?.pokemonType, let typeCount = pokemonEntity?.pokemonType?.count, typeCount != 0{
                for i in 0..<typeCount{
                    switch i{
                    case 0:
                        typeBgView.pokemonType = PokemonType(name: unwrappedPokeType[i])
                        
                        typeBgView.isHidden = false
                    case 1:
                        typeBgView2.pokemonType = PokemonType(name: unwrappedPokeType[i])
                    
                        typeBgView2.isHidden = false
                    case 2:
                        typeBgView3.pokemonType = PokemonType(name: unwrappedPokeType[i])
                        
                        typeBgView3.isHidden = false
                    default:
                        break
                    }
                }
                
            }
            
        }
    }
    
    let pokemonIV: UIImageView = {
        var iv = UIImageView()
        iv.backgroundColor = .green
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameLbl: UILabel = {
       let lbl = UILabel()
        lbl.text = "Poke Name"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let typeBgView: PokemonTypeView = {
        let view = PokemonTypeView()
        view.size = .small
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let typeBgView2: PokemonTypeView = {
        let view = PokemonTypeView()
        view.size = .small
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let typeBgView3: PokemonTypeView = {
        let view = PokemonTypeView()
        view.size = .small
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let containerView: UIView = {
       let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        v.backgroundColor = .white
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(pokemonIV)
        self.contentView.addSubview(nameLbl)
        
        self.contentView.addSubview(typeBgView)
        self.contentView.addSubview(typeBgView2)
        self.contentView.addSubview(typeBgView3)
        
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.4
        self.contentView.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.contentView.layer.shadowRadius = 3
        self.contentView.layer.masksToBounds = false
        self.contentView.layer.backgroundColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            pokemonIV.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -4),
            pokemonIV.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24),
            pokemonIV.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -24),
            pokemonIV.widthAnchor.constraint(equalToConstant: self.contentView.frame.width / 2),
            
            nameLbl.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            nameLbl.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24),
            nameLbl.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            
            typeBgView.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 16),
            typeBgView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            typeBgView2.topAnchor.constraint(equalTo: typeBgView.bottomAnchor, constant: 8),
            typeBgView2.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            typeBgView3.topAnchor.constraint(equalTo: typeBgView2.bottomAnchor, constant: 8),
            typeBgView3.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
          
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
