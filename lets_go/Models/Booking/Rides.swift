//
//  Rides.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation

struct Rides: Codable {
    var id: String = NSUUID().uuidString
    var userId: String
    var user: User?
    var vehicleId: String
    var vehicle: Vehicle?
    var fromId: String
    var toId: String
    var from: Address?
    var to: Address?
    var totalNoOfSeets: Int
    var noOfSeetsAvailable: Int
    var costPerSeet: Float
    var dateTime: Date
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var bookings: [Booking]?
}

class RidesRepository {
    private var rides: [Rides] = []
    private let fileURL: URL
    
    init() {
        self.fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Rideses.plist")
        loadRideses()
    }
    
    private func loadRideses() {
        if let data = try? Data(contentsOf: fileURL),
           let loadedRideses = try? PropertyListDecoder().decode([Rides].self, from: data) {
            rides = loadedRideses
        }
    }
    
    private func saveRideses() {
        if let data = try? PropertyListEncoder().encode(rides) {
            try? data.write(to: fileURL)
        }
    }
    
    func findAll() -> [Rides] {
        return rides
    }
    
    func findOne(byId id: String) -> Rides? {
        return rides.first(where: { $0.id == id })
    }
    
    func create(ride: Rides) {
        rides.append(ride)
        saveRideses()
    }
    
    func update(ride: Rides) {
        if let index = rides.firstIndex(where: { $0.id == ride.id }) {
            rides[index] = ride
            saveRideses()
        }
    }
    
    func delete(byId id: String) {
        rides.removeAll(where: { $0.id == id })
        saveRideses()
    }
}
