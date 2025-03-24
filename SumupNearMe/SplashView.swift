import SwiftUI

struct SplashView: View {
    // When this becomes true, we'll transition to the main content.
    @State private var isActive = false

    var body: some View {
        if isActive {
            // Replace MainTabView() with your main view, e.g., ContentView() if needed.
            MainTabView()
        } else {
            // Display the SumUp logo in the center.
            VStack {
                Image("SumUpLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .onAppear {
                // After 3 seconds, transition to the main content.
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
