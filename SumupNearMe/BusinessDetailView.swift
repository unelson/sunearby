import SwiftUI

struct BusinessDetailView: View {
    let business: Business
    
    var body: some View {
        VStack(spacing: 20) {
            Text(business.name)
                .font(.largeTitle)
                .bold()
            Text(business.address)
                .font(.subheadline)
            Text("Category: \(business.category)")
            ForEach(business.paymentMethods, id: \.self) { method in
                Text("Payment: \(method)")
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("Business Details", displayMode: .inline)
    }
}

