//
//  CoreDataManager.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 23/11/22.
//

import CoreData

final class CoreDataManager{
    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func getAllMyPokemonEntity() -> [PokemonEntity]{
        let request: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        do{
            
            return try managedContext.fetch(request)
            
        }catch{
            
            return []
        }
    }
    
    func addPokemon(pokemon: Pokemon, nickName: String?){
        let pokemonCount = getAllMyPokemonEntity().count
        let myPokemon = PokemonEntity(context: managedContext)
       
        var index = 0
        if pokemonCount != 0{
            index = pokemonCount-1
        }

        myPokemon.id = Int32(index+1)
        myPokemon.name = nickName ?? pokemon.name
        
        var pokemonTypes: [String] = []
        
        if let unwrappedPokeTypes = pokemon.types{
            for pt in unwrappedPokeTypes {
                pokemonTypes.append(pt.name ?? "Pokemon Type")
            }
        }
        
        myPokemon.pokemonType = pokemonTypes
        myPokemon.sprite = pokemon.sprite?.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        myPokemon.weight = Int32(pokemon.weight ?? 0)
        myPokemon.height = Int32(pokemon.height ?? 0)
        myPokemon.color = ""
        myPokemon.pokedexID = Int32(pokemon.id ?? 0)
        
        saveContext()
    }
    
    func deletePokemon(pokemonEntity: PokemonEntity){
        
        managedContext.delete(pokemonEntity)
        
        saveContext()
    }
    
}
