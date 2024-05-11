//
//  StartrideViewController.swift
//  lets_go
//
//  Created by student on 10/05/24.
//

import UIKit
import CoreLocation


class StartrideViewController: UIViewController , CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        // Content to be shared (e.g., text, URLs, images)
             let textToShare = "Hey, check out this awesome ride sharing app!"
             let urlToShare = URL(string: "https://yourappwebsite.com")
             let itemsToShare: [Any] = [textToShare, urlToShare as Any]
             
             // Create an instance of UIActivityViewController
             let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
             
             // Exclude specific services from the list (optional)
             activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
             
             // Present the UIActivityViewController
             if let popoverController = activityViewController.popoverPresentationController {
                 popoverController.sourceView = sender
                 popoverController.sourceRect = sender.bounds
             }
             present(activityViewController, animated: true, completion: nil)
         }
    
    @IBAction func callSOSButtonPressed(_ sender: UIButton) {
        callEmergencyNumber(number: "911")
    }
    func callEmergencyNumber(number: String) {
           if let phoneCallURL = URL(string: "tel://\(number)") {
               let application = UIApplication.shared
               if application.canOpenURL(phoneCallURL) {
                   application.open(phoneCallURL, options: [:], completionHandler: nil)
               }
           }
       }
       
       // MARK: - Location Manager Delegate
       
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           if status == .authorizedWhenInUse || status == .authorizedAlways {
               // Location services are authorized, you can start updating location
               locationManager.startUpdatingLocation()
           }
       }
       
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           // Handle updated location here if needed
           guard let location = locations.first else { return }
           print("Current location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
       }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("Location manager failed with error: \(error.localizedDescription)")
       }
    
    }
    

    

