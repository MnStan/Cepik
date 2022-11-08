//
//  ObservableObject.swift
//  Cepik
//
//  Created by Maksymilian Stan on 21/10/2022.
//

import Foundation

final class ObservableObject<T> {
    var value: T {
        didSet {
            for listener in listeners {
                listener?(value)
            }
        }
    }
    
    typealias Listener = ((T) -> Void)?
    private var listeners = [Listener]()
    
    init(value: T) {
        self.value = value
    }
    
    func bind(listener: Listener) {
        self.listeners.append(listener)
        for listener in listeners {
            listener?(value)
        }
    }
}
