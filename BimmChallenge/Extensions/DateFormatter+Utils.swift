//
//  DateFormatter+Utils.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 16/01/2025.
//

import Foundation

extension DateFormatter {
    static var caasDateFormatter: DateFormatter = {
        /// Note: Since at the moment of writing this I couldn't find the date format specification, I assumed dates were always retrieved in this format.
        /// Non-complying dates will be treated as nils
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(secondsFromGMT: 0)
        df.dateFormat = "EEE MMMM dd yyyy HH:mm:ss 'GMT'Z (zzzz)"
        return df
    }()
}

extension Date {
    func timeAgo() -> String {
        let df = RelativeDateTimeFormatter()
        df.unitsStyle = .full
        return df.localizedString(for: self, relativeTo: Date())
    }
}
