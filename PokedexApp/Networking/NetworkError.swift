//
//  NetworkError.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import Foundation

enum URLError: LocalizedError{
    case unauthorized
    case invalidResponse
    case decoding
    case underlying(Error)
}
