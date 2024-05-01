//
//  main.swift
//  lets_go
//
//  Created by Ishan Singla on 25/04/24.
//

import Foundation

struct Publish {
    var id: String
    var publisherUserId: String
    var publisher: User?
    var totalNoOfSeets: Int
    var noOfSeetsAvailable: Int
    var costPerSeet: Float
    var dateTime: Date
    var createdAt: Date
    var updatedAt: Date
    var bookings: [Booking]
}

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


class PublishCRUD {
    var publishes: [Publish] = []
    
    init() {
        // Initialize publishes array with data
        self.publishes = [
            Publish(
                id: "1",
                publisherUserId: "2110990648",
                totalNoOfSeets: 5,
                noOfSeetsAvailable: 5,
                costPerSeet: 10.0,
                dateTime: Date(),
                createdAt: Date(),
                updatedAt: Date(),
                bookings: [
                    Booking(id: "1", publishId: "1", userId: "1", approved: true, reached: false, createdAt: Date(), updatedAt: Date()),
                    Booking(id: "2", publishId: "1", userId: "2", approved: true, reached: false, createdAt: Date(), updatedAt: Date())
                ]
            ),
            // Add more publishes if needed
        ]
    }
    
    func createPublish(publish: Publish) {
        self.publishes.append(publish)
    }
    
    func getPublishById(id: String) -> Publish? {
        return self.publishes.first(where: { $0.id == id })
    }
    
    func updatePublish(publish: Publish) {
        if let index = publishes.firstIndex(where: { $0.id == publish.id }) {
            self.publishes[index] = publish
        }
    }
    
    func deletePublishById(id: String) {
        self.publishes.removeAll(where: { $0.id == id })
    }
}

class BookingCRUD {
    var bookings: [Booking] = []
    
    init() {
        // Initialize publishes array with data
        self.bookings = [
            Booking(id: "1", publishId: "1", userId: "1", approved: true, reached: false, createdAt: Date(), updatedAt: Date()),
            Booking(id: "2", publishId: "1", userId: "2", approved: true, reached: false, createdAt: Date(), updatedAt: Date())
        ]
    }
    
    func createBooking(booking: Booking) {
        self.bookings.append(booking)
    }
    
    func getBookingById(id: String) -> Booking? {
        return self.bookings.first(where: { $0.id == id })
    }
    
    func updateBooking(booking: Booking) {
        if let index = bookings.firstIndex(where: { $0.id == booking.id }) {
            self.bookings[index] = booking
        }
    }
    
    func deleteBookingById(id: String) {
        self.bookings.removeAll(where: { $0.id == id })
    }
}

// Sample usage:
let publishCRUD = PublishCRUD()
let bookingCRUD = BookingCRUD()

// You can now use publishCRUD and bookingCRUD instances to perform CRUD operations.
