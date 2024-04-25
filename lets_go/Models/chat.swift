//
//  chat.swift
//  lets_go
//
//  Created by Ishan Singla on 25/04/24.
//

import Foundation

struct Chat {
    var id: String
    var userId1: String
    var userId2: String
    var user1: User
    var user2: User
    var createdAt: Date
    var updatedAt: Date
    var messages: [Message]
}

struct Message {
    var id: String
    var chatId: String
    var chat: Chat
    var userId: String
    var user: User
    var message: String
}
