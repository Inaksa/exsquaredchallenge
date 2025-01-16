//
//  TagView.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 16/01/2025.
//

import SwiftUI

struct TagView: View {
    let tag: String
    var body: some View {
        Text(tag.uppercased())
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
    func GenerateTags(_ number: Int) -> [String] {
        var retValue: [String] = []
        for i in 0..<number {
            retValue.append("Tag \(String(repeating: "0", count: i))\(i)")
        }
        return retValue
    }

    return ScrollView {
        GeometryReader { geom in
            FlexibleView(availableWidth: geom.size.width, data: GenerateTags(20), spacing: 8, alignment: .leading) { elem in
                TagView(tag: elem)
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

