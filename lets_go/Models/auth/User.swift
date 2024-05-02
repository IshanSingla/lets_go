//
//  User.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation
import SQLite3

struct User {
    var id: String
    var name: String?
    var email: String
    var rollnumber: String
    var department: String
    var address: String?
    var addresses: [Address]?
    var vehicleDetails: String?
    var collegeId: String
    var college: College?
    var createdAt: Date?
    var updatedAt: Date?
}
