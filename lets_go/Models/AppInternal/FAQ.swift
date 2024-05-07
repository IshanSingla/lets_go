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
        self.create(faq: FAQ(question: "What is Lorem Ipsum?", answer: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.", createdAt: Date(), updatedAt: Date()))
        
        self.create(faq: FAQ(question: "Why do we use it?", answer: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.", createdAt: Date(), updatedAt: Date()))
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

