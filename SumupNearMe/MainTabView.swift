import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // Business discovery (existing map view)
            ContentView()
                .tabItem {
                    Label("Discover", systemImage: "map")
                }
            
            // Rewards Dashboard (see RewardsView below)
            RewardsView()
                .tabItem {
                    Label("Rewards", systemImage: "gift")
                }
            
            // Merchant Portal (see MerchantPortalView below)
            MerchantPortalView()
                .tabItem {
                    Label("Merchants", systemImage: "building.2")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
