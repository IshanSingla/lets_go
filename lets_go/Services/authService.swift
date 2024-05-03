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
    case userNotInCollegeDomain
}
struct Detail {
    let department: String
    let value: String
    let midNumber: String
}

let details = [
    Detail(department: "CSE", value: ".be", midNumber: "1099"),
    Detail(department: "BBA", value: ".bbaa", midNumber: "2099"),
    Detail(department: "BCA", value: ".ca", midNumber: "1099")
]

class AuthService {
    var userRepository: UserRepository!
    var userOtpRepository: UserOtpRepository!
    var collegeRepository: CollegeRepository!
    
    init() {
        userRepository = UserRepository()
        userOtpRepository = UserOtpRepository()
        collegeRepository = CollegeRepository()
    }
    
    func verifyEmailWithCollegeDomain(email: String) throws -> College {
        do {
            var colleges: [College] = collegeRepository.findAll()
            for college in colleges {
                let domainRegexPattern = "^.*@(\\Q\(college.domain)\\E)$"
                guard let regex = try? NSRegularExpression(pattern: domainRegexPattern, options: []) else {
                    continue // Skip to the next college if there's an issue with regex
                }
                if regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil {
                    return college // Return true if there's a match
                }
            }
            throw AuthServiceError.userNotInCollegeDomain
        } catch {
            throw AuthServiceError.userNotInCollegeDomain
        }
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
                var user = userRepository.findOne(byEmail: email)!
                if user != nil {
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
    
    func getUser (_ id:String)throws -> User{
        let user = userRepository.findOne(byId: id)
        if user == nil {
            throw AuthServiceError.userNotFound
        }
        return user!
    }
    
    
    
    
    private func matchingStrings(input: String, regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = input as NSString
        let results = regex.matches(in: input, options: [], range: NSRange(location: 0, length: nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map {
                result.range(at: $0).location != NSNotFound ? nsString.substring(with: result.range(at: $0)) : ""
            }
        }
    }

    func getUserInfoDuringSignup(email: String) throws -> User {
        var college = try verifyEmailWithCollegeDomain(email: email)
        
        if email.contains("@chitkara.edu.in") {
            return User(
                name: "",
                email: email,
                rollnumber: "",
                department: "",
                year: "",
                collegeId: college.id
            )
        }
        var data: User = User(
            name: "",
            email: email,
            rollnumber: "",
            department: "",
            year: "",
            collegeId: college.id
        )
        
        var condition = false
        for (index, detail) in details.enumerated() {
            if index == 0 {
                condition = false
            } else if condition {
                return data
            }
            let yearReg = try! NSRegularExpression(pattern: "\(detail.value)(\\d+)", options: .caseInsensitive)
            if yearReg.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) != nil {
                if let year = matchingStrings(input: email, regex: "\(detail.value)(\\d+)").first?[1] {
                    data.year = String("20" + year)
                    if let number = matchingStrings(input: email, regex: "[a-zA-Z](\\d+)").first?[1] {
                        let roll = year + detail.midNumber + number
                        data.rollnumber = roll
                        if detail.department == "CSE" && (3751...3900).contains(Int(number) ?? 0) {
                            data.department = "CSE AI"
                        } else {
                            data.department = detail.department
                        }
                    }
                }
            }
        }
        return data
    }
    
    
}
