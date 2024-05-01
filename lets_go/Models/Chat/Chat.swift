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


class ChatDBHelper {
    let dbPath: String = "myDb.sqlite"
    var db: OpaquePointer?

    init() throws {
        guard let database = openDatabase() else {
            throw DBError.databaseError("Failed to open database")
        }
        db = database
        
        do {
            try createChatTable()
        } catch {
            throw error
        }
    }

    func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            return nil
        } else {
            return db
        }
    }

    func createChatTable() throws {
        let createTableString = "CREATE TABLE IF NOT EXISTS chat(Id TEXT PRIMARY KEY, userId1 TEXT, userId2 TEXT, createdAt TEXT, updatedAt TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                return
            } else {
                throw DBError.databaseError("Chat table could not be created.")
            }
        } else {
            throw DBError.databaseError("CREATE TABLE statement could not be prepared.")
        }
    }

    func insertChat(chat: Chat) throws -> Bool {
        let insertStatementString = "INSERT INTO chat (Id, userId1, userId2, createdAt, updatedAt) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (chat.id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (chat.userId1 as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (chat.userId2 as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (chat.createdAt!.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (chat.updatedAt!.description as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                sqlite3_finalize(insertStatement)
                return true
            } else {
                throw DBError.databaseError("Could not insert chat.")
            }
        } else {
            throw DBError.databaseError("INSERT statement could not be prepared.")
        }
    }

    func readChats() throws -> [Chat] {
        let queryStatementString = "SELECT * FROM chat;"
        var queryStatement: OpaquePointer? = nil
        var chats: [Chat] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = String(cString: sqlite3_column_text(queryStatement, 0))
                let userId1 = String(cString: sqlite3_column_text(queryStatement, 1))
                let userId2 = String(cString: sqlite3_column_text(queryStatement, 2))
                let createdAtString = String(cString: sqlite3_column_text(queryStatement, 3))
                let updatedAtString = String(cString: sqlite3_column_text(queryStatement, 4))
                
                let createdAt = DateFormatter.iso8601.date(from: createdAtString)!
                let updatedAt = DateFormatter.iso8601.date(from: updatedAtString)!
                
                let chat = Chat(id: id, userId1: userId1, userId2: userId2, createdAt: createdAt, updatedAt: updatedAt)
                chats.append(chat)
            }
        } else {
            throw DBError.databaseError("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return chats
    }

    func updateChat(chat: Chat) throws -> Bool {
        let updateStatementString = "UPDATE chat SET userId1 = ?, userId2 = ?, createdAt = ?, updatedAt = ? WHERE Id = ?;"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (chat.userId1 as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (chat.userId2 as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (chat.createdAt!.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (chat.updatedAt!.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 5, (chat.id as NSString).utf8String, -1, nil)
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                sqlite3_finalize(updateStatement)
                return true
            } else {
                throw DBError.databaseError("Could not update chat.")
            }
        } else {
            throw DBError.databaseError("UPDATE statement could not be prepared.")
        }
    }

    func deleteChatById(id: String) throws -> Bool {
        let deleteStatementString = "DELETE FROM chat WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(deleteStatement, 1, (id as NSString).utf8String, -1, nil)
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                sqlite3_finalize(deleteStatement)
                return true
            } else {
                throw DBError.databaseError("Could not delete chat.")
            }
        } else {
            throw DBError.databaseError("DELETE statement could not be prepared")
        }
    }
}
