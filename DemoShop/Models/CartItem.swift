import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
    var subtotal: Double { product.price * Double(quantity) }
}

class CartStore: ObservableObject {
    @Published private(set) var items: [CartItem] = []

    var total: Double { items.reduce(0) { $0 + $1.subtotal } }
    var count: Int { items.reduce(0) { $0 + $1.quantity } }

    func add(_ product: Product) {
        if let idx = items.firstIndex(where: { $0.product.id == product.id }) {
            items[idx].quantity += 1
        } else {
            items.append(CartItem(product: product, quantity: 1))
        }
    }

    func remove(_ item: CartItem) {
        items.removeAll { $0.id == item.id }
    }

    func clear() { items.removeAll() }
}
