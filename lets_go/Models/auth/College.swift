//
//  College.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation

struct College: Codable {
    var id: String = NSUUID().uuidString
    var name: String
    var address: Address
    var domain: String
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}

class CollegeRepository {
    private var colleges: [College] = []
    private let fileURL: URL
    
    init() {
        self.fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("colleges.plist")
        loadColleges()
        if colleges.isEmpty {
            create(college: College(
                name: "Chitkara University",
                address: Address( 
                    address: "Chitkara University",
                    city: "Rjpura",
                    state: "Punjab",
                    country: "India",
                    pincode: "140401"
                ),
                domain: "chitkara.edu.in"
            )
            )
            
            create(college: College(
                name: "Chitkara University Himachal Pradesh",
                address: Address(
                    address: "Chitkara University",
                    city: "Solan",
                    state: "Himachal Pradesh",
                    country: "India",
                    pincode: "140401"
                ),
                domain: "chitkarauniversity.edu.in"
            )
            )
            
        }
    }
    
    private func loadColleges() {
        if let data = try? Data(contentsOf: fileURL),
           let loadedColleges = try? PropertyListDecoder().decode([College].self, from: data) {
            colleges = loadedColleges
        }
    }
    
    private func saveColleges() {
        if let data = try? PropertyListEncoder().encode(colleges) {
            try? data.write(to: fileURL)
        }
    }
    
    func findAll() -> [College] {
        return colleges
    }
    
    func findOne(byId id: String) -> College? {
        return colleges.first(where: { $0.id == id })
    }
    
    func create(college: College) {
        colleges.append(college)
        saveColleges()
    }
    
    func update(college: College) {
        if let index = colleges.firstIndex(where: { $0.id == college.id }) {
            colleges[index] = college
            saveColleges()
        }
    }
    
    func delete(byId id: String) {
        colleges.removeAll(where: { $0.id == id })
        saveColleges()
    }
}

