//
//  FAQ.swift
//  lets_go
//
//  Created by Ishan Singla on 07/05/24.
//

import Foundation

struct FAQ {
    var id: String = UUID().uuidString
    var question: String
    var answer: String
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
}

class FAQRepository {
    private var faqs: [FAQ] = []
    
    init() {
        // Initialize with some default FAQs
        faqs = [
            FAQ(
                question: "Q1 How safe is vehicle pooling?",
                answer: "Vehicle pooling emphasizes safety through stringent driver vetting, real-time tracking, and emergency assistance features, ensuring a secure journey for all passengers.",
                createdAt: Date(),
                updatedAt: Date()
            ),
            FAQ(
                question: "Q2 Is the vehicle pooling service available in my area?",
                answer: "Check the app for availability in your area; services vary by location.",
                createdAt: Date(),
                updatedAt: Date()
            ),
            FAQ(
                question: "Q3 Can I choose my travel companions?",
                answer: "Travel companions are not selectable; matches are based on proximity and destination similarity.",
                createdAt: Date(),
                updatedAt: Date()
            ),
            FAQ(
                question: "Q4 What if I need to cancel my ride or change my destination?",
                answer: "Rides can be canceled or destinations changed through the app's interface.",
                createdAt: Date(),
                updatedAt: Date()
            ),
            FAQ(
                question: "Q5 How are fares calculated in the vehicle pooling app?",
                answer: "Fares are calculated based on distance, time, and demand, displayed before booking.",
                createdAt: Date(),
                updatedAt: Date()
            ),
            FAQ(
                question: "Q6 How do I report any issues during my ride?",
                answer: "Report issues promptly via the app for swift resolution.",
                createdAt: Date(),
                updatedAt: Date()
            ),
            FAQ(
                question: "Q7 Is there a customer support service available if there is miss happening while traveling?",
                answer: "Yes, customer support is available 24/7 for any travel mishaps",
                createdAt: Date(),
                updatedAt: Date()
            ),
            FAQ(
                question: "Q8 What types of vehicles are used for pooling?",
                answer: "Various vehicle types, including sedans, SUVs, and vans, are utilized for pooling.",
                createdAt: Date(),
                updatedAt: Date()
            ),
            FAQ(
                question: "Q9 Can I request a specific pickup or drop-off location?",
                answer: "Specify pickup and drop-off locations within the app for convenience.",
                createdAt: Date(),
                updatedAt: Date()
            ),
            FAQ(
                question: "Q10 What payment methods are accepted on the vehicle pooling app?",
                answer: "Accepted payment methods typically include credit/debit cards and digital wallets.",
                createdAt: Date(),
                updatedAt: Date()
            ),
            FAQ(
                question: "Q11 How do I contact my driver or fellow passengers before my ride?",
                answer: "Communicate with the driver and fellow passengers through the app's messaging feature before the ride.",
                createdAt: Date(),
                updatedAt: Date()
            ),
            FAQ(
                question: "Q12 What happens if there are no available rides in my area?",
                answer: "If no rides are available, consider alternative transportation options or check back later.",
                createdAt: Date(),
                updatedAt: Date()
            ),
            FAQ(
                question: "Q13 Can I use the vehicle pooling app for commuting to school?",
                answer: "Yes, the app can be used for commuting to school; ensure compliance with school policies.",
                createdAt: Date(),
                updatedAt: Date()
            ),
            FAQ(
                question: "Q14 How is data privacy and security maintained for users of the app?",
                answer: "Data privacy and security are ensured through robust encryption protocols and adherence to privacy regulations, safeguarding user information from unauthorized access or misuse.",
                createdAt: Date(),
                updatedAt: Date()
            )
        ]

    }
    
    func findAll() -> [FAQ] {
        return faqs
    }
    
    func findOne(byId id: String) -> FAQ? {
        return faqs.first(where: { $0.id == id })
    }
    
    func create(faq: FAQ) {
        faqs.append(faq)
    }
    
    func update(faq: FAQ) {
        if let index = faqs.firstIndex(where: { $0.id == faq.id }) {
            faqs[index] = faq
        }
    }
    
    func delete(byId id: String) {
        faqs.removeAll(where: { $0.id == id })
    }
}

