//
//  CatCell.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 16/01/2025.
//

import SwiftUI

struct CatCell: View {
    let cat: Cat
    var body: some View {
        HStack {
            Group {
                if Cache.shared.isDefined(key: cat.id),
                   let data = Cache.shared.getData(for: cat.id),
                   let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    AsyncImage(url: URL(string: "https://cataas.com/cat/\(cat.id)")!) { phase in
                        switch phase {
                        case .empty:
                            Color.clear
                            .overlay {
                                ProgressView()
                            }
                            .overlay {
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 1))
                            }

                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .onAppear {
                                    DispatchQueue.main.async {
                                        let renderer = ImageRenderer(content: image)
                                        if let pngData = renderer.uiImage?.pngData() {
                                            Cache.shared.saveData(pngData, for: cat.id)
                                        }
                                    }
                                }
                        default:
                            Color.clear
                                .overlay {
                                    Text("No Cat Picture").multilineTextAlignment(.center)
                                }
                                .overlay {
                                    Circle()
                                        .stroke(style: StrokeStyle(lineWidth: 1))
                                }
                        }
                    }
                }
            }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .clipped()
            VStack(alignment: .leading) {
                Text(cat.id).font(.caption)
                GeometryReader { geom in
                    FlexibleView(availableWidth: geom.size.width, data: cat.tags, spacing: 8, alignment: .leading) { elem in
                        TagView(tag: elem)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .topLeading)
        }
            .frame(maxWidth: .infinity)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Configuration.cellBackground)
            }

    }
}

#Preview {
    CatCell(cat: Cat(id: "rV1MVEh0Af2Bm4O0", tags: ["Tag1", "Tag2"]))
}
