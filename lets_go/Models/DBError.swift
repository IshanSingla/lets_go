//
//  DBError.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation

enum DBError: Error {
    case databaseError(String)
    case invalidDateFormat(String)
}

extension DateFormatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
}
