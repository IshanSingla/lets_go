//
//  Publish.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation

struct Publish: Codable {
    var id: String = NSUUID().uuidString
    var publisherUserId: String
    var publisherUser: User?
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

class PublishRepository {
    private var publishes: [Publish] = []
    private let fileURL: URL
    
    init() {
        self.fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("publishes.plist")
        loadPublishes()
    }
    
    private func loadPublishes() {
        if let data = try? Data(contentsOf: fileURL),
           let loadedPublishes = try? PropertyListDecoder().decode([Publish].self, from: data) {
            publishes = loadedPublishes
        }
    }
    
    private func savePublishes() {
        if let data = try? PropertyListEncoder().encode(publishes) {
            try? data.write(to: fileURL)
        }
    }
    
    func findAll() -> [Publish] {
        return publishes
    }
    
    func findOne(byId id: String) -> Publish? {
        return publishes.first(where: { $0.id == id })
    }
    
    func create(publish: Publish) {
        publishes.append(publish)
        savePublishes()
    }
    
    func update(publish: Publish) {
        if let index = publishes.firstIndex(where: { $0.id == publish.id }) {
            publishes[index] = publish
            savePublishes()
        }
    }
    
    func delete(byId id: String) {
        publishes.removeAll(where: { $0.id == id })
        savePublishes()
    }
}
