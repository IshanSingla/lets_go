//
//  File.swift
//  lets_go
//
//  Created by Ishan Singla on 25/04/24.
//

import Foundation

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

struct College {
    var id: String
    var name: String
    var address: String
    var domain: String
    var createdAt: Date
    var updatedAt: Date
}

struct UserOtp {
    var email: String
    var otp:String
    var expiry: Date
    var createdAt: Date?
    var updatedAt: Date?
}

enum AuthServiceError: Error {
    case otpVerificationFailed
    case userNotFound
}
