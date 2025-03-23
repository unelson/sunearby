import SwiftUI

// A simple model for merchants.
struct Merchant: Identifiable {
    let id = UUID()
    let name: String
    let offer: String
}

struct MerchantPortalView: View {
    // Sample merchant data.
    let merchants: [Merchant] = [
        Merchant(name: "Cafe SumUp", offer: "Earn double points on weekdays!"),
        Merchant(name: "Restaurant SumUp", offer: "Free dessert with every meal on Fridays!"),
        Merchant(name: "Retail SumUp", offer: "Exclusive discounts on new arrivals!")
    ]
    
    var body: some View {
        NavigationView {
            List(merchants) { merchant in
                VStack(alignment: .leading) {
                    Text(merchant.name)
                        .font(.headline)
                    Text(merchant.offer)
                        .font(.subheadline)
                }
                .padding(.vertical, 5)
            }
            .navigationBarTitle("Merchant Portal", displayMode: .inline)
        }
    }
}

/*greyed out the below as it seemed to suddenly slow down my laptop*/
//struct MerchantPortalView_Previews: PreviewProvider {
//    static var previews: some View {
//        MerchantPortalView()
//    }
//}
