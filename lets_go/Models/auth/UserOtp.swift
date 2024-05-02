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
