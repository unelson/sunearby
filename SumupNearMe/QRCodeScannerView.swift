import SwiftUI

struct QRCodeScannerView: View {
    @Binding var userPoints: Int
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 30) {
            Text("QR Code Scanner")
                .font(.largeTitle)
                .padding()
            
            Text("Simulated QR code scan")
                .padding()
            
            Button(action: {
                // Simulate a successful scan that awards points.
                userPoints += 10
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Simulate Scan & Check-In (Add 10 pts)")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

/*greyed out the below as it seemed to suddenly slow down my laptop*/
//struct QRCodeScannerView_Previews: PreviewProvider {
//    static var previews: some View {
//        QRCodeScannerView(userPoints: .constant(100))
//    }
//}
