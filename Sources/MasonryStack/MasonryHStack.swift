//
//  MasonryHStack.swift
//  MasonryStack
//
//  Created by Lukas Pistrol on 25.08.23.
//

import SwiftUI

public struct MasonryHStack: Layout {

    private var rows: Int
    private var spacing: Double

    init(rows: Int = 2, spacing: Double = 8.0) {
        self.rows = rows
        self.spacing = spacing
    }

    public func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        return calculateSize(for: subviews, in: proposal)
    }

    public func placeSubviews(
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
        guard let maxHeight = proposal.height else { return .zero }
        let itemHeight = (maxHeight - spacing * Double(rows - 1)) / Double(rows)

        var yIndex: Int = 0
        var rowsWidths: [Double] = Array(repeating: bounds?.minX ?? 0, count: rows)

        subviews.forEach { view in
            let proposed = ProposedViewSize(
                width: view.sizeThatFits(.unspecified).width,
                height: itemHeight
            )

            if let bounds {
                let y = (itemHeight + spacing) * Double(yIndex) + bounds.minY
                view.place(
                    at: .init(x: rowsWidths[yIndex], y: y),
                    anchor: .topLeading,
                    proposal: proposed
                )
            }

            let width = view.dimensions(in: proposed).width
            rowsWidths[yIndex] += width + spacing
            let minimum = rowsWidths.enumerated().min {
                $0.element < $1.element
            }?.offset ?? 0
            yIndex = minimum
        }

        guard let maxWidth = rowsWidths.max() else { return .zero }

        return .init(
            width: maxWidth - spacing,
            height: maxHeight

        )
    }

    public static var layoutProperties: LayoutProperties {
        var properties = LayoutProperties()
        properties.stackOrientation = .horizontal
        return properties
    }

}
