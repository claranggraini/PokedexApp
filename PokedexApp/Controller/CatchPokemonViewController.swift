//
//  CatchPokemonView.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 24/11/22.
//

import Foundation
import UIKit

class CatchPokemonViewController: UIViewController {

    var viewModel = CatchPokemonViewModel()
    
    var didSendEventClosure: ((CatchPokemonViewController.Event,
                              Pokemon) -> Void)?
    
    let pokemonIV: UIImageView = {
       let iv = UIImageView()
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLbl: UILabel = {
       let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let captionLbl: UILabel = {
       let lbl = UILabel()
        lbl.clipsToBounds = true
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let nickNameTextField: UITextField = {
        let textF = UITextField()
        textF.sizeToFit()
        textF.translatesAutoresizingMaskIntoConstraints = false
        textF.isHidden = true
        textF.textColor = .black
        textF.borderStyle = .line
        return textF
    }()
    
    let submitBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        btn.backgroundColor = .systemBlue
        btn.setTitle("OK", for: .normal)
        btn.layer.cornerRadius = 12
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(titleLbl)
        self.view.addSubview(pokemonIV)
        self.view.addSubview(captionLbl)
        self.view.addSubview(nickNameTextField)
        self.view.addSubview(submitBtn)
        submitBtn.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        setupBinders()
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            titleLbl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            titleLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            pokemonIV.topAnchor.constraint(equalTo: titleLbl.bottomAnchor),
            pokemonIV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 72),
            pokemonIV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -72),
            pokemonIV.heightAnchor.constraint(equalToConstant: self.view.frame.height / 4),
            captionLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            captionLbl.topAnchor.constraint(equalTo: self.pokemonIV.bottomAnchor, constant: 24),
            captionLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            nickNameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            nickNameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            nickNameTextField.topAnchor.constraint(equalTo: captionLbl.bottomAnchor, constant: 24),
            submitBtn.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 24),
            submitBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            submitBtn.widthAnchor.constraint(equalToConstant: 132),
            submitBtn.heightAnchor.constraint(equalToConstant: 44)
            
        ])
        
    }
    
    private func setupBinders(){
        
        viewModel.pokemon.bind({ [weak self] p in
            guard let unwrappedPokemon = p as? Pokemon else { return }
            guard let catchResult = self?.viewModel.catchPokemon() else {return}
            self?.viewModel.catchResult.value = catchResult
            self?.pokemonIV.image = unwrappedPokemon.sprite
            
            if catchResult{
                self?.titleLbl.text = "You caught a Pokemon!"
                
                self?.captionLbl.text = "Give your pokemon a nickname"
                self?.nickNameTextField.placeholder = unwrappedPokemon.name
                self?.nickNameTextField.isHidden = false
                
            }else{
                
                self?.titleLbl.text = "\(unwrappedPokemon.name?.capitalized ?? "Pokemon Name") got away"
                self?.captionLbl.text = "Better Luck Next Time!"
            }
        })
    }
    
    func showErrorAlert(){
        
        let errorMsg = "Max character for nickname is only 11 characters."
        let alert = UIAlertController(title: "Failed to Give Nickname", message: errorMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            
        }))
                
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func didTapSubmit(){
        let error = viewModel.checkNicknameMaxChar(nickname: nickNameTextField.text ?? "")
        guard let catchResult = viewModel.catchResult.value as? Bool else { return }
        
        if error{
            self.showErrorAlert()
        }else if !catchResult{
            self.navigationController?.popViewController(animated: true)
        }else{
            guard let poke = self.viewModel.pokemon.value as? Pokemon else {return}
            guard let nicknameTF = self.nickNameTextField.text else{ return }
            var nickName = ""
            if nicknameTF.isEmpty{
                nickName = poke.name ?? ""
            }
            self.viewModel.saveCaughtPokemon(pokemon: poke, nickName: nickName)
            didSendEventClosure?(.didCatchPokemon, poke)
        }
    }
}

extension CatchPokemonViewController{
    enum Event{
        case didCatchPokemon
    }
}
