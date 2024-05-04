//
//  Booking.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation

struct Booking: Codable {
    var id: String = NSUUID().uuidString
    var rideId: String
    var ride: Rides?
    var userId: String
    var user: User?
    var approved: Bool
    var reached: Bool
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}

class BookingRepository {
    private var bookings: [Booking] = []
    private let fileURL: URL
    
    init() {
        self.fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("bookings.plist")
        loadBookings()
    }
    
    private func loadBookings() {
        if let data = try? Data(contentsOf: fileURL),
           let loadedBookings = try? PropertyListDecoder().decode([Booking].self, from: data) {
            bookings = loadedBookings
        }
    }
    
    private func saveBookings() {
        if let data = try? PropertyListEncoder().encode(bookings) {
            try? data.write(to: fileURL)
        }
    }
    
    func findAll() -> [Booking] {
        return bookings
    }
    
    func findOne(byId id: String) -> Booking? {
        return bookings.first(where: { $0.id == id })
    }
    
    func create(booking: Booking) {
        bookings.append(booking)
        saveBookings()
    }
    
    func update(booking: Booking) {
        if let index = bookings.firstIndex(where: { $0.id == booking.id }) {
            bookings[index] = booking
            saveBookings()
        }
    }
    
    func delete(byId id: String) {
        bookings.removeAll(where: { $0.id == id })
        saveBookings()
    }
}
