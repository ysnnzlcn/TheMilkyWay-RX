//
//  BaseDiffableDataSource.swift
//  
//
//  Created by Yasin Nazlican on 19.11.2021.
//

import UIKit

open class BaseDiffableDataSource<T>: UITableViewDiffableDataSource<
    BaseDiffableDataSource.Section,
    BaseDiffableDataSource.Item
> {

    // MARK: Public Methods

    open func update(sections: [Section], animating: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        sections.forEach { snapshot.appendItems($0.items, toSection: $0) }
        apply(snapshot, animatingDifferences: animating)
    }

    open func update(items: [Item], animating: Bool = false) {
        let section = Section(items: items)
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([section])
        snapshot.appendItems(section.items)
        apply(snapshot, animatingDifferences: animating)
    }
}

extension BaseDiffableDataSource {

    public struct Item: Hashable {

        private let identifier = UUID()
        public let cell: T

        public init(cell: T) {
            self.cell = cell
        }

        public static func == (lhs: Item, rhs: Item) -> Bool {
            lhs.identifier == rhs.identifier
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    public struct Section: Hashable {

        private let identifier = UUID()
        public let items: [Item]

        public init(items: [Item]) {
            self.items = items
        }
    }
}
