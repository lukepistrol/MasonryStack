//
//  MasonryVStack.swift
//  MasonryStack
//
//  Created by Lukas Pistrol on 25.08.23.
//

import SwiftUI

struct MasonryVStack: Layout {

    var columns: Int = 2
    var spacing: Double = 8

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        return calculateSize(for: subviews, in: proposal)
    }
    
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        calculateSize(for: subviews, in: proposal, placeInBounds: bounds)
    }

    @discardableResult
    private func calculateSize(
        for subviews: Subviews,
        in proposal: ProposedViewSize,
        placeInBounds bounds: CGRect? = nil
    ) -> CGSize {
        guard let maxWidth = proposal.width else { return .zero }
        let itemWidth = (maxWidth - spacing * Double(columns - 1)) / Double(columns)

        var xIndex: Int = 0
        var columnsHeights: [Double] = Array(repeating: bounds?.minY ?? 0, count: columns)

        subviews.forEach { view in
            let proposed = ProposedViewSize(
                width: itemWidth,
                height: view.sizeThatFits(.unspecified).height
            )

            if let bounds {
                let x = (itemWidth + spacing) * Double(xIndex) + bounds.minX
                view.place(
                    at: .init(x: x, y: columnsHeights[xIndex]),
                    anchor: .topLeading,
                    proposal: proposed
                )
            }

            let height = view.dimensions(in: proposed).height
            columnsHeights[xIndex] += height + spacing
            let minimum = columnsHeights.enumerated().min {
                $0.element < $1.element
            }?.offset ?? 0
            xIndex = minimum
        }

        guard let maxHeight = columnsHeights.max() else { return .zero }

        return .init(
            width: maxWidth,
            height: maxHeight - spacing

        )
    }

    static var layoutProperties: LayoutProperties {
        var properties = LayoutProperties()
        properties.stackOrientation = .vertical
        return properties
    }

}
