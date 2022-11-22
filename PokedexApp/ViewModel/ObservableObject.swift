//
//  ObservableObject.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import Foundation

final class ObservableObject<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    private var observer: ((T?) -> Void)?
    
    init(_ value: T?){
        self.value = value
    }
    
    func bind(_ observer: @escaping(T?) -> Void) {
        observer(value)
        self.observer = observer
    }
}
