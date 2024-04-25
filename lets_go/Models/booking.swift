//
//  main.swift
//  lets_go
//
//  Created by Ishan Singla on 25/04/24.
//

import Foundation

struct Booking {
    var id: String
    var publishId: String
    var publish: Publish?
    var userId: String
    var user: User
    var approved: Bool
    var reached: Bool
    var createdAt: Date
    var updatedAt: Date
}

struct Publish {
    var id: String
    var publisherUser: String
    var publisher: User
    var dateTime: Date
    var totalNoOfSeets: Int
    var noOfSeetsAvailable: Int
    var costPerSeet: Float
    var createdAt: Date
    var updatedAt: Date
    var bookings: [Booking]
}
