//
//  AddNew.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 18/01/2025.
//
import SwiftUI

struct AddOrEdit: View {
    @Environment(\.dismiss) var dismissAction

    private let storageService: MainViewModel?

    @State private var name: String
    @State private var owner: String
    @State private var tags: [String]
    @State private var addingTags: Bool = false
    @State private var tagsToEdit: String

    @State private var discardChanges: Bool = false

    @FocusState private var isTagsEditingFocused: Bool

    init(cat: Cat? = nil, storageService: MainViewModel? = nil) {
        self.name = cat?.name ?? ""
        self.owner = cat?.owner ?? ""
        self.tags = cat?.tags ?? []
        self.tagsToEdit = (cat?.tags ?? []).joined(separator: " ")
        self.storageService = storageService
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading) {
                Text("Name")
                TextField(Configuration.defaultCatName, text: $name)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

            }
            VStack(alignment: .leading) {
                Text("Owner")
                TextField("Owner", text: $owner)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            VStack(alignment: .leading) {
                Text("Tags")
                HStack {
                    if addingTags {
                        TextField("Add tag", text: $tagsToEdit)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .focused($isTagsEditingFocused)
                            .onChange(of: tagsToEdit) { _, newValue in
                                tags = newValue.split(separator: " ").map({ String($0) })
                            }
                            .onChange(of: isTagsEditingFocused) { _, newValue in
                                tags = tagsToEdit.split(separator: " ").map({ String($0) })
                                addingTags = newValue
                            }
                            .onSubmit {
                                tags = tagsToEdit.split(separator: " ").map({ String($0) })
                                addingTags = false
                            }
                    } else {
                        let validElems = tags + ["+"]
                        FlexibleView(
                            availableWidth: .infinity,
                            data: validElems,
                            spacing: 8,
                            alignment: .leading
                        ) { tag in
                            TagView(tag: tag)
                                .onTapGesture {
                                    if tag == "+" {
                                        tagsToEdit = tags.joined(separator: " ")
                                        addingTags.toggle()
                                    } else {
                                        let tagHash = tag.hashValue
                                        tags.removeAll { $0.hashValue == tagHash }
                                    }
                                }
                        }
                    }
                }
            }

            Color.clear

            HStack(spacing: 16) {
                Button("Save") {
                    storageService?.saveCat(Cat(
                        id: UUID().uuidString,
                        name: self.name,
                        tags: self.tags,
                        owner: self.owner
                    ))
                    dismissAction()
                }
                .disabled(name.isEmpty)
                .frame(maxWidth: .infinity)

                Button("Cancel", role: .destructive) {
                    if !name.isEmpty || !tags.isEmpty || !owner.isEmpty {
                        discardChanges = true
                    } else {
                        dismissAction()
                    }
                }
                .frame(maxWidth: .infinity)
            }
                .frame(maxWidth: .infinity)
                .padding()
                .alert(isPresented: $discardChanges) {
                    Alert(
                        title: Text("Attention"),
                        message: Text("Would you like to discard your changes?"),
                        primaryButton: Alert.Button.default(Text("Yes"), action: {
                            self.dismissAction()
                        }),
                        secondaryButton: Alert.Button.cancel({
                            discardChanges = false
                        })
                    )
                }
        }
            .padding()
    }

}

#Preview {
    AddOrEdit(
        cat: Cat(
            id: UUID().uuidString,
            tags: [RandomGenerator.getTag(), RandomGenerator.getTag()],
            owner: RandomGenerator.getName()
        )
    )
}
