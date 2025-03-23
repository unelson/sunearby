import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool  // Tracks whether the TextField is focused.

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search businesses...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isFocused)
                .submitLabel(.search) // Sets the Return key style to "Search".
                .onSubmit {
                    // When Return is pressed, dismiss the keyboard.
                    isFocused = false
                    print("Search submitted: \(text)")
                }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Example"))
    }
}
