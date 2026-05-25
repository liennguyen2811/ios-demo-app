import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var cart: CartStore
    @State private var addedToCart = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .frame(maxWidth: .infinity)
                        .frame(height: 240)
                    Image(systemName: "bag.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.orange.opacity(0.5))
                }
                .accessibilityIdentifier("product-image")

                VStack(alignment: .leading, spacing: 12) {
                    Text(product.name)
                        .font(.title2.bold())
                        .accessibilityIdentifier("product-detail-name")

                    Text(product.formattedPrice)
                        .font(.title3)
                        .foregroundColor(.orange)
                        .accessibilityIdentifier("product-detail-price")

                    Divider()

                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .accessibilityIdentifier("product-detail-description")

                    Button(action: {
                        cart.add(product)
                        addedToCart = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            addedToCart = false
                        }
                    }) {
                        HStack {
                            Image(systemName: addedToCart ? "checkmark.circle.fill" : "cart.badge.plus")
                            Text(addedToCart ? "Added!" : "Add to Cart")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(addedToCart ? Color.green : Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .accessibilityIdentifier("add-to-cart-button")
                    .animation(.easeInOut(duration: 0.2), value: addedToCart)
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 32)
        }
        .navigationTitle("Product Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
