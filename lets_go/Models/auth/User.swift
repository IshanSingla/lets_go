//
//  User.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation
import SQLite3

struct User {
    var id: String
    var email: String
    var rollnumber: String
    var department: String
    var address: String?
    var vehicleDetails: String?
    var collegeId: String
    var college: College?
    var createdAt: Date?
    var updatedAt: Date?
}

class UserDBHelper {
    let dbPath: String = "myDb.sqlite"
    var db: OpaquePointer?

    init() throws {
        guard let database = openDatabase() else {
            throw DBError.databaseError("Failed to open database")
        }
        db = database
        
        do {
            try createUserTable()
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

    func createUserTable() throws {
        let createTableString = "CREATE TABLE IF NOT EXISTS user(Id TEXT PRIMARY KEY, email TEXT, rollnumber TEXT, department TEXT, address TEXT, vehicleDetails TEXT, collegeId TEXT, createdAt TEXT, updatedAt TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                return
            } else {
                throw DBError.databaseError("User table could not be created.")
            }
        } else {
            throw DBError.databaseError("CREATE TABLE statement could not be prepared.")
        }
    }

    func insertUser(user: User) throws -> Bool {
        let insertStatementString = "INSERT INTO user (Id, email, rollnumber, department, address, vehicleDetails, collegeId, createdAt, updatedAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (user.id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (user.email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (user.rollnumber as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (user.department as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, ((user.address ?? "") as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, ((user.vehicleDetails ?? "") as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (user.collegeId as NSString).utf8String, -1, nil)
            
            let createdAt = user.createdAt != nil ? "\(user.createdAt!)" : ""
            let updatedAt = user.updatedAt != nil ? "\(user.updatedAt!)" : ""
            
            sqlite3_bind_text(insertStatement, 8, (createdAt as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (updatedAt as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                sqlite3_finalize(insertStatement)
                return true
            } else {
                throw DBError.databaseError("Could not insert user.")
            }
        } else {
            throw DBError.databaseError("INSERT statement could not be prepared.")
        }
    }

    func readUsers() throws -> [User] {
        let queryStatementString = "SELECT * FROM user;"
        var queryStatement: OpaquePointer? = nil
        var users: [User] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = String(cString: sqlite3_column_text(queryStatement, 0))
                let email = String(cString: sqlite3_column_text(queryStatement, 1))
                let rollnumber = String(cString: sqlite3_column_text(queryStatement, 2))
                let department = String(cString: sqlite3_column_text(queryStatement, 3))
                let address = String(cString: sqlite3_column_text(queryStatement, 4))
                let vehicleDetails = String(cString: sqlite3_column_text(queryStatement, 5))
                let collegeId = String(cString: sqlite3_column_text(queryStatement, 6))
                let createdAtString = String(cString: sqlite3_column_text(queryStatement, 7))
                let updatedAtString = String(cString: sqlite3_column_text(queryStatement, 8))
                
                let createdAt = DateFormatter.iso8601.date(from: createdAtString)
                let updatedAt = DateFormatter.iso8601.date(from: updatedAtString)
                
                let user = User(id: id, email: email, rollnumber: rollnumber, department: department, address: address, vehicleDetails: vehicleDetails, collegeId: collegeId, createdAt: createdAt, updatedAt: updatedAt)
                users.append(user)
            }
        } else {
            throw DBError.databaseError("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return users
    }

    func deleteUserByID(id: String) throws -> Bool {
        let deleteStatementString = "DELETE FROM user WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(deleteStatement, 1, (id as NSString).utf8String, -1, nil)
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                sqlite3_finalize(deleteStatement)
                return true
            } else {
                throw DBError.databaseError("Could not delete user.")
            }
        } else {
            throw DBError.databaseError("DELETE statement could not be prepared")
        }
    }
}
