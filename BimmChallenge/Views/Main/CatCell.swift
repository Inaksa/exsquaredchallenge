//
//  CatCell.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 16/01/2025.
//

import SwiftUI

extension Cat {
    var hasOwner: Bool {
        guard let owner = owner, !owner.isEmpty else {
            return false
        }
        return owner.lowercased() != "null"
    }

    func getCatOwnerLegend() -> String {
        guard hasOwner, let owner = owner else {
            return "I am a free cat!"
        }

        if owner.lowercased() != "null" {
            return "My owner is \(owner)"
        } else {
            return "I am a free cat!"
        }
    }
}

struct CatCell: View {
    let cat: Cat
    @State private var selectedTag: String?

    var body: some View {
        HStack(alignment: .top) {
            CatPicture(catId: cat.id)
                .frame(width: 40, height: 40)
                .aspectRatio(contentMode: .fill)
                .overlay {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1))
                }
                .clipShape(Circle())
                .clipped()
            VStack(alignment: .leading) {
                Text(cat.getCatOwnerLegend())
                    .font(.caption.italic())
                GeometryReader { geom in
                    ScrollView(.vertical, showsIndicators: false) {
                        FlexibleView(availableWidth: geom.size.width, data: cat.tags, spacing: 8, alignment: .leading) { elem in
                            TagView(tag: elem, useFirstLetter: selectedTag != elem)
                                .onTapGesture {
                                    withAnimation {
                                        if selectedTag == elem {
                                            selectedTag = nil
                                        } else {
                                            selectedTag = elem
                                        }
                                    }
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .topLeading)
            .clipped()
        }
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    CatCell(cat: Cat(id: "rV1MVEh0Af2Bm4O0", tags: ["Tag1", "Tag2"]))
}
