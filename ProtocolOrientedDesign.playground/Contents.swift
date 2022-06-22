import UIKit

//MARK: - Implementing Protocols - Airline Ticket

//How to handle different types conforming to same protocol

extension Date {
    static func fiveHoursFromNow() -> Date {
        return Date().addingTimeInterval(5 * 60 * 60)
    }
}

protocol AirlineTicket {
    var name: String { get }
    var departure: Date? { get set }
    var arrival: Date? { get set }
}

struct Economy: AirlineTicket {
    let name = "ECON"
    var departure: Date?
    var arrival: Date?
}

struct Business: AirlineTicket {
    let name = "BUS"
    var departure: Date?
    var arrival: Date?
}

struct First: AirlineTicket {
    let name = "FIRST"
    var departure: Date?
    var arrival: Date?
}

///CheckoutService class only accepts  a type which conforms to AirlineTicket protocol
class CheckoutService {
    
    var tickets: [AirlineTicket]
    
    init(tickets: [AirlineTicket]) {
        self.tickets = tickets
    }
    
    ///Here we can add any type which is conforming to AirlineTicket protocol
    func addTicket(_ ticket: AirlineTicket) {
        self.tickets.append(ticket)
    }
    
    func processTickets() {
        tickets.forEach {
            print($0)
        }
    }
    
}

///Economy conforms to AirlineTicket protocol
let economyTickets = [Economy(departure: Date(), arrival: Date.fiveHoursFromNow())]

let service = CheckoutService(tickets: economyTickets)

///First conforms to AirlineTicket protocol
service.addTicket(First(departure: Date(), arrival: Date.fiveHoursFromNow()))

service.processTickets()

//MARK: - Associated Types - Actual method implementation of protocol will dectate what the type of a parameter or return type will be rather then mentioning in function at the time of declaring in protocol

protocol Parser {
    
    associatedtype Input
    associatedtype Output

    func parse(input: Input) -> Output
}

class TextFileParser: Parser {
    func parse(input: String) -> String {
        return ""
    }
}

class HTMLParser: Parser {
    func parse(input: String) -> [String] {
        return []
    }
}


class JsonParser: Parser {
    
    typealias Input = String
    typealias Output = [String:String]
    
    func parse(input: Input) -> Output {
        return [:]
    }
}

func runParser<P: Parser>(parser: P, input: [P.Input]) where P.Input == JsonParser {
    input.forEach {
        _ = parser.parse(input: $0)
    }
}

//MARK: - Protocol extensions - We can provide default implementation to methods/properties declared in protocol by extending a protocol. If a class that conforms to a protocol want to give its own implementation then it can do so, as it will override the default implementation.

extension Parser {
    func parse(input: String) -> [String] {
        return ["<html></html>","<p></p>"]
    }
}

class XHTMLParser: Parser {
    func parse(input: Int) -> [Int] {
        return [1,2]
    }
}

let xhtmlParser = XHTMLParser()
xhtmlParser.parse(input: 1)

//MARK: - Multiple Protocol Extension

protocol Account {
    
    var balance: Double { get set }
    
    mutating func deposit(_ amount: Double)
    mutating func withdraw(_ amount: Double)
    func transfer(from: Account, to: Account, amount: Double)
    func calculateInterestEarned() -> Double
}

struct VerificationRequest {
    let accounts: [Account]
}

struct VerificationResponse {
    let verified: Bool
}

protocol Verification {
    func performVerification(_ request: VerificationRequest, completion: (VerificationResponse) -> Void)
}

extension Verification {
    func performVerification(_ request: VerificationRequest, completion: (VerificationResponse) -> Void) {
        // perform the verification
    }
}

extension Account {
    
    mutating func deposit(_ amount: Double) {
        balance += amount
    }
    
    mutating func withdraw(_ amount: Double) {
        balance -= amount
    }
    
    func calculateInterestEarned() -> Double {
           return (balance * (0.1/100))
    }
    
}

//Multiple protocol extension in action
struct CheckingAccount: Account, Verification {
    
    var balance: Double
    
    func calculateInterestEarned() -> Double {
           return (balance * (0.2/100))
    }
    
    func transfer(from: Account, to: Account, amount: Double) {
        performVerification(VerificationRequest(accounts: [from, to])) { response in
            if response.verified {
                // transfer funds
            }
        }
    }
    
}

struct MoneyMarketAccount: Account {
    
    var balance: Double
    
    func calculateInterestEarned() -> Double {
           return (balance * (0.4/100))
    }
    
    func transfer(from: Account, to: Account, amount: Double) {
        
    }
    
}

let checkingAccount = CheckingAccount(balance: 100)

//MARK: - Protocol Inheritance

struct Course {
    let courseNumber: String
    let name: String
    let creditHours: Int
}

protocol Student {
    var courses: [Course] { get set }
    mutating func enroll(_ course: Course)
}

extension Student {
    mutating func enroll(_ course: Course) {
        courses.append(course)
    }
}

protocol VerifiedStudent: Student {
    func verify() -> Bool
}

extension VerifiedStudent {
    
    func enroll(_ course: Course) {
        if verify() {
            print("Enroll in course")
        }
    }
    
    func verify() -> Bool {
        return true
    }
    
}

struct InternationalStudent: VerifiedStudent {
    var courses: [Course] = []
}

let internationalStudent = InternationalStudent()
internationalStudent.enroll(Course(courseNumber: "1234", name: "Math", creditHours: 3))


//MARK: - Protocol Composition

protocol VerifyStudent where Self: Student {
    func verify() -> Bool
}

extension VerifyStudent {
    
    func enroll(_ course: Course) {
        if verify() {
                print("Verified and Enrolled")
            }
    }
    
    func verify() -> Bool {
        return true
    }
    
}

struct InternationalStudentNew: Student, VerifyStudent {
    var courses: [Course] = []
}

let internationalStudentNew = InternationalStudentNew()
internationalStudentNew.enroll(Course(courseNumber: "1234", name: "Math", creditHours: 3))


