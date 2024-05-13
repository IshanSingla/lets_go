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

class VehicleRepository {
    private var vehicles: [Vehicle] = []
    private let fileURL: URL
    
    init() {
        self.fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("vehicles.plist")
        loadVehicles()
        var user = try! AuthService().getCurrentUser()
        if vehicles.contains(where: { $0.userId == user.id }) {
            return
        } else {
            create(
                vehicle: Vehicle(
                    userId: user.id,
                    vehicleName: "My Vehicle",
                    vehicleNumber: "ABC123",
                    vehicleType: "Car"
                )
            )
            create(
                vehicle: Vehicle(
                    userId: user.id,
                    vehicleName: "My Vehicle 2",
                    vehicleNumber: "ABC1234",
                    vehicleType: "Car"
                )
            )
            
        }
    }
    
    private func loadVehicles() {
        if let data = try? Data(contentsOf: fileURL),
           let loadedVehicles = try? PropertyListDecoder().decode([Vehicle].self, from: data) {
            vehicles = loadedVehicles
        }
    }
    
    private func saveVehicles() {
        if let data = try? PropertyListEncoder().encode(vehicles) {
            try? data.write(to: fileURL)
        }
    }
    
    func findAll() -> [Vehicle] {
        return vehicles
    }
    
    func findOne(byId id: String) -> Vehicle? {
        return vehicles.first(where: { $0.id == id })
    }
    
    func findAll(byUserId userId: String) -> [Vehicle] {
        return vehicles.filter({ $0.userId == userId })
    }
    
    func create(vehicle: Vehicle) {
        vehicles.append(vehicle)
        saveVehicles()
    }
    
    func update(vehicle: Vehicle) {
        if let index = vehicles.firstIndex(where: { $0.id == vehicle.id }) {
            vehicles[index] = vehicle
            saveVehicles()
        }
    }
    
    func delete(byId id: String) {
        vehicles.removeAll(where: { $0.id == id })
        saveVehicles()
    }
}
