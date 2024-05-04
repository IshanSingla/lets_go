//
//  User.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation

struct User: Codable {
    var id: String = NSUUID().uuidString
    var name: String
    var email: String
    var rollnumber: String
    var department: String
    var year: String?
    var addresses: [Address]?
    var vehicles: [Vehicle]?
    var collegeId: String
    var college: College?
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}

class UserRepository {
    private var users: [User] = []
    private let fileURL: URL
    
    init() {
        self.fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("users.plist")
        loadUsers()
        if users.isEmpty {
            let collegeRepository = CollegeRepository()
            let colleges = collegeRepository.findAll()
            if let firstCollege = colleges.first {
                create(user: User(
                    name: "Ishan Singla",
                    email: "ishan0648.be21@chitkara.edu.in",
                    rollnumber: "2110990648",
                    department: "Computer Science",
                    collegeId: firstCollege.id,
                    createdAt: Date(),
                    updatedAt: Date()
                )
                )
                
                create(user: User(
                    name: "Rajit",
                    email: "rajit1129.be21@chitkara.edu.in",
                    rollnumber: "2110991129",
                    department: "Computer Science",
                    collegeId: firstCollege.id,
                    college: nil,
                    createdAt: Date(),
                    updatedAt: Date()
                )
                )
                create(user: User(
                    name: "Kaushiv",
                    email: "kaushiv0749.be21@chitkara.edu.in",
                    rollnumber: "2110990749",
                    department: "Computer Science",
                    collegeId: firstCollege.id,
                    college: nil,
                    createdAt: Date(),
                    updatedAt: Date()
                )
                )
                create(user: User(
                    name: "Prince",
                    email: "prince1065.be21@chitkara.edu.in",
                    rollnumber: "2110991065",
                    department: "Computer Science",
                    collegeId: firstCollege.id,
                    college: nil,
                    createdAt: Date(),
                    updatedAt: Date()
                )
                )
            }
        }
    }
    
    private func loadUsers() {
        if let data = try? Data(contentsOf: fileURL),
           let loadedUsers = try? PropertyListDecoder().decode([User].self, from: data) {
            users = loadedUsers
        }
    }
    
    private func saveUsers() {
        if let data = try? PropertyListEncoder().encode(users) {
            try? data.write(to: fileURL)
        }
    }
    
    func findAll() -> [User] {
        return users
    }
    
    func findOne(byId id: String) -> User? {
        return users.first(where: { $0.id == id })
    }
    
    func findOne(byEmail email: String) -> User? {
        return users.first(where: { $0.email == email })
    }
    
    func create(user: User) {
        users.append(user)
        saveUsers()
    }
    
    func update(user: User) {
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index] = user
            saveUsers()
        }
    }
    
    func delete(byId id: String) {
        users.removeAll(where: { $0.id == id })
        saveUsers()
    }
}
