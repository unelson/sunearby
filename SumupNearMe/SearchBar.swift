import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Find a SumUp business...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
