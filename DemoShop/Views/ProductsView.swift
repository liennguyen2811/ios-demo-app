import SwiftUI

struct ProductsView: View {
    @EnvironmentObject var cart: CartStore
    @EnvironmentObject var auth: AuthViewModel
    @State private var showCart = false
    @State private var sortOrder: SortOrder = .nameAZ

    enum SortOrder: String, CaseIterable {
        case nameAZ = "Name (A-Z)"
        case nameZA = "Name (Z-A)"
        case priceLow = "Price (Low-High)"
        case priceHigh = "Price (High-Low)"
    }

    var sortedProducts: [Product] {
        switch sortOrder {
        case .nameAZ:   return Product.catalog.sorted { $0.name < $1.name }
        case .nameZA:   return Product.catalog.sorted { $0.name > $1.name }
        case .priceLow: return Product.catalog.sorted { $0.price < $1.price }
        case .priceHigh: return Product.catalog.sorted { $0.price > $1.price }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("Sort", selection: $sortOrder) {
                    ForEach(SortOrder.allCases, id: \.self) { Text($0.rawValue).tag($0) }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .accessibilityIdentifier("sort-picker")

                Divider()

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(sortedProducts) { product in
                            NavigationLink(destination: ProductDetailView(product: product)) {
                                ProductCardView(product: product)
                            }
                            .buttonStyle(.plain)
                            .accessibilityIdentifier("product-cell-\(product.id)")
                        }
                    }
                    .padding()
                }
                .accessibilityIdentifier("products-grid")
            }
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Logout") { auth.logout() }
                        .accessibilityIdentifier("logout-button")
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showCart = true
                    } label: {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "cart")
                            if cart.count > 0 {
                                Text("\(cart.count)")
                                    .font(.caption2.bold())
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 8, y: -8)
                            }
                        }
                    }
                    .accessibilityIdentifier("cart-button")
                }
            }
            .sheet(isPresented: $showCart) {
                CartView()
                    .environmentObject(cart)
                    .environmentObject(auth)
            }
        }
    }
}

struct ProductCardView: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray6))
                    .frame(height: 120)
                Image(systemName: "bag.fill")
                    .font(.system(size: 44))
                    .foregroundColor(.orange.opacity(0.6))
            }

            Text(product.name)
                .font(.caption.bold())
                .lineLimit(2)
                .foregroundColor(.primary)
                .accessibilityIdentifier("product-name-\(product.id)")

            Text(product.formattedPrice)
                .font(.caption)
                .foregroundColor(.orange)
                .accessibilityIdentifier("product-price-\(product.id)")
        }
        .padding(8)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
    }
}
