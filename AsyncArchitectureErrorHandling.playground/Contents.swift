import UIKit

//MARK: - Before Result Type - Using Success and Failure Callbacks

struct Post: Decodable {
    let title: String
    let body: String
}

enum NetworkError: Error {
    case badURL
    case invalidData
    case decodingError
}

func getPosts(with url: URL, success: @escaping ([Post]) -> Void, failure: @escaping (NetworkError?) -> Void) {
    
    URLSession.shared.dataTask(with: url) { (data, _, error) in
        
        guard let data = data, error == nil else {
            failure(NetworkError.invalidData)
            return
        }
        
        let posts = try? JSONDecoder().decode([Post].self, from: data)
        if let posts = posts {
            success(posts)
        } else {
            failure(NetworkError.decodingError)
        }
    }
}

guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
    throw NetworkError.badURL
}

getPosts(with: url) { (posts) in
    
} failure: { (error) in
    
}

//MARK: - Using Result Type

//Updated the previous method getPosts with Result type instead of using two different completion handler for success and failure
func getNewPosts(with url: URL, completion: @escaping (Result<[Post], NetworkError>) -> Void) {
    
    URLSession.shared.dataTask(with: url) { (data, _, error) in
        
        guard let data = data, error == nil else {
            completion(.failure(.invalidData))
            return
        }
        
        let posts = try? JSONDecoder().decode([Post].self, from: data)
        if let posts = posts {
            completion(.success(posts))
        } else {
            completion(.failure(.decodingError))
        }
    }
}

getNewPosts(with: url) { (result) in
    switch result {
        case .success(let posts):
            print(posts)
        case .failure(let error):
            print(error)
    }
}

//MARK: - Multiple Errors Inside of Result

struct Account: Codable {
    let balance: Double
}

struct Transaction: Codable {
    let from: Account
    let to: Account
    let amount: Double
}

enum AccountError: Error {
    case insufficientFunds
    case amountToLow
}

func transferFunds(url: URL, from: Account, to: Account, amount: Double, completion: @escaping (Result<String, Error>) -> Void) {
                    
    guard amount > 0 else {
        completion(.failure(AccountError.amountToLow))
        return
    }
    
    guard from.balance > amount else {
        completion(.failure(AccountError.insufficientFunds))
        return
    }
    
    var request = URLRequest(url: url)
    let transaction = Transaction(from: from, to: to, amount: amount)
    request.httpBody = try? JSONEncoder().encode(transaction)
    
    URLSession.shared.dataTask(with: request) { (data, _, error) in
        
        guard let data = data, error == nil else {
            completion(.failure(NetworkError.invalidData))
            return
        }
        
        print(data)
        // decoding
        
    }.resume()

}


guard let url = URL(string: "www.mybankservice/api/transfer-funds") else {
    throw NetworkError.badURL
}

let fromAccount = Account(balance: 100)
let toAccount = Account(balance: 50)
let amount = 500.0

transferFunds(url: url, from: fromAccount, to: toAccount, amount: amount) { (result) in
    switch result {
        case .success(let statusCode):
            print(statusCode)
        case .failure(AccountError.amountToLow):
            print("Amount to low")
        case .failure(AccountError.insufficientFunds):
                   print("Insufficient Funds")
        case .failure(NetworkError.invalidData), .failure(NetworkError.decodingError):
                   print("Generic Error message")
        default:
            print("Generic Error Message")
    }
}

//MARK: - Impossible Failure and Result - Use Never to return no error in Result type, if we know our code will always succeed

struct Category {
    let name: String
}

protocol Service {
    associatedtype Value
    associatedtype Err: Error
    func load(completion: (Result<Value, Err>) -> Void)
}

class CategoryService: Service {
    
    func load(completion: (Result<[Category], Never>) -> Void) {
        completion(.success([Category(name: "Fiction"), Category(name: "Horror"), Category(name: "Kids")]))
    }
    
}

CategoryService().load { (result) in
    switch result {
        case .success(let categories):
            print(categories)
    }
}

