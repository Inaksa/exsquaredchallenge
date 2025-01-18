//
//  TagView.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 16/01/2025.
//

import SwiftUI

struct TagView: View {
    let tag: String
    var useFirstLetter: Bool = false

    var body: some View {
        Text(useFirstLetter ? String(tag.uppercased().first!) : tag.uppercased())
            .font(.footnote)
            .fontWeight(.light)
            .multilineTextAlignment(.center)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background {
                Capsule()
                    .fill(Color.random.opacity(0.3))
            }
    }
}

#Preview {
    let tags: [String] = ["Tag 0", "Tag 1", "Tag 2", "Tag 3", "Tag 4", "Tag 5", "Tag 6", "Tag 7", "Tag 8", "Tag 9"]

    ScrollView {
        GeometryReader { geom in
            FlexibleView(
                availableWidth: geom.size.width,
                data: tags,
                spacing: 8,
                alignment: .leading
            ) { elem in
                TagView(tag: elem, useFirstLetter: true)
            }
            .padding()
        }

    }

}

extension Color {
    static var random: Color {
        Color(.init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)))
    }
}

