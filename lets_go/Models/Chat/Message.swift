//
//  Message.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation

struct Message: Codable {
    var id: String = NSUUID().uuidString
    var chatId: String
    var userId: String
    var message: String
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    
}

class MessageRepository {
    private var messages: [Message] = []
    private let fileURL: URL
    
    init() {
        self.fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("messages.plist")
        loadMessages()
    }
    
    private func loadMessages() {
        if let data = try? Data(contentsOf: fileURL),
           let loadedMessages = try? PropertyListDecoder().decode([Message].self, from: data) {
            messages = loadedMessages
        }
    }
    
    private func saveMessages() {
        if let data = try? PropertyListEncoder().encode(messages) {
            try? data.write(to: fileURL)
        }
    }
    
    func findAll() -> [Message] {
        return messages
    }
    
    func findOne(byId id: String) -> Message? {
        return messages.first(where: { $0.id == id })
    }
    
    func create(message: Message) {
        messages.append(message)
        saveMessages()
    }
    
    func update(message: Message) {
        if let index = messages.firstIndex(where: { $0.id == message.id }) {
            messages[index] = message
            saveMessages()
        }
    }
    
    func delete(byId id: String) {
        messages.removeAll(where: { $0.id == id })
        saveMessages()
    }
}
