//
//  CatPicture.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 17/01/2025.
//
import SwiftUI

struct CatPicture: View {
    let cat: Cat

    var body: some View {
        if Cache.shared.isDefined(key: cat.id),
           let data = Cache.shared.getData(for: cat.id),
           let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            AsyncImage(url: URL(string: "https://cataas.com/cat/\(cat.id)")!) { phase in
                switch phase {
                case .empty:
                    Color.clear
                        .overlay {
                            ProgressView()
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
                    Color.randomPastelColor
                        .overlay {
                            if cat.hasName, let firstLetter = cat.name.uppercased().first {
                                Text("\(firstLetter)")
                                    .font(.title.bold())
                            } else {
                                Text("Missing")
                                    .multilineTextAlignment(.center)
                                    .font(.caption2)
                                    .textScale(.secondary)
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        CatPicture(cat: Cat(id: "1", name: "Fluffykins"))
            .frame(width: 100, height: 100)
        CatPicture(cat: Cat(id: "1"))
            .frame(width: 100, height: 100)

    }
}
