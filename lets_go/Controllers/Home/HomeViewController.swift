//
//  HomeViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 26/04/24.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            // Dismiss the keyboard
            searchBar.resignFirstResponder()
            
            // Perform the search
            if let searchText = searchBar.text, !searchText.isEmpty {
                searchForLocation(searchText)
            }
    }
        
    func searchForLocation(_ searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard error == nil else {
                // Handle error
                print("Error occurred during search: \(error!.localizedDescription)")
                return
            }
            
            guard let response = response else {
                // Handle empty response
                print("No results found for the search.")
                return
            }
            
            // Remove previous annotations
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            // Add annotations to the map
            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.title = item.name
                annotation.coordinate = item.placemark.coordinate
                self.mapView.addAnnotation(annotation)
            }
            
            // Adjust the map region to fit the annotations
            if let firstResult = response.mapItems.first {
                let region = MKCoordinateRegion(center: firstResult.placemark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                self.mapView.setRegion(region, animated: true)
            }
        }
    }

}
