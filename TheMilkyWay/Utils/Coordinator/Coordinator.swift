//
//  Coordinator.swift
//  TheMilkyWay
//
//  Created by Yasin Nazlican on 17.11.2021.
//

import Foundation

public class Coordinator {

    public private(set) var childCoordinators: [Coordinator] = []

    public func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    public func finish() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }

    public func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    public func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        } else {
            print("Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
        }
    }

    public func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }

    public func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}

extension Coordinator: Equatable {

    public static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}
