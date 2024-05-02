//
//  Chat.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation
import SQLite3

struct Chat {
    var id: String
    var userId1: String
    var userId2: String
    var user1: User?
    var user2: User?
    var createdAt: Date?
    var updatedAt: Date?
    var messages: [Message]?
}
