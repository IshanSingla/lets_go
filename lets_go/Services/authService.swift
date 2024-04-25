//
//  authService.swift
//  lets_go
//
//  Created by Ishan Singla on 25/04/24.
//

import Foundation

class AuthService {
    var users:[User]=[
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
        User(id: "2110990648",
                         email: "ishan0648.be21@chitkara.edu.in",
                         rollnumber: "2110990648",
                         department: "Computer Science",
                         address: "123 Main St, City",
                         vehicleDetails: "Toyota Camry",
                         collegeId: "1234",
                         college: nil,
                         createdAt: Date(),
                         updatedAt: Date())
    ]
    
    var userOtps: [UserOtp]=[UserOtp(email: "ishan0648.be21@chitkara.edu.in",
                                    otp: "123456",
                                    expiry: Date().addingTimeInterval(600), // 10 minutes from now
                                    createdAt: Date(),
                                    updatedAt: Date()),
                            
    ]
    
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
