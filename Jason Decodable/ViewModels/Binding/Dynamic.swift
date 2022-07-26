//
//  Dynamic.swift
//  Jason Decodable
//
//  Created by Daniel Tvorun on 17.07.2022.
//

class Dynamic<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    public var value: T {
        didSet {
            listener?(value)
        }
    }
    
    public init(_ v: T) {
        value = v
    }
    
    public func bind(_ listener: Listener?) {
        self.listener = listener
    }
}
