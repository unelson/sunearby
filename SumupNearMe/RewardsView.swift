import SwiftUI

// A simple model for rewards.
struct Reward: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let pointsRequired: Int
}

struct RewardsView: View {
    @State private var userPoints: Int = 100 // Starting points for demonstration.
    @State private var showScanner = false
    @State private var scannedCode: String = ""
    
    let rewards: [Reward] = [
        Reward(title: "10% Off", description: "Get 10% off your next purchase", pointsRequired: 50),
        Reward(title: "Free Coffee", description: "Enjoy a free coffee at participating cafes", pointsRequired: 75),
        Reward(title: "Exclusive Merch", description: "Limited edition SumUp merchandise", pointsRequired: 100)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Your Points: \(userPoints)")
                    .font(.largeTitle)
                    .padding()
                
                Button(action: {
                    showScanner.toggle()
                }) {
                    Text("Check In with QR Code")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                .sheet(isPresented: $showScanner) {
                    QRCodeCameraView(scannedCode: $scannedCode)
                }
                .onChange(of: scannedCode) { newValue in
                    if !newValue.isEmpty {
                        // Simulate awarding points when a QR code is scanned.
                        userPoints += 10
                        print("Scanned QR Code: \(newValue)")
                    }
                }
                
                List(rewards) { reward in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(reward.title)
                                .font(.headline)
                            Text(reward.description)
                                .font(.subheadline)
                        }
                        Spacer()
                        Text("\(reward.pointsRequired) pts")
                    }
                }
            }
            .navigationBarTitle("Rewards Dashboard", displayMode: .inline)
        }
    }
}


/*greyed out the below as it seemed to suddenly slow down my laptop*/
//struct RewardsView_Previews: PreviewProvider {
//    static var previews: some View {
//        RewardsView()
//    }
//}
