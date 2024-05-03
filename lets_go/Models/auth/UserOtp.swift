//
//  UserOtp.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation

struct UserOtp: Codable {
    var id: String = NSUUID().uuidString
    var email: String
    var otp:String
    var expiry: Date
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}

class UserOtpRepository {
    private var userOtps: [UserOtp] = []
    private let fileURL: URL
    
    init() {
        self.fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("userOtps.plist")
        loadUserOtps()
    }
    
    private func loadUserOtps() {
        if let data = try? Data(contentsOf: fileURL),
           let loadedUserOtps = try? PropertyListDecoder().decode([UserOtp].self, from: data) {
            userOtps = loadedUserOtps
        }
    }
    
    private func saveUserOtps() {
        if let data = try? PropertyListEncoder().encode(userOtps) {
            try? data.write(to: fileURL)
        }
    }
    
    func findAll() -> [UserOtp] {
        return userOtps
    }
    
    func findOne(byId id: String) -> UserOtp? {
        return userOtps.first(where: { $0.id == id })
    }
    
    func create(userOtp: UserOtp) {
        userOtps.append(userOtp)
        saveUserOtps()
    }
    
    func update(userOtp: UserOtp) {
        if let index = userOtps.firstIndex(where: { $0.id == userOtp.id }) {
            userOtps[index] = userOtp
            saveUserOtps()
        }
    }
    
    func delete(byId id: String) {
        userOtps.removeAll(where: { $0.id == id })
        saveUserOtps()
    }
}
