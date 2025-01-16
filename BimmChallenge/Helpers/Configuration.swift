//
//  Configuration.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 17/01/2025.
//


enum Configuration {
    static let cellBackground: Color = Color(uiColor: UIColor.lightGray)

    static let catsPerPage: Int = 10

    enum Datasource {
        static let filename: String = "Datasource"
        static let fileExtension: String = "json"
    }
}
