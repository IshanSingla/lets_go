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
    case otpExpired
    case otpMismatch
    case emailVerificationFailed
}

class AuthService {
    var userRepository: UserRepository!
    var users:[User]=[]
    
    var userOtpRepository: UserOtpRepository!
    var userOtps: [UserOtp]=[]
    
    var collegeRepository: CollegeRepository!
    var colleges: [College]=[]
    
    init() {
        userRepository = UserRepository()
        userOtpRepository = UserOtpRepository()
        collegeRepository = CollegeRepository()
        load()
    }
    
    private func load () {
        users = userRepository.findAll()
        userOtps = userOtpRepository.findAll()
        colleges = collegeRepository.findAll()
    }
    
    
    func isEmailInCollegeDomain(email: String) throws -> Bool {
        do {
            for college in colleges {
                let domainRegexPattern = "^.*@(\\Q\(college.domain)\\E)$"
                guard let regex = try? NSRegularExpression(pattern: domainRegexPattern, options: []) else {
                    continue // Skip to the next college if there's an issue with regex
                }
                if regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil {
                    return true // Return true if there's a match
                }
            }
            return false // Return false if no match is found
        } catch {
            throw AuthServiceError.emailVerificationFailed
        }
    }
    
    func sendOtp(_ email: String) throws -> Bool {
        do {
            let otp = "123456" // Generate a random 6-digit OTP
            // sendOTP(email, otp) // Send the OTP to the user via email
            
            if var userOtp = userOtps.first(where: { $0.email == email }) {
                userOtp.otp = otp
                userOtp.expiry = Date().addingTimeInterval(60 * 5) // OTP expires in 5 minutes
                userOtpRepository.update(userOtp: userOtp)
                load() // Reload data after updating the OTP
                return true
            } else {
                userOtpRepository.create(userOtp: UserOtp(
                    email: email,
                    otp: otp,
                    expiry: Date().addingTimeInterval(60 * 5) // OTP expires in 5 minutes
                ))
                load() // Reload data after creating the OTP
                return true
            }
        } catch {
            throw AuthServiceError.otpVerificationFailed
        }
    }
    
    func verifyOtp(_ email: String, otp: String) throws -> User {
            guard let userOtp = userOtps.first(where: { $0.email == email }) else {
                throw AuthServiceError.otpMismatch
            }
        
            guard userOtp.expiry > Date() else {
                throw AuthServiceError.otpExpired
            }

            guard userOtp.otp == otp else {
                throw AuthServiceError.otpMismatch
            }

            guard let user = users.first(where: { $0.email == email }) else {
                throw AuthServiceError.userNotFound
            }

            return user
    }
    
    func getUser (_ id:String)throws -> User{
        guard let user = users.first(where: { $0.id == id }) else {
            throw AuthServiceError.userNotFound
        }
        return user
    }
    
    
}
