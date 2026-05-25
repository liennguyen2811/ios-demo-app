import XCTest
@testable import DemoShop

final class AuthServiceTests: XCTestCase {
    func testValidLogin() {
        XCTAssertNoThrow(try AuthService.login(username: "standard_user", password: "secret_sauce"))
    }

    func testLockedOutUser() {
        XCTAssertThrowsError(try AuthService.login(username: "locked_out_user", password: "secret_sauce")) { error in
            XCTAssertEqual(error as? AuthError, AuthError.lockedOut)
        }
    }

    func testInvalidPassword() {
        XCTAssertThrowsError(try AuthService.login(username: "standard_user", password: "wrong")) { error in
            XCTAssertEqual(error as? AuthError, AuthError.invalidCredentials)
        }
    }

    func testEmptyCredentials() {
        XCTAssertThrowsError(try AuthService.login(username: "", password: "")) { error in
            XCTAssertEqual(error as? AuthError, AuthError.emptyFields)
        }
    }
}

final class CartStoreTests: XCTestCase {
    var cart: CartStore!

    override func setUp() { cart = CartStore() }

    func testAddProduct() {
        let product = Product.catalog[0]
        cart.add(product)
        XCTAssertEqual(cart.count, 1)
        XCTAssertEqual(cart.items.count, 1)
    }

    func testAddSameProductIncreasesQty() {
        let product = Product.catalog[0]
        cart.add(product)
        cart.add(product)
        XCTAssertEqual(cart.items.count, 1)
        XCTAssertEqual(cart.items[0].quantity, 2)
    }

    func testTotalCalculation() {
        cart.add(Product.catalog[0]) // $29.99
        cart.add(Product.catalog[1]) // $9.99
        XCTAssertEqual(cart.total, 39.98, accuracy: 0.01)
    }

    func testClearCart() {
        cart.add(Product.catalog[0])
        cart.clear()
        XCTAssertTrue(cart.items.isEmpty)
    }
}
