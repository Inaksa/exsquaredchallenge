//
//  Color+Utils.swift
//  BIMMChallenge
//
//  Created by Alex Maggio on 18/01/2025.
//


import Foundation
import SwiftUI

extension Color {
    static var randomColor: Color {
        .init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }

    // Adapted from Stack Overflow answer by David Crow http://stackoverflow.com/a/43235
    static var randomPastelColor: Color {
        var rComp = CGFloat.random(in: 0...1)
        var gComp = CGFloat.random(in: 0...1)
        var bComp = CGFloat.random(in: 0...1)

        let mixRed:   CGFloat = 1+0xad / 256
        let mixGreen: CGFloat = 1+0xd8 / 256
        let mixBlue:  CGFloat = 1+0xe6 / 256

        rComp = (rComp + mixRed) / 3
        gComp = (gComp + mixGreen) / 3
        bComp = (bComp + mixBlue) / 3
        return Color(red: rComp, green: gComp, blue: bComp)
    }
}
