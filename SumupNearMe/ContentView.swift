import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = BusinessViewModel()
    @State private var selectedBusiness: Business? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                // Only ignore the top safe area so the Tab Bar remains visible
                MapView(businesses: $viewModel.businesses, userLocation: $viewModel.userLocation)
                    .ignoresSafeArea(edges: .top)
                VStack {
                    Spacer()
                    SearchBar(text: $viewModel.searchText)
                        .padding()
                }
            }
            .navigationBarTitle("SumUp", displayMode: .inline)
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ShowBusinessDetail"))) { notification in
                if let businessName = notification.object as? String,
                   let business = viewModel.businesses.first(where: { $0.name == businessName }) {
                    selectedBusiness = business
                }
            }
            .sheet(item: $selectedBusiness) { business in
                NavigationView {
                    BusinessDetailView(business: business)
                }
            }
        }
        .onAppear {
            viewModel.fetchBusinesses()
            viewModel.checkLocationAuthorization()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
