import UIKit

//MARK: - In-Out Parameters

struct User {
    var userId: Int?
    let name: String
}

func saveUser(_ user: inout User) {
    user.userId = 100
}

var user = User(name: "John Doe")
saveUser(&user)

print(user)

//MARK: - Nested functions

struct Pizza {
    let sauce: String
    let toppings: [String]
    let crust: String
}

class PizzaBuilder {
    
    func prepare() -> Pizza {
        
        func prepareSauce() -> String {
            return "Tomato Sauce"
        }
        
        func prepareCrust() -> String {
            return "Hand Tossed"
        }
        
        func prepareToppings() -> [String] {
            return ["Chicken", "Mushroom", "Onions"]
        }
        
        let crust = prepareCrust()
        let sauce = prepareSauce()
        let toppings = prepareToppings()
        
        return Pizza(sauce: sauce, toppings: toppings, crust: crust)
        
    }

}

let pizzaBuilder = PizzaBuilder()
let pizza = pizzaBuilder.prepare()

//MARK: - Closures

let hello: (String) -> () = { name in
    print("Hello \(name)!")
}

hello("Mary Doe")

let pow: (Int, Int) -> Int = {
    $0 * $1
}

let result = pow(5,3)
print(result)


func getPosts(completion: @escaping ([String]) -> ())  {
    
    var posts: [String] = []
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        posts = ["Hello World", "Introduction to Closures"]
        completion(posts)
    }
    
}

getPosts { (posts) in
    print(posts)
}
