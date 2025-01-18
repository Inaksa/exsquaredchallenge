//
//  CatCell.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 16/01/2025.
//

import SwiftUI

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
                if cat.hasName {
                    Text(cat.getNameLegend())
                        .font(.caption)
                } else {
                    Text(cat.getCatOwnerLegend())
                        .font(.caption.italic())
                }
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
    CatCell(
        cat: Cat(
            id: "rV1MVEh0Af2Bm4O0",
            name: "Test",
            tags: ["Tag1", "Tag2"]
        )
    )
}
