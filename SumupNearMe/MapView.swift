import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var businesses: [Business]
    @Binding var userLocation: CLLocationCoordinate2D?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()  // Create a new instance here.
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Remove existing annotations.
        uiView.removeAnnotations(uiView.annotations)
        
        // Create new annotations from the filtered list.
        let annotations = businesses.map { business -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.title = business.name
            annotation.subtitle = business.category
            annotation.coordinate = business.coordinate
            return annotation
        }
        uiView.addAnnotations(annotations)
        
        // Optionally, center the map on the user’s location.
        if let userLocation = userLocation {
            let region = MKCoordinateRegion(center: userLocation,
                                            latitudinalMeters: 1000,
                                            longitudinalMeters: 1000)
            uiView.setRegion(region, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            
            let identifier = "BusinessAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
            if let businessName = view.annotation?.title ?? "" {
                NotificationCenter.default.post(name: Notification.Name("ShowBusinessDetail"), object: businessName)
            }
        }
    }
}

//import SwiftUI
//import MapKit
//
//struct MapView: UIViewRepresentable {
//    @Binding var businesses: [Business]
//    @Binding var userLocation: CLLocationCoordinate2D?
//    
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()  // Create a new instance.
//        mapView.delegate = context.coordinator
//        mapView.showsUserLocation = true
//        mapView.userTrackingMode = .follow
//        return mapView
//    }
//    
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        // Remove existing annotations.
//        uiView.removeAnnotations(uiView.annotations)
//        
//        // Create new annotations from the filtered list.
//        let annotations = businesses.map { business -> MKPointAnnotation in
//            let annotation = MKPointAnnotation()
//            annotation.title = business.name
//            annotation.subtitle = business.category
//            annotation.coordinate = business.coordinate
//            return annotation
//        }
//        uiView.addAnnotations(annotations)
//        
//        // Optionally, center the map on the user’s location.
//        if let userLocation = userLocation {
//            let region = MKCoordinateRegion(center: userLocation,
//                                            latitudinalMeters: 1000,
//                                            longitudinalMeters: 1000)
//            uiView.setRegion(region, animated: true)
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapView
//        
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//        
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            if annotation is MKUserLocation {
//                return nil
//            }
//            
//            let identifier = "BusinessAnnotation"
//            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
//            
//            if annotationView == nil {
//                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                annotationView?.canShowCallout = true
//                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            } else {
//                annotationView?.annotation = annotation
//            }
//            return annotationView
//        }
//        
//        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//            let generator = UIImpactFeedbackGenerator(style: .medium)
//            generator.impactOccurred()
//            
//            if let businessName = view.annotation?.title ?? "" {
//                NotificationCenter.default.post(name: Notification.Name("ShowBusinessDetail"), object: businessName)
//            }
//        }
//    }
//}
