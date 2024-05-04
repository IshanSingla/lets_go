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
    private var userRepository: UserRepository!
    private var userOtpRepository: UserOtpRepository!
    private var collegeRepository: CollegeRepository!
    private var addressRepository: AddressRepository!
    
    init() {
        userRepository = UserRepository()
        userOtpRepository = UserOtpRepository()
        collegeRepository = CollegeRepository()
        addressRepository = AddressRepository()
    }
    
    func sendOtp(_ email: String) throws -> Bool {
        do {
            let otp = "123456" // Generate a random 6-digit OTP
            // sendOTP(email, otp) // Send the OTP to the user via email
            var userOtp = userOtpRepository.findOne(byEmail: email)
            
            if userOtp != nil{
                userOtp!.otp = otp
                userOtp!.expiry = Date().addingTimeInterval(60 * 5) // OTP expires in 5 minutes
                userOtpRepository.update(userOtp: userOtp!)
                return true
            } else {
                userOtpRepository.create(userOtp: UserOtp(
                    email: email,
                    otp: otp,
                    expiry: Date().addingTimeInterval(60 * 5) // OTP expires in 5 minutes
                ))
                return true
            }
        } catch {
            throw AuthServiceError.otpVerificationFailed
        }
    }
    
    func verifyOtp(_ email: String, otp: String) throws -> User {
        var userOtp = userOtpRepository.findOne(byEmail: email)
        
        if userOtp != nil {
            if userOtp!.expiry < Date() {
                throw AuthServiceError.otpExpired
            }
            if userOtp!.otp == otp {
                let user = userRepository.findOne(byEmail: email)!
                if user != nil {
                    UserDefaults.standard.set(user.id, forKey: "userId")
                    return user
                }else {
                    throw AuthServiceError.userNotFound
                }
            } else {
                throw AuthServiceError.otpMismatch
            }
        }
        else{
            throw AuthServiceError.otpMismatch
        }
    }
    
    func signupUser(user: User) throws -> Bool {
        userRepository.create(user: user)
        UserDefaults.standard.set(user.id, forKey: "userId")
        return true
    }
    
    func getCurrentUser () throws -> User{
        let id = UserDefaults.standard.object(forKey: "userId")
        if id == nil {
            throw AuthServiceError.userNotFound
        }
        var user = userRepository.findOne(byId: id as! String)
        if user == nil {
            throw AuthServiceError.userNotFound
        }
        user!.college = collegeRepository.findOne(byId: user!.collegeId)
        user!.addresses = addressRepository.findAll(byUserId: user!.id)
        return user!
    }
    
    
}
