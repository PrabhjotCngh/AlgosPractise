import UIKit

//MARK: - Types of errors - Syntax errors, Runtime errors and Logical errors

//MARK: - Throwing error with enum

enum BankAccountError: Error {
    case insufficientFunds
    case accountClosed
}

class BankAccount {
    
    var balance: Double
    
    init(balance: Double) {
        self.balance = balance
    }
    
    func withdraw(amount: Double) throws {
        if balance < amount {
            throw BankAccountError.insufficientFunds
        }
        
        balance -= amount
    }
    
}

let account = BankAccount(balance: 100)

do {
    try account.withdraw(amount: 300)
} catch {
    print(error)
}

//MARK: - Throwing error in network request

struct Post: Decodable {
    let title: String
    let body: String
}

enum NetworkError: Error {
    case badURL
    case decodingError
    case badRequest
    case noData
    case custom(Error)
}

func getPosts(completion: @escaping (Result<[Post], NetworkError>) -> Void) {
    
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
        completion(.failure(.badURL))
        return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
    
        if let error = error {
            completion(.failure(.custom(error)))
        } else if (response as? HTTPURLResponse)?.statusCode != 200 {
            completion(.failure(.badRequest))
        } else {
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            let posts =  try? JSONDecoder().decode([Post].self, from: data)
            if let posts = posts {
                completion(.success(posts))
            } else {
                completion(.failure(.decodingError))
            }
        }
        
    }.resume()
    
}

getPosts { (result) in
    switch result {
        case .success(let posts):
            print(posts)
        case .failure(let error):
            print(error)
    }
}

//MARK: - Error Propagation

struct Pizza {
    let dough: String
    let toppings: [String]
}

enum PizzaBuilderError: Error {
    case doughBurnt
    case noToppings(String)
}

struct PizzaBuilder {
    
    func prepare() -> Pizza? {
        
        do {
            let dough = try prepareDough()
            let toppings = try prepareToppings()
            // return pizza
            return Pizza(dough: dough, toppings: toppings)
        } catch {
            print("Unable to prepare pizza")
            return nil
        }
    }
    
    private func prepareDough() throws -> String {
        // prepare the dough
        
        throw PizzaBuilderError.doughBurnt
    }
    
    private func prepareToppings() throws -> [String] {
          
          // prepare the toppings
          
        throw PizzaBuilderError.noToppings("Chicken and onions are missing!")
      }
}

//MARK: - Validity Type /


enum ValidationError: Error {
    case noEmptyValueAllowed
    case invalidEmail
}

func validateEmail(_ email: String) throws {
    
    guard !email.isEmpty else {
        throw ValidationError.noEmptyValueAllowed
    }
    
    let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
    let isValid = emailPredicate.evaluate(with: email)
    if !isValid {
        throw ValidationError.invalidEmail
    }
    
}

do {
    try validateEmail("")
    print("Email is valid")
} catch {
    print(error)
}

// Inorder to validate email again in future we need to call validateEmail method instead we can validate the email once and use anywhere in the code like below
struct Email {
    let text: String
    
    init(_ text: String) throws {
        
        guard !text.isEmpty else {
            throw ValidationError.noEmptyValueAllowed
        }
        
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        
        let isValid = emailPredicate.evaluate(with: text)
        if isValid {
            self.text = text
        } else {
            throw ValidationError.invalidEmail
        }
    }
}

do {
    let email = try Email("johndoe@gmail.com")
    //Email is validated and ready to be used or passed in code
    print(email)
} catch {
    print(error)
}

//MARK: - Try optional and force try

let email = try? Email("johndoe@gmail.com")
print(email ?? "")

let emailNew = try! Email("johndoe@gmail.com")
print(emailNew)
