import Foundation
import CoreLocation
import MapKit
import Combine

class BusinessViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var businesses: [Business] = []
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var searchText: String = ""
    
    private var locationManager = CLLocationManager()
    private var cancellables = Set<AnyCancellable>()
    private var allBusinesses: [Business] = []
    
    override init() {
        super.init()
        locationManager.delegate = self
        setupSearch()
        fetchBusinesses()
    }
    
    func checkLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func fetchBusinesses() {
        // Original mock data remains unchanged.
        let mockData = [
            Business(
                id: UUID(),
                name: "Cafe SumUp",
                address: "123 Coffee St",
                category: "Café",
                coordinate: CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186),
                paymentMethods: ["SumUp Payments"]
            ),
            Business(
                id: UUID(),
                name: "Restaurant SumUp",
                address: "456 Dine Ave",
                category: "Restaurant",
                coordinate: CLLocationCoordinate2D(latitude: 37.334900, longitude: -122.009020),
                paymentMethods: ["SumUp Payments"]
            ),
            Business(
                id: UUID(),
                name: "Retail SumUp",
                address: "789 Shop Rd",
                category: "Retail",
                coordinate: CLLocationCoordinate2D(latitude: 37.331700, longitude: -122.030200),
                paymentMethods: ["SumUp Payments"]
            )
        ]
        
        // Generate 20 additional simulated businesses based in London.
        var londonBusinesses: [Business] = []
        let londonCenter = CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278)
        
        // Array of sample names for London businesses.
        // You can customize these names as you like.
        let sampleNames = [
            "The King's Arms",
            "The Queen's Head",
            "The Red Lion",
            "The Crown & Anchor",
            "The White Hart",
            "The Black Swan",
            "The Golden Fleece",
            "The Rose & Crown",
            "The Duke's Tavern",
            "The Windsor Arms",
            "The Mayflower",
            "The Ship Inn",
            "The Old Bell",
            "The Victoria",
            "The Royal Oak",
            "The Black Horse",
            "The Green Man",
            "The Lamb & Flag",
            "The Anchor",
            "The Fox & Hounds"
        ]
        
        for i in 0..<20 {
            let randomLatOffset = Double.random(in: -0.02...0.02)
            let randomLonOffset = Double.random(in: -0.02...0.02)
            let coordinate = CLLocationCoordinate2D(
                latitude: londonCenter.latitude + randomLatOffset,
                longitude: londonCenter.longitude + randomLonOffset
            )
            // Cycle through sampleNames array.
            let businessName = sampleNames[i % sampleNames.count]
            let business = Business(
                id: UUID(),
                name: businessName,
                address: "\(i + 1) London Road",
                category: "Pub",
                coordinate: coordinate,
                paymentMethods: ["SumUp Payments"]
            )
            londonBusinesses.append(business)
        }
        
        // Combine both sets of businesses.
        let allMockData = mockData + londonBusinesses
        self.allBusinesses = allMockData
        self.businesses = allMockData
    }
    
    func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in self?.applyFilters() }
            .store(in: &cancellables)
    }
    
    func applyFilters() {
        if searchText.isEmpty {
            businesses = allBusinesses
        } else {
            let filtered = allBusinesses.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            businesses = filtered
        }
    }
    
    // MARK: - CLLocationManagerDelegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            DispatchQueue.main.async {
                self.userLocation = location.coordinate
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}


//import Foundation
//import CoreLocation
//import MapKit
//import Combine
//
//class BusinessViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
//    @Published var businesses: [Business] = []
//    @Published var userLocation: CLLocationCoordinate2D?
//    @Published var searchText: String = ""
//    
//    private var locationManager = CLLocationManager()
//    private var cancellables = Set<AnyCancellable>()
//    private var allBusinesses: [Business] = []
//    
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        setupSearch()
//        fetchBusinesses()
//    }
//    
//    func checkLocationAuthorization() {
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//    
//    func fetchBusinesses() {
//        // For MVP purposes, we use mocked data.
//        let mockData = [
//            Business(id: UUID(), name: "Cafe SumUp", address: "123 Coffee St", category: "Café", coordinate: CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.0312186), paymentMethods: ["SumUp Payments"]),
//            Business(id: UUID(), name: "Restaurant SumUp", address: "456 Dine Ave", category: "Restaurant", coordinate: CLLocationCoordinate2D(latitude: 37.334900, longitude: -122.009020), paymentMethods: ["SumUp Payments"]),
//            Business(id: UUID(), name: "Retail SumUp", address: "789 Shop Rd", category: "Retail", coordinate: CLLocationCoordinate2D(latitude: 37.331700, longitude: -122.030200), paymentMethods: ["SumUp Payments"])
//        ]
//        // Store the full set in a separate variable.
//        self.allBusinesses = mockData
//        // Initially, display all businesses.
//        self.businesses = allBusinesses
//    }
//    
//    func setupSearch() {
//        // Listen to changes in the search text and apply filters.
//        $searchText
//            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
//            .removeDuplicates()
//            .sink { [weak self] _ in
//                self?.applyFilters()
//            }
//            .store(in: &cancellables)
//    }
//    
//    func applyFilters() {
//        print("Search text: \(searchText)")
//        if searchText.isEmpty {
//            businesses = allBusinesses
//        } else {
//            let filtered = allBusinesses.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
//            businesses = filtered
//            print("Filtered businesses: \(filtered.map { $0.name })")
//        }
//    }
//    
//    // CLLocationManagerDelegate methods:
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else { return }
//        DispatchQueue.main.async {
//            self.userLocation = location.coordinate
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Location error: \(error.localizedDescription)")
//    }
//}
