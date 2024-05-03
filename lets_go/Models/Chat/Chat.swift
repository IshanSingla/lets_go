//
//  Chat.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation
import SQLite3

struct Chat: Codable {
    var id: String = NSUUID().uuidString
    var userId1: String
    var userId2: String
    var user1: User?
    var user2: User?
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var messages: [Message]?
}

import Foundation

class ChatRepository {
    private var chats: [Chat] = []
    private let fileURL: URL
    
    init() {
        self.fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("chats.plist")
        loadChats()
    }
    
    private func loadChats() {
        if let data = try? Data(contentsOf: fileURL),
           let loadedChats = try? PropertyListDecoder().decode([Chat].self, from: data) {
            chats = loadedChats
        }
    }
    
    private func saveChats() {
        if let data = try? PropertyListEncoder().encode(chats) {
            try? data.write(to: fileURL)
        }
    }
    
    func findAll() -> [Chat] {
        return chats
    }
    
    func findOne(byId id: String) -> Chat? {
        return chats.first(where: { $0.id == id })
    }
    
    func create(chat: Chat) {
        chats.append(chat)
        saveChats()
    }
    
    func update(chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            chats[index] = chat
            saveChats()
        }
    }
    
    func delete(byId id: String) {
        chats.removeAll(where: { $0.id == id })
        saveChats()
    }
}
