import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: CartStore
    @EnvironmentObject var auth: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showCheckout = false

    var body: some View {
        NavigationStack {
            Group {
                if cart.items.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "cart.badge.minus")
                            .font(.system(size: 60))
                            .foregroundColor(.secondary)
                        Text("Your cart is empty")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .accessibilityIdentifier("empty-cart-message")
                } else {
                    VStack(spacing: 0) {
                        List {
                            ForEach(cart.items) { item in
                                CartRowView(item: item)
                                    .accessibilityIdentifier("cart-item-\(item.product.id)")
                            }
                            .onDelete { indices in
                                indices.forEach { cart.remove(cart.items[$0]) }
                            }
                        }
                        .accessibilityIdentifier("cart-list")

                        Divider()

                        VStack(spacing: 12) {
                            HStack {
                                Text("Total")
                                    .font(.headline)
                                Spacer()
                                Text(String(format: "$%.2f", cart.total))
                                    .font(.headline)
                                    .foregroundColor(.orange)
                                    .accessibilityIdentifier("cart-total")
                            }
                            .padding(.horizontal)

                            Button("Checkout") {
                                showCheckout = true
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .font(.headline)
                            .padding(.horizontal)
                            .accessibilityIdentifier("checkout-button")
                        }
                        .padding(.vertical)
                        .background(Color(.systemBackground))
                    }
                }
            }
            .navigationTitle("My Cart")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { dismiss() }
                        .accessibilityIdentifier("close-cart-button")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !cart.items.isEmpty {
                        Button("Remove All") { cart.clear() }
                            .foregroundColor(.red)
                            .accessibilityIdentifier("remove-all-button")
                    }
                }
            }
            .sheet(isPresented: $showCheckout) {
                CheckoutView()
                    .environmentObject(cart)
                    .environmentObject(auth)
            }
        }
    }
}

struct CartRowView: View {
    let item: CartItem

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.product.name)
                    .font(.subheadline.bold())
                    .lineLimit(2)
                    .accessibilityIdentifier("cart-item-name")
                Text("Qty: \(item.quantity)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .accessibilityIdentifier("cart-item-qty")
            }
            Spacer()
            Text(String(format: "$%.2f", item.subtotal))
                .font(.subheadline)
                .foregroundColor(.orange)
                .accessibilityIdentifier("cart-item-subtotal")
        }
    }
}
