import UIKit

//MARK: - Iterators

let names = ["Alex", "John", "Mary"]

var nameIterator = names.makeIterator()
while let name = nameIterator.next() {
    print(name)
}

/*
for name in names {
    print(name)
} */

/*
protocol IteratorProtocol {
    associatedtype Element
    
    mutating func next() -> Element?
} */

struct Countdown: Sequence {
    
    let start: Int
    
    func makeIterator() -> some IteratorProtocol {
        return CountdownIterator(self)
    }
}

struct CountdownIterator: IteratorProtocol {
    let countdown: Countdown
    var currentValue = 0
    
    init(_ countdown: Countdown) {
        self.countdown = countdown
        self.currentValue = countdown.start
    }
    
    mutating func next() -> Int? {
        if currentValue > 0 {
            let value = currentValue
            currentValue -= 1
            return value
        } else {
            return nil
        }
    }
}

let countdown = Countdown(start: 10)
for count in countdown {
    print(count)
}

//MARK: - Filters

/*
var names = ["Alex", "John", "Steven", "Mary"]

names = names.filter { name in
    return name.count > 4
}

print(names)
*/

struct Movie {
    let title: String
    let genre: String
}

var moviesList = [Movie(title: "Lord of the Rings", genre: "Fiction"), Movie(title: "ET", genre: "Fiction"),
              Movie(title: "Finding Nemo", genre: "Kids"), Movie(title: "Cars", genre: "Kids")]

let movieToRemove = Movie(title: "Finding Nemo", genre: "Kids")

moviesList = moviesList.filter { movie in
    return movie.title != movieToRemove.title
}

print(moviesList)


//let kidMovies = movies.filter { movie in
//    return movie.genre == "Kids"
//}

//print(kidMovies)

//MARK: - forEach and enumeration

moviesList.forEach { movie in
    addToFavoriteList(movie)
}

func addToFavoriteList(_ movie: Movie) {
    
}

moviesList.enumerated().forEach { (index, movie) in
    print("Movie at \(index) has a title \(movie.title)")
}

//MARK: - Lazy Iteration

let indexes = 1..<5000

let images = indexes.lazy.filter { index -> Bool in
    print("[filter]")
    return index % 2 == 0
}.map { index -> String in
    print("[Map]")
    return "image_\(index)"
}

let lastThreeImages = images.suffix(3)
for img in lastThreeImages {
    print(img)
}

//MARK: - Reduce

struct Item {
    let name: String
    let price: Double
}

struct Cart {
    
    private(set) var items: [Item] = []
    
    mutating func addItem(_ item: Item) {
        items.append(item)
    }
    
    var total: Double {
        items.reduce(0) { (value, item) -> Double in
            return value + item.price
        }
    }
}

var cart = Cart()
cart.addItem(Item(name: "Milk", price: 4.50))
cart.addItem(Item(name: "Bread", price: 2.50))
cart.addItem(Item(name: "Eggs", price: 12.50))

print(cart.total)

let items = [2.0,4.0,5.0,7.0]
let total = items.reduce(0, +)

print(total)

// MARK: - Reduce into

let ratings = [4, 8.5, 9.5, 2, 6, 3, 5.5, 7, 2.8, 9.8, 5.9, 1.5]

let ratingsResult = ratings.reduce([:]) { (results: [String: Int], rating: Double) in
    var copy = results // <<< How can you make sure that copy is NOT created. Creating a lot of copies can reduce performance
    switch rating {
        case 1..<4: copy["Very bad", default: 0] += 1
        case 4..<6: copy["Ok", default: 0] += 1
        case 6..<8: copy["Good", default: 0] += 1
        case 8..<11: copy["Excellent", default: 0] += 1
        default: break
    }
    
    return copy
}

let results = ratings.reduce(into: [:]) { (results: inout [String: Int], rating: Double)  in
    
    switch rating {
        case 1..<4: results["Very bad", default: 0] += 1
        case 4..<6: results["Ok", default: 0] += 1
        case 6..<8: results["Good", default: 0] += 1
        case 8..<11: results["Excellent", default: 0] += 1
        default: break
    }

}

print(results)

//MARK: - Zip

let students = ["Alex", "Mary", "John", "Steven"]
let grades = [3.4, 2.8]

let pair = zip(students, grades)

for studentAndGrade in pair {
    print(studentAndGrade.0)
    print(studentAndGrade.1)
}
