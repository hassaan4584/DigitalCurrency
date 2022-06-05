//
//  Observable.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import Foundation

public final class Observable<Value> {

    struct Observer<Value> {
        weak var observer: AnyObject?
        let block: (Value) -> Void
    }

    private var observers = [Observer<Value>]()

    public var value: Value {
        didSet { notifyObservers() }
    }

    public init(_ value: Value) {
        self.value = value
    }

    public func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
        observers.append(Observer(observer: observer, block: observerBlock))
    }

    public func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }

    private func notifyObservers() {
        for observer in observers {
            DispatchQueue.main.async { observer.block(self.value) }
        }
    }
}
