//
//  PokemonBioView.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 23/11/22.
//

import UIKit

class PokemonBioView: UIView {
    var pokemon: Pokemon? {
        didSet{
            idLbl.text = "#\(String(format: "%03d", pokemon?.id ?? 0))"
            heightView.height = Double(pokemon?.height ?? 0) / 10
            weightView.weight = Double(pokemon?.weight ?? 0) / 10
            
            if let unwrappedPokeType = pokemon?.types, let typeCount = pokemon?.types?.count, typeCount != 0{
                
                if typeCount == 1{
                    typeBgView2.pokemonType = unwrappedPokeType[0]
                    typeBgView2.isHidden = false
                    
                }else{
                    
                    for i in 0..<typeCount{
                        switch i{
                        case 0:
                            typeBgView.pokemonType = unwrappedPokeType[i]
                            typeBgView.isHidden = false
                            
                        case 1:
                            typeBgView3.pokemonType = unwrappedPokeType[i]
                            typeBgView3.isHidden = false
                            
                        case 2:
                            typeBgView2.pokemonType = unwrappedPokeType[i]
                            typeBgView2.isHidden = false
                            
                        default:
                            break
                        }
                    }
                }
                 
            }
        }
    }
    let idLbl: UILabel = {
        var lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let typeBgView: PokemonTypeView = {
        let view = PokemonTypeView(frame: CGRect(x: 0, y: 0, width: 92, height: 32))
        view.size = .big
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let typeBgView2: PokemonTypeView = {
        let view = PokemonTypeView()
        view.size = .big
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let typeBgView3: PokemonTypeView = {
        let view = PokemonTypeView()
        view.size = .big
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let stackView: UIStackView = {
        let hStack = UIStackView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        hStack.axis = .horizontal
        hStack.backgroundColor = .green
        hStack.distribution = .fillProportionally
        hStack.alignment = .center
        hStack.spacing = 8.0
        return hStack
    }()
    
    let heightView: HeightWeightWrapperView = {
        let hView = HeightWeightWrapperView()
        hView.bodyInfoType = .height
        hView.translatesAutoresizingMaskIntoConstraints = false
        return hView
    }()
    
    let weightView: HeightWeightWrapperView = {
        let wView = HeightWeightWrapperView()
        wView.bodyInfoType = .weight
        wView.translatesAutoresizingMaskIntoConstraints = false
        return wView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(idLbl)
        self.addSubview(heightView)
        self.addSubview(weightView)
        self.layer.cornerRadius = 12
        
        self.addSubview(typeBgView)

        self.addSubview(typeBgView2)

        self.addSubview(typeBgView3)
        
        NSLayoutConstraint.activate([
            idLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            idLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            idLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            heightView.topAnchor.constraint(equalTo: idLbl.bottomAnchor, constant: 16),
            heightView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 65),
            
            weightView.topAnchor.constraint(equalTo: idLbl.bottomAnchor, constant: 16),
            weightView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -65),
            
            typeBgView.heightAnchor.constraint(equalToConstant: 32),
            typeBgView2.heightAnchor.constraint(equalToConstant: 32),
            typeBgView3.heightAnchor.constraint(equalToConstant: 32),
            typeBgView.widthAnchor.constraint(equalToConstant: 88),
            typeBgView2.widthAnchor.constraint(equalToConstant: 88),
            typeBgView3.widthAnchor.constraint(equalToConstant: 88),
            
            typeBgView.leadingAnchor.constraint(equalTo:  self.leadingAnchor, constant: 34),
            typeBgView.bottomAnchor.constraint(equalTo:  self.bottomAnchor, constant: -16),
            typeBgView2.centerXAnchor.constraint(equalTo:  self.centerXAnchor),
            typeBgView2.bottomAnchor.constraint(equalTo:  self.bottomAnchor, constant: -16),
            typeBgView3.trailingAnchor.constraint(equalTo:  self.trailingAnchor, constant: -34),
            typeBgView3.bottomAnchor.constraint(equalTo:  self.bottomAnchor, constant: -16),
            
          
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HeightWeightWrapperView: UIView{
    
    enum BodyInfoType{
        case height
        case weight
    }
    
    var bodyInfoType: BodyInfoType = .height
    
    let valLbl: UILabel = {
        var lbl = UILabel()
        lbl.text = "0.0"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let subtitleLbl: UILabel = {
        var lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = "Body Info Type"
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var height: Double = 0.0 {
        didSet{
            valLbl.text = "\(String(describing: height)) M"
            subtitleLbl.text = "Height"
        }
    }
    var weight: Double = 0.0 {
        didSet{
            valLbl.text = "\(String(describing: weight)) KG"
            subtitleLbl.text = "Weight"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(valLbl)
        self.addSubview(subtitleLbl)
        
        NSLayoutConstraint.activate([
            self.valLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.valLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.valLbl.topAnchor.constraint(equalTo: self.topAnchor),
            
            self.subtitleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.subtitleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.subtitleLbl.topAnchor.constraint(equalTo: self.valLbl.bottomAnchor, constant: 8),
            self.subtitleLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
