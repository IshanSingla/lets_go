//
//  Booking.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation

struct Booking {
    var id: String
    var publishId: String
    var publish: Publish?
    var userId: String
    var user: User?
    var approved: Bool
    var reached: Bool
    var createdAt: Date
    var updatedAt: Date
}
