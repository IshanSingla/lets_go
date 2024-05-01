//
//  UserOtp.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation
import SQLite3


struct UserOtp {
    var email: String
    var otp:String
    var expiry: Date
    var createdAt: Date?
    var updatedAt: Date?
}


class UserOtpDBHelper {
    let dbPath: String = "myDb.sqlite"
    var db: OpaquePointer?

    init() throws {
        guard let database = openDatabase() else {
            throw DBError.databaseError("Failed to open database")
        }
        db = database
        
        do {
            try createUserOtpTable()
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

    func createUserOtpTable() throws {
        let createTableString = "CREATE TABLE IF NOT EXISTS user_otp(email TEXT PRIMARY KEY, otp TEXT, expiry TEXT, createdAt TEXT, updatedAt TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                return
            } else {
                throw DBError.databaseError("UserOtp table could not be created.")
            }
        } else {
            throw DBError.databaseError("CREATE TABLE statement could not be prepared.")
        }
    }

    func insertUserOtp(userOtp: UserOtp) throws -> Bool {
        let insertStatementString = "INSERT INTO user_otp (email, otp, expiry, createdAt, updatedAt) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (userOtp.email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (userOtp.otp as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (userOtp.expiry.description as NSString).utf8String, -1, nil)
            
            let createdAt = userOtp.createdAt != nil ? "\(userOtp.createdAt!)" : ""
            let updatedAt = userOtp.updatedAt != nil ? "\(userOtp.updatedAt!)" : ""
            
            sqlite3_bind_text(insertStatement, 4, (createdAt as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (updatedAt as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                sqlite3_finalize(insertStatement)
                return true
            } else {
                throw DBError.databaseError("Could not insert user otp.")
            }
        } else {
            throw DBError.databaseError("INSERT statement could not be prepared.")
        }
    }

    func readUserOtp(email: String) throws -> UserOtp? {
        let queryStatementString = "SELECT * FROM user_otp WHERE email = ?;"
        var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (email as NSString).utf8String, -1, nil)
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let otp = String(cString: sqlite3_column_text(queryStatement, 1))
                let expiryString = String(cString: sqlite3_column_text(queryStatement, 2))
                let createdAtString = String(cString: sqlite3_column_text(queryStatement, 3))
                let updatedAtString = String(cString: sqlite3_column_text(queryStatement, 4))
                
                let expiry = DateFormatter.iso8601.date(from: expiryString)!
                let createdAt = DateFormatter.iso8601.date(from: createdAtString)
                let updatedAt = DateFormatter.iso8601.date(from: updatedAtString)
                
                let userOtp = UserOtp(email: email, otp: otp, expiry: expiry, createdAt: createdAt, updatedAt: updatedAt)
                sqlite3_finalize(queryStatement)
                return userOtp
            } else {
                sqlite3_finalize(queryStatement)
                return nil
            }
        } else {
            throw DBError.databaseError("SELECT statement could not be prepared")
        }
    }

    func updateUserOtp(userOtp: UserOtp) throws -> Bool {
        let updateStatementString = "UPDATE user_otp SET otp = ?, expiry = ?, createdAt = ?, updatedAt = ? WHERE email = ?;"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (userOtp.otp as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (userOtp.expiry.description as NSString).utf8String, -1, nil)
            
            let createdAt = userOtp.createdAt != nil ? "\(userOtp.createdAt!)" : ""
            let updatedAt = userOtp.updatedAt != nil ? "\(userOtp.updatedAt!)" : ""
            
            sqlite3_bind_text(updateStatement, 3, (createdAt as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (updatedAt as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 5, (userOtp.email as NSString).utf8String, -1, nil)
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                sqlite3_finalize(updateStatement)
                return true
            } else {
                throw DBError.databaseError("Could not update user otp.")
            }
        } else {
            throw DBError.databaseError("UPDATE statement could not be prepared.")
        }
    }

    func deleteUserOtp(email: String) throws -> Bool {
        let deleteStatementString = "DELETE FROM user_otp WHERE email = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(deleteStatement, 1, (email as NSString).utf8String, -1, nil)
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                sqlite3_finalize(deleteStatement)
                return true
            } else {
                throw DBError.databaseError("Could not delete user otp.")
            }
        } else {
            throw DBError.databaseError("DELETE statement could not be prepared")
        }
    }
}
