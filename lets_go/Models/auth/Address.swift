//
//  Address.swift
//  lets_go
//
//  Created by Ishan Singla on 02/05/24.
//

import Foundation


struct Address: Codable {
    var id: String = NSUUID().uuidString
    var userId: String
    var address: String
    var city: String
    var state: String
    var country: String
    var pincode: String
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}

class AddressRepository {
    private var addresses: [Address] = []
    private let fileURL: URL
    
    init() {
        self.fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("addresses.plist")
        loadAddresses()
    }
    
    private func loadAddresses() {
        if let data = try? Data(contentsOf: fileURL),
           let loadedAddresses = try? PropertyListDecoder().decode([Address].self, from: data) {
            addresses = loadedAddresses
        }
    }
    
    private func saveAddresses() {
        if let data = try? PropertyListEncoder().encode(addresses) {
            try? data.write(to: fileURL)
        }
    }
    
    func findAll() -> [Address] {
        return addresses
    }
    
    func findOne(byId id: String) -> Address? {
        return addresses.first(where: { $0.id == id })
    }
    
    func findAll(byUserId userId: String) -> [Address] {
        return addresses.filter({ $0.userId == userId })
    }
    
    func create(address: Address) {
        addresses.append(address)
        saveAddresses()
    }
    
    func update(address: Address) {
        if let index = addresses.firstIndex(where: { $0.id == address.id }) {
            addresses[index] = address
            saveAddresses()
        }
    }
    
    func delete(byId id: String) {
        addresses.removeAll(where: { $0.id == id })
        saveAddresses()
    }
}
