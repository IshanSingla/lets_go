//
//  authService.swift
//  lets_go
//
//  Created by Ishan Singla on 25/04/24.
//

import Foundation

enum AuthServiceError: Error {
    case otpVerificationFailed
    case userNotFound
}

class AuthService {
    var users: [User]
        var userOtps: [UserOtp]
        
        init() {
            // Initialize users array with data
            self.users = [
                User(id: "2110990648",
                                        email: "ishan0648.be21@chitkara.edu.in",
                                        rollnumber: "2110990648",
                                        department: "Computer Science",
                                        address: "123 Main St, City",
                                        vehicleDetails: "Toyota Camry",
                                        collegeId: "1234",
                                        college: nil,
                                        createdAt: Date(),
                                        updatedAt: Date()),
                       User(id: "2110991129",
                                        email: "rajit1129.be21@chitkara.edu.in",
                                        rollnumber: "2110991129",
                                        department: "Computer Science",
                                        address: "123 Main St, City",
                                        vehicleDetails: "Toyota Camry",
                                        collegeId: "1234",
                                        college: nil,
                                        createdAt: Date(),
                            updatedAt: Date()),
                       User(id: "2110990749",
                                        email: "kaushiv0749.be21@chitkara.edu.in",
                                        rollnumber: "2110990749",
                                        department: "Computer Science",
                                        address: "123 Main St, City",
                                        vehicleDetails: "Toyota Camry",
                                        collegeId: "1234",
                                        college: nil,
                                        createdAt: Date(),
                            updatedAt: Date()),
                       
                       User(id: "2110991065",
                                        email: "prince1065.be21@chitkara.edu.in",
                                        rollnumber: "2110991065",
                                        department: "Computer Science",
                                        address: "123 Main St, City",
                                        vehicleDetails: "Toyota Camry",
                                        collegeId: "1234",
                                        college: nil,
                                        createdAt: Date(),
                                        updatedAt: Date())
            ]
            
            // Initialize userOtps array with data
            self.userOtps = [
                UserOtp(email: "ishan0648.be21@chitkara.edu.in",
                                                    otp: "123456",
                                                    expiry: Date().addingTimeInterval(600), // 10 minutes from now
                                                    createdAt: Date(),
                                                    updatedAt: Date()),
                UserOtp(email: "rajit1129.be21@chitkara.edu.in",
                                                    otp: "123456",
                                                    expiry: Date().addingTimeInterval(600), // 10 minutes from now
                                                    createdAt: Date(),
                                                    updatedAt: Date()),
                UserOtp(email: "prince1065.be21@chitkara.edu.in",
                                                    otp: "123456",
                                                    expiry: Date().addingTimeInterval(600), // 10 minutes from now
                                                    createdAt: Date(),
                                                    updatedAt: Date()),
                UserOtp(email: "kaushiv0749.be21@chitkara.edu.in",
                                                    otp: "123456",
                                                    expiry: Date().addingTimeInterval(600), // 10 minutes from now
                                                    createdAt: Date(),
                                                    updatedAt: Date()),

            ]
        }
    
    func sendOtp(_ email: String)throws -> Bool {
        guard let userOtp = userOtps.first(where: { $0.email == email }) else {
            throw AuthServiceError.otpVerificationFailed
        }
        return true
        
    }
    
    func verifyOtp(_ email: String, otp: String) throws -> User {
            guard let userOtp = userOtps.first(where: { $0.email == email }) else {
                throw AuthServiceError.otpVerificationFailed
            }

            guard userOtp.otp == otp else {
                throw AuthServiceError.otpVerificationFailed
            }

            guard let user = users.first(where: { $0.email == email }) else {
                throw AuthServiceError.userNotFound
            }

            return user
    }
    
    func getUser (_ email:String)throws -> User{
        guard let user = users.first(where: { $0.email == email }) else {
            throw AuthServiceError.userNotFound
        }
        return user
        
        
    }
    
    
}
