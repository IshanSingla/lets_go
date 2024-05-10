

import Foundation

struct Detail {
    let department: String
    let value: String
    let midNumber: String
}

enum UserServiceError: Error {
    case userNotInCollegeDomain
}

class UserService {
    
    private var collegeRepository: CollegeRepository!
    private let details = [
        Detail(department: "CSE", value: ".be", midNumber: "1099"),
        Detail(department: "BBA", value: ".bbaa", midNumber: "2099"),
        Detail(department: "BCA", value: ".ca", midNumber: "1099")
    ]
    
    init() {
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
            throw UserServiceError.userNotInCollegeDomain
        } catch {
            throw UserServiceError.userNotInCollegeDomain
        }
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
        var data: User = User(
            name: "",
            email: email,
            rollnumber: "",
            department: "",
            year: "",
            collegeId: college.id
        )
        
        if college.domain != "" {
            return data
        }
        
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
