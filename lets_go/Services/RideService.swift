//
//  RideService.swift
//  lets_go
//
//  Created by student on 10/05/24.
//

import Foundation

import Foundation

class RideService {
    private let ridesRepository: RidesRepository
    private let bookingRepository: BookingRepository
    private let authService: AuthService
    private let addressRepository: AddressRepository
    private let vehicleRepository: VehicleRepository
    private let userRepository: UserRepository
    private let currentUserID: String // Assuming you have a way to get the current user's ID
    
    init() {
        self.ridesRepository = RidesRepository()
        self.bookingRepository = BookingRepository()
        self.authService = AuthService()
        self.addressRepository = AddressRepository()
        self.vehicleRepository = VehicleRepository()
        self.userRepository = UserRepository()
        self.currentUserID = (try! authService.getCurrentUser()).id
    }
    
    func getAllRidesNotCreatedByCurrentUser() -> [Rides] {
        let allRides = ridesRepository.findAll()
        return populateDetails(allRides.filter { $0.userId != currentUserID })
    }
    
    func getAllRidesCreatedByCurrentUser() -> [Rides] {
        let allRides = ridesRepository.findAll()
        return populateDetails(allRides.filter { $0.userId == currentUserID })
    }
    
    func getAllRidesCreatedByCurrentUserWithBookings() -> [Rides] {
        let allRides = ridesRepository.findAll()
        let ridesWithBookings = allRides.filter { ride in
            guard let bookings = ride.bookings else { return false }
            return bookings.contains { $0.userId == currentUserID }
        }
        return populateDetails(ridesWithBookings)
    }
    
    func getAllRidesBookedByCurrentUser() -> [Rides] {
        let allRides = ridesRepository.findAll()
        let ridesBookedByCurrentUser = allRides.filter { ride in
            guard let bookings = ride.bookings else { return false }
            return bookings.contains { $0.userId == currentUserID }
        }
        return populateDetails(ridesBookedByCurrentUser)
    }
    
    func getAllRidesPublishedByCurrentUser() -> [Rides] {
        let allRides = ridesRepository.findAll()
        print(populateDetails(allRides.filter { $0.userId == currentUserID }))
        return populateDetails(allRides.filter { $0.userId == currentUserID })
    }
    
    func createRide(ride: Rides) {
        ridesRepository.create(ride: ride)
    }
    
    private func populateDetails(_ rides: [Rides]) -> [Rides] {
        var ridesWithDetails: [Rides] = []
        for var ride in rides {
            ride.user = userRepository.findOne(byId: ride.userId)
            ride.from = addressRepository.findOne(byId: ride.fromId)
            ride.to = addressRepository.findOne(byId: ride.toId)
            ride.vehicle = vehicleRepository.findOne(byId: ride.vehicleId)
            ridesWithDetails.append(ride)
        }
        return ridesWithDetails
    }
}
