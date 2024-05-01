//
//  College.swift
//  lets_go
//
//  Created by Ishan Singla on 30/04/24.
//

import Foundation
import SQLite3

struct College {
    var id: String
    var name: String
    var address: String
    var domain: String
    var createdAt: Date
    var updatedAt: Date
}


class CollegeDBHelper {
    let dbPath: String = "myDb.sqlite"
    var db: OpaquePointer?

    init() throws {
        guard let database = openDatabase() else {
            throw DBError.databaseError("Failed to open database")
        }
        db = database
        
        do {
            try createCollegeTable()
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

    func createCollegeTable() throws {
        let createTableString = "CREATE TABLE IF NOT EXISTS college(Id TEXT PRIMARY KEY, name TEXT, address TEXT, domain TEXT, createdAt TEXT, updatedAt TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                return
            } else {
                throw DBError.databaseError("College table could not be created.")
            }
        } else {
            throw DBError.databaseError("CREATE TABLE statement could not be prepared.")
        }
    }

    func insertCollege(college: College) throws -> Bool {
        let insertStatementString = "INSERT INTO college (Id, name, address, domain, createdAt, updatedAt) VALUES (?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (college.id as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (college.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (college.address as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (college.domain as NSString).utf8String, -1, nil)
            
            let createdAt = "\(college.createdAt)"
            let updatedAt = "\(college.updatedAt)"
            
            sqlite3_bind_text(insertStatement, 5, (createdAt as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (updatedAt as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                sqlite3_finalize(insertStatement)
                return true
            } else {
                throw DBError.databaseError("Could not insert college.")
            }
        } else {
            throw DBError.databaseError("INSERT statement could not be prepared.")
        }
    }

    func readColleges() throws -> [College] {
        let queryStatementString = "SELECT * FROM college;"
        var queryStatement: OpaquePointer? = nil
        var colleges: [College] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = String(cString: sqlite3_column_text(queryStatement, 0))
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let address = String(cString: sqlite3_column_text(queryStatement, 2))
                let domain = String(cString: sqlite3_column_text(queryStatement, 3))
                let createdAtString = String(cString: sqlite3_column_text(queryStatement, 4))
                let updatedAtString = String(cString: sqlite3_column_text(queryStatement, 5))
                
                guard let createdAt = DateFormatter.iso8601.date(from: createdAtString) else {
                    throw DBError.invalidDateFormat("Invalid createdAt date format")
                }
                
                guard let updatedAt = DateFormatter.iso8601.date(from: updatedAtString) else {
                    throw DBError.invalidDateFormat("Invalid updatedAt date format")
                }
                
                let college = College(id: id, name: name, address: address, domain: domain, createdAt: createdAt, updatedAt: updatedAt)
                colleges.append(college)
            }
            sqlite3_finalize(queryStatement)
            return colleges
        } else {
            throw DBError.databaseError("SELECT statement could not be prepared")
        }
    }

    func deleteCollegeByID(id: String) throws -> Bool {
        let deleteStatementString = "DELETE FROM college WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(deleteStatement, 1, (id as NSString).utf8String, -1, nil)
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                sqlite3_finalize(deleteStatement)
                return true
            } else {
                throw DBError.databaseError("Could not delete college.")
            }
        } else {
            throw DBError.databaseError("DELETE statement could not be prepared")
        }
    }
}

