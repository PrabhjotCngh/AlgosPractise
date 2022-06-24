import UIKit

//MARK: -  Conditional Conformance

protocol CartProtocol {
    func computeTotal() -> Double
}

struct CartItem {
    let name: String
    let price: Double
}

struct Cart: CartProtocol {
    
    let items: [CartItem]
    
    func computeTotal() -> Double {
        return items.reduce(0) { (value, item) in
            return value + item.price
        }
    }
    
}

//If element is conforming to CartProtocol then Array should also conform to CartProtocol
extension Array: CartProtocol where Element: CartProtocol {
    
    func computeTotal() -> Double {
        return self.reduce(0) { (value, cart) in
            return value + cart.computeTotal()
        }
    }
    
}

let stores = [
    [Cart(items: [CartItem(name: "Milk", price: 4.50), CartItem(name: "Eggs", price: 2.50)]),
     Cart(items: [CartItem(name: "Fish", price: 12.00)])],
    [Cart(items: [CartItem(name: "Apple Airpod", price: 164.50),
                  CartItem(name: "iMac", price: 2302.50)]), Cart(items: [CartItem(name: "iPhone 12", price: 1200.00)])]
]

print(stores.computeTotal())

//MARK: - Type Erasers in Swift


protocol ConfigurableCell {
    associatedtype Model
    func configure(_ model: Model)
}

struct User {
    let name: String
}

class StudentCell: ConfigurableCell {
    typealias Model = User
    func configure(_ model: Model) {
        // configure
    }
}

class StaffCell: ConfigurableCell {
    typealias Model = User
    func configure(_ model: Model) {
        // confugure
    }
}

class AnyConfigurable: ConfigurableCell {
    
    typealias Model = Any
    private let configureCellClosure: (Any) -> Void
    
    init<T: ConfigurableCell>(_ configurableCell: T) {
        configureCellClosure = { model in
            guard let model = model as? T.Model else { return }
            configurableCell.configure(model)
        }
    }
    
    func configure(_ model: Any) {
        configureCellClosure(model)
    }
    
}


let cells = [AnyConfigurable(StudentCell()), AnyConfigurable(StaffCell())]


//let cells: [ConfigurableCell] = [StudentCell(), StaffCell()]
