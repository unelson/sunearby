import Foundation
import CoreLocation

struct Business: Identifiable, Equatable {
    let id: UUID
    let name: String
    let address: String
    let category: String
    let coordinate: CLLocationCoordinate2D
    let paymentMethods: [String]
    
    static func == (lhs: Business, rhs: Business) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.address == rhs.address &&
            lhs.category == rhs.category &&
            lhs.coordinate.latitude == rhs.coordinate.latitude &&
            lhs.coordinate.longitude == rhs.coordinate.longitude &&
            lhs.paymentMethods == rhs.paymentMethods
    }
}
