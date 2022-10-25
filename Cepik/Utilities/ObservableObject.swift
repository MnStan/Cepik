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
            listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    
    init(value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping(T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
