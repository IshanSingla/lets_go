//
//  Message.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation
import Foundation
import SQLite3


struct Message {
    var id: String
    var chatId: String
    var userId: String
    var message: String
    var createdAt: Date?
    var updatedAt: Date?
    
}
class MessageDBHelper {
    let dbPath: String = "myDb.sqlite"
    var db: OpaquePointer?

    init() throws {
        guard let database = openDatabase() else {
            throw DBError.databaseError("Failed to open database")
        }
        db = database
        
        do {
            try createMessageTable()
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

    func createMessageTable() throws {
        let createTableString = "CREATE TABLE IF NOT EXISTS message(Id TEXT PRIMARY KEY, chatId TEXT, userId TEXT, message TEXT, createdAt TEXT, updatedAt TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                return
            } else {
                throw DBError.databaseError("Message table could not be created.")
            }
        } else {
            throw DBError.databaseError("CREATE TABLE statement could not be prepared.")
        }
    }

    func insertMessage(message: Message) throws -> Bool {
        let insertStatementString = "INSERT INTO message (Id, chatId, userId, message, createdAt, updatedAt) VALUES (?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (message.id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (message.chatId as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (message.userId as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (message.message as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (message.createdAt!.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (message.updatedAt!.description as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                sqlite3_finalize(insertStatement)
                return true
            } else {
                throw DBError.databaseError("Could not insert message.")
            }
        } else {
            throw DBError.databaseError("INSERT statement could not be prepared.")
        }
    }

    func readMessages(forChatId chatId: String) throws -> [Message] {
        let queryStatementString = "SELECT * FROM message WHERE chatId = ?;"
        var queryStatement: OpaquePointer? = nil
        var messages: [Message] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (chatId as NSString).utf8String, -1, nil)
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = String(cString: sqlite3_column_text(queryStatement, 0))
                let userId = String(cString: sqlite3_column_text(queryStatement, 2))
                let message = String(cString: sqlite3_column_text(queryStatement, 3))
                let createdAtString = String(cString: sqlite3_column_text(queryStatement, 4))
                let updatedAtString = String(cString: sqlite3_column_text(queryStatement, 5))
                
                let createdAt = DateFormatter.iso8601.date(from: createdAtString)!
                let updatedAt = DateFormatter.iso8601.date(from: updatedAtString)!
                
                let mess = Message(id: id, chatId: chatId, userId: userId, message: message, createdAt: createdAt, updatedAt: updatedAt)
                messages.append(mess)
            }
        } else {
            throw DBError.databaseError("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return messages
    }

    func updateMessage(message: Message) throws -> Bool {
        let updateStatementString = "UPDATE message SET chatId = ?, userId = ?, message = ?, createdAt = ?, updatedAt = ? WHERE Id = ?;"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (message.chatId as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (message.userId as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (message.message as NSString).utf8String, -1, nil)

            sqlite3_bind_text(updateStatement, 6, (message.id as NSString).utf8String, -1, nil)
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                sqlite3_finalize(updateStatement)
                return true
            } else {
                throw DBError.databaseError("Could not update message.")
            }
        } else {
            throw DBError.databaseError("UPDATE statement could not be prepared.")
        }
    }

    func deleteMessageById(id: String) throws -> Bool {
        let deleteStatementString = "DELETE FROM message WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(deleteStatement, 1, (id as NSString).utf8String, -1, nil)
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                sqlite3_finalize(deleteStatement)
                return true
            } else {
                throw DBError.databaseError("Could not delete message.")
            }
        } else {
            throw DBError.databaseError("DELETE statement could not be prepared")
        }
    }
}
