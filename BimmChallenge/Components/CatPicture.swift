//
//  CatPicture.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 17/01/2025.
//
import SwiftUI

struct CatPicture: View {
    let catId: String

    var body: some View {
        if Cache.shared.isDefined(key: catId),
           let data = Cache.shared.getData(for: catId),
           let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            AsyncImage(url: URL(string: "https://cataas.com/cat/\(catId)")!) { phase in
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
                                    Cache.shared.saveData(pngData, for: catId)
                                }
                            }
                        }
                        .overlay {
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 1))
                        }

                default:
                    Color.clear
                        .overlay {
                            Text("Missing")
                                .multilineTextAlignment(.center)
                                .font(.caption2)
                                .textScale(.secondary, isEnabled: true)
                        }
                        .overlay {
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 1))
                        }
                }
            }
        }
    }
}


#Preview {
    CatPicture(catId: "123")
}
