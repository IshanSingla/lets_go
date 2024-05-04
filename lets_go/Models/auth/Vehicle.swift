//
//  Vehicle.swift
//  lets_go
//
//  Created by Ishan Singla on 04/05/24.
//

import Foundation

struct Vehicle: Codable {
    var id: String = NSUUID().uuidString
    var userId: String
    var vehicleName: String
    var vehicleNumber: String
    var vehicleType: String
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}
