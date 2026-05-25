import Foundation

struct Product: Identifiable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let imageName: String

    var formattedPrice: String { String(format: "$%.2f", price) }
}

extension Product {
    static let catalog: [Product] = [
        Product(id: 1, name: "Sauce Labs Backpack",
                description: "carry.allTheThings() with the sleek, streamlined Sly Pack.",
                price: 29.99, imageName: "backpack"),
        Product(id: 2, name: "Sauce Labs Bike Light",
                description: "A red light isn't the desired state in testing but it sure helps.",
                price: 9.99, imageName: "bikelight"),
        Product(id: 3, name: "Sauce Labs Bolt T-Shirt",
                description: "Get your testing superhero on with the Sauce Labs bolt T-shirt.",
                price: 15.99, imageName: "tshirt"),
        Product(id: 4, name: "Sauce Labs Fleece Jacket",
                description: "It's not every day that you come across a midweight fleece jacket.",
                price: 49.99, imageName: "jacket"),
        Product(id: 5, name: "Sauce Labs Onesie",
                description: "Rib snap infant onesie for the junior automation engineer.",
                price: 7.99, imageName: "onesie"),
        Product(id: 6, name: "Test.allTheThings() T-Shirt",
                description: "This classic Sauce Labs t-shirt is perfect to wear at any automation convention.",
                price: 15.99, imageName: "tshirt_red"),
    ]
}
