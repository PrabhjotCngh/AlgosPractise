import UIKit

//MARK: - Lazy properties - Lazy properties only initialse once ex locationManager in coreLocation. Lazy properties are only initialised when we try to access them.

enum Level {
    case easy
    case medium
    case hard
}

struct Exam {
    
    var level: Level
    
    lazy private(set) var questions: [String] = {
        
        sleep(5)
        
        switch level {
            case .easy:
                return ["What is 1+2", "What is 1+2", "What is 2+2"]
            case .medium:
                return ["What is 11+22", "What is 11+22", "What is 32+42"]
            case .hard:
                return ["What is 122+332", "What is 441+255", "What is 266+250"]
        }
    }()
    
}

var exam = Exam(level: .easy)
//print(exam.questions)
var hardExam = exam
hardExam.level = .hard

print("[Hard Exam]")
///Lazy properties  will initialised here when try to access it
print(hardExam.questions)

//print("wait for 1 second")
//sleep(1)
//print(exam.questions)

//MARK: - Computed properties - Main idea behind computed property is anytime we try to access computed property its going to compute the result and return it back which may probably be based on some other properties.

struct CartItem {
    let name: String
    let price: Double
}

struct Cart {
    let items: [CartItem]
    
    //Computed property is defined here
    var total: Double {
        items.reduce(0) {
            return $0 + $1.price
        }
    }
}

let items = [CartItem(name: "Bread", price: 4.50), CartItem(name: "Milk", price: 3.50), CartItem(name: "Pizza", price: 10.95)]

let cart = Cart(items: items)
//Computed property is accessed here
print(cart.total)

struct Workout {
    let startTime: Date
    let endTime: Date
    
    var timeElapsed: TimeInterval {
        endTime.timeIntervalSince(startTime)
    }
}

let start = Date()
sleep(5)
let end = Date()

let workout = Workout(startTime: start, endTime: end)
workout.timeElapsed
 

//MARK: - Property Observers

struct Website {
    
    init(url: String) {
        
        defer { self.url = url }
        
        self.url = url
    }
    
    var url: String {
        
        didSet {
            url = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? url
        }
    }
    
}

var website = Website(url: "www.movies.com/?search=Lord of the Rings")
//website.url = "www.movies.com/?search=Lord of the Rings"
print(website)

// www.movies.com%2F%3Fsearch=Lord%20of%20the%20Rings
