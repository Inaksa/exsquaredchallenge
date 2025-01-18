//
//  CatDetail.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 17/01/2025.
//

import SwiftUI

struct CatDetail: View {
    @State private var displayBigImage: Bool = false
    let cat: Cat

    var body: some View {
        GeometryReader { geom in
            VStack {
                CatPicture(catId: cat.id)
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            displayBigImage.toggle()
                        }
                    }

                Text(cat.getCatOwnerLegend())
                    .padding()

                GeometryReader { geom in
                    FlexibleView(
                        availableWidth: geom.size.width,
                        data: cat.tags,
                        spacing: 8,
                        alignment: .leading
                    ) { elem in
                        TagView(tag: elem, useFirstLetter: false)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
                .padding(.horizontal)

                Color.clear

                Group {
                    if cat.updatedAt == nil {
                        createdAtView()
                    } else {
                        updatedAtView()
                    }
                }
                .font(.caption2.italic())
                .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .sheet(isPresented: $displayBigImage) {
                CatPicture(catId: cat.id)
                    .ignoresSafeArea()
                    .onTapGesture {
                        displayBigImage.toggle()
                    }

            }
        }
    }

    private func createdAtView() -> AnyView {
        guard let createdAt = cat.createdAt as Date? else {
            return AnyView(EmptyView())
        }
        return AnyView(Text("Added on \(createdAt, style: .date)"))
    }

    private func updatedAtView() -> AnyView {
        guard let updatedAt = cat.updatedAt as Date? else {
            return AnyView(EmptyView())
        }

        return AnyView(Text("Last updated \(updatedAt.timeAgo())"))
    }
}

#Preview {
    CatDetail(cat: .random)
}
