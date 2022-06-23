import UIKit

//MARK: - Generics Implementation

struct Movie: Equatable {
    let name: String
}

let numbers = [1,2,3,5,6,7,10]
let names = ["Alex", "John", "Mary", "Steve"]
let movies = [Movie(name: "Batman"), Movie(name: "Spiderman"), Movie(name: "Superman")]

func firstLast<T>(_ list: [T]) -> (T, T) {
    return (list[0], list[list.count - 1] )
}

let (first, last) = firstLast(movies)

print(first)
print(last)

//MARK: - Constraints in generics

func findIndex<T: Equatable>(from list: [T], valueToFind: T) -> Int? {
    
    return list.firstIndex { (item) -> Bool in
        return item == valueToFind
    }
}

let batmanMovie = Movie(name: "Batman")

print(findIndex(from: movies, valueToFind: batmanMovie) ?? "")

//MARK: - Example 2

/*
struct Movie: Encodable {
    let title: String
}

func serializeToData<T: Encodable>(_ value: T) -> Data? {
    return try? JSONEncoder().encode(value)
}

print(serializeToData(Movie(title: "Batman")))
 */

protocol Fly { func fly() }
protocol Teleport { func teleport() }
protocol Strength { func throwObject() }

typealias SuperHero = Fly & Teleport & Strength

struct Electronman: SuperHero {
   
    func fly() { }
    func teleport() { }
    func throwObject() { }
}

struct Superman: Fly {
    func fly() { }
}

func attack<T: SuperHero>(value: T) {
    
}

let electronMan = Electronman()
attack(value: electronMan)

//attack(value: Superman())

//MARK: - Equatable and Comparable Protocols

enum Card: Comparable {
    case ace
    case king
    case queen
    
    static func <(lhs: Card, rhs: Card) -> Bool {
        switch(lhs, rhs) {
            case (king, ace): return true
            case (queen, king): return true
            case (queen, ace): return true
            default: return false
        }
    }
}


func lowest<T: Comparable>(list: [T]) -> T? {
    
    let sortedList = list.sorted {
        return $0 < $1
    }
    
    return sortedList.first
}

print(lowest(list: [4,5,6,1,200,-100, 999]) ?? "")

print(lowest(list: ["b","c","a","z"]) ?? "")

let ace = Card.ace
let queen = Card.queen

if queen < ace {
    print("queen < ace")
}

print(lowest(list: [Card.ace, Card.queen, Card.king]) ?? "")

//MARK: - Creating a Generic Type

enum NetworkError: Error {
    case badUrl
}

struct Post: Codable {
    let title: String
}

enum Callback<T: Codable, K: Error> {
    case success(T)
    case failure(K)
}

func getPosts(completion: (Callback<[Post], NetworkError>) -> Void) {
    
    // get all posts
    let posts = [Post(title: "Hello World"), Post(title: "Introduction to Swift")]
    completion(.success(posts))
    //completion(.failure(.badUrl))
    
}

getPosts { (result) in
    switch result {
        case .success(let posts):
            print(posts)
        case .failure(let error):
            print(error)
    }
}
