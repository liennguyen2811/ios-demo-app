import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var cart: CartStore
    @EnvironmentObject var auth: AuthViewModel
    @Environment(\.dismiss) var dismiss

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var postalCode = ""
    @State private var errorMessage = ""
    @State private var isOrderPlaced = false

    var body: some View {
        NavigationStack {
            if isOrderPlaced {
                OrderConfirmationView()
                    .environmentObject(cart)
                    .environmentObject(auth)
            } else {
                Form {
                    Section("Delivery Information") {
                        TextField("First Name", text: $firstName)
                            .accessibilityIdentifier("first-name-field")
                        TextField("Last Name", text: $lastName)
                            .accessibilityIdentifier("last-name-field")
                        TextField("Postal Code", text: $postalCode)
                            .keyboardType(.numberPad)
                            .accessibilityIdentifier("postal-code-field")
                    }

                    if !errorMessage.isEmpty {
                        Section {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .accessibilityIdentifier("checkout-error")
                        }
                    }

                    Section("Order Summary") {
                        ForEach(cart.items) { item in
                            HStack {
                                Text(item.product.name).font(.caption)
                                Spacer()
                                Text(String(format: "$%.2f", item.subtotal)).font(.caption)
                            }
                        }
                        HStack {
                            Text("Total").bold()
                            Spacer()
                            Text(String(format: "$%.2f", cart.total))
                                .bold()
                                .foregroundColor(.orange)
                                .accessibilityIdentifier("checkout-total")
                        }
                    }

                    Section {
                        Button("Place Order") {
                            placeOrder()
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .listRowBackground(Color.orange)
                        .accessibilityIdentifier("place-order-button")
                    }
                }
                .navigationTitle("Checkout")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") { dismiss() }
                            .accessibilityIdentifier("cancel-checkout-button")
                    }
                }
            }
        }
    }

    private func placeOrder() {
        errorMessage = ""
        guard !firstName.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "First Name is required."
            return
        }
        guard !lastName.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Last Name is required."
            return
        }
        guard !postalCode.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Postal Code is required."
            return
        }
        isOrderPlaced = true
    }
}

struct OrderConfirmationView: View {
    @EnvironmentObject var cart: CartStore
    @EnvironmentObject var auth: AuthViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
                .accessibilityIdentifier("order-success-icon")

            Text("Thank you for your order!")
                .font(.title2.bold())
                .accessibilityIdentifier("order-success-title")

            Text("Your order has been placed and is being processed.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Back to Products") {
                cart.clear()
                dismiss()
                dismiss()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal, 32)
            .accessibilityIdentifier("back-to-products-button")

            Spacer()
        }
        .accessibilityIdentifier("order-confirmation-screen")
    }
}
