//
//  PokemonEntity+CoreDataProperties.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 23/11/22.
//
//

import Foundation
import CoreData


extension PokemonEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonEntity> {
        return NSFetchRequest<PokemonEntity>(entityName: "PokemonEntity")
    }

    @NSManaged public var color: String?
    @NSManaged public var height: Int32
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var pokemonType: [String]?
    @NSManaged public var sprite: String?
    @NSManaged public var weight: Int32

}

extension PokemonEntity : Identifiable {

}
