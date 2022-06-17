import UIKit

//MARK: - Replacing structs with enums

// Generally we create model like below
/*
 struct Session {
 let title: String
 let speaker: String
 let data: Date
 let isKeynote: Bool
 let isWorkshop: Bool
 let isRecorded: Bool
 let isNormal: Bool
 let isJoinSession: Bool
 var jointSpeakers: [String]?
 }
 
 let session = Session(title: "Introduction to Swift", speaker: "johndoe", data: Date(), isKeynote: false, isWorkshop: false, isRecorded: true, isNormal: true,  isJoinSession: false)
 */

// We can use enum to create models as well
enum Session {
    case keynote(title: String, speaker: String, date: Date, isRecorded: Bool)
    case normal(title: String, speaker: String, date: Date)
    case workshop(title: String, speaker: String, date: Date, isRecorded: Bool)
    case joint(title: String, speakers: [String], date: Date)
}

let keynote = Session.keynote(title: "WWDC 2021", speaker: "Tim Cook", date: Date(), isRecorded: true)

func displaySession(session: Session) {
    switch session {
    case let .keynote(title: title, speaker: speaker, date: date, isRecorded: isRecorded):
        print("\(title) - \(speaker) - \(date) - \(isRecorded)")
    case let .normal(title: title, speaker: speaker, date: date):
        print("\(title) - \(speaker) - \(date)")
    default:
        print("")
    }
    /// To handle only one particular case use below code
    /*
     if case let Session.keynote(title: title, speaker: speaker, date: date, isRecorded: isRecorded) = session {
     // it is a keynote session
     } */
    
}

displaySession(session: keynote)

//**********************************************************************************************************************//

//MARK: - Hiding type using enums (Enum polymorphism)

/// NOTE: Polymorphism means single function, method, array, dictionary can work on different types.

/// Example to show how polymorphism works if we use structures
struct Teacher {
    let name: String
    let courses: [String]
}

struct Student {
    let name: String
    let courses: [String]
    var grade: String?
}

let teacher = Teacher(name: "John Doe", courses: ["Math", "Science"])
let student = Student(name: "Patrick Hoffman", courses: ["Math", "History"])

let users: [Any] = [teacher, student]

// Here we need to check type of each case in switch to perform particular operation which is not a good practise
for user in users {
    switch user {
    case let user as Student:
        print(user.grade ?? "")
    case let user as Teacher:
        print(user.courses)
    default:
        print("Not student or teacher")
    }
}

// Enum polymorphism in action
enum User {
    case teacher(Teacher)
    case student(Student)
}

let allUsers = [User.teacher(teacher), User.student(student)]

// No case type checked below to handle particular case
for user in allUsers {
    switch user {
    case .student(let student):
        print(student.grade ?? "")
    case .teacher(let teacher):
        print(teacher.courses)
    }
}

//**********************************************************************************************************************//

//MARK: - Use of enums instead of subclassing

//In Subclassing if one concrete(child) class do not need to implement any property/method from super(parent) class than it will voilate the inheritance. We need to make sure every inherting class should use each property/method from parent class
/*
 class Ticket {
 
 var departure: String
 var arrival: String
 var price: Double
 
 init(departure: String, arrival: String, price: Double) {
 self.departure = departure
 self.arrival = arrival
 self.price = price
 }
 }
 
 // BuddyPass can not use price because it is free, so there is no use of price property in parent class which is voilating the inheritance
 class BuddyPass: Ticket {
 
 }
 
 class Economy: Ticket {
 
 }
 
 class FirstClass: Ticket {
 
 var meal: Bool
 
 init(departure: String, arrival: String, price: Double, meal: Bool) {
 self.meal = meal
 super.init(departure: departure, arrival: arrival, price: price)
 }
 
 }
 
 class Business: Ticket {
 
 var meal: Bool
 var chargingPorts: Bool
 
 init(departure: String, arrival: String, price: Double, meal: Bool, chargingPorts: Bool) {
 self.meal = meal
 self.chargingPorts = chargingPorts
 super.init(departure: departure, arrival: arrival, price: price)
 }
 
 }
 
 func checkIn(ticket: Ticket) {
 
 switch ticket {
 case let ticket as Economy:
 print(ticket)
 case let ticket as FirstClass:
 print(ticket)
 case let ticket as Business:
 print(ticket)
 default:
 print("Unidentified ticket!")
 }
 
 } */

//Here we will use structs and enum instead of subclassing because in future we can introduce some properties in superclass which can not be shared by subclass so we should use this approach.
//Though a lot of properties is repeating like departure, arrival in each struct but we are also defining individual struct with different responsibilities like Economy do not have meal but FirstClass do have it

struct Economy {
    let departure: String
    let arrival: String
}

struct FirstClass {
    let departure: String
    let arrival: String
    let meal: Bool
}

struct Business {
    let departure: String
    let arrival: String
    let meal: Bool
    let chargingPorts: Bool
}

struct International {
    let departure: String
    let arrival: String
    let meal: Bool
    let chargingPorts: Bool
    let baggageAllowed: Bool
}

enum Ticket {
    case economy(Economy)
    case firstClass(FirstClass)
    case business(Business)
    case international(International)
}

let ticket = Ticket.business(Business(departure: "Houston", arrival: "Denver", meal: true, chargingPorts: true))

func checkIn(ticket: Ticket) {
    switch ticket {
    case .economy(let economy):
        print(economy)
    case .firstClass(let firstClass):
        print(firstClass)
    case .business(let business):
        print(business)
    case .international(let international):
        print(international)
    }
}

checkIn(ticket: ticket)

//**********************************************************************************************************************//


//MARK: - Use of enums instead of subclassing (One more example)

/*
class User {
    var name: String
    var isFullTime: Bool
    
    init(name: String, isFullTime: Bool) {
        self.name = name
        self.isFullTime = isFullTime
    }
    
}
 
//Here we may not isFullTime property from parent class
class Staff: User {
    
}

class Teacher: User {
    var courses: [String]
    
    init(name: String, courses: [String], isFullTime: Bool) {
        self.courses = courses
        super.init(name: name, isFullTime: isFullTime)
    }
}

class Student: User {
    var courses: [String]
    
    init(name: String, courses: [String], isFullTime: Bool) {
        self.courses = courses
        super.init(name: name, isFullTime: isFullTime)
    }
}
 */

struct SchoolStudent {
    let name: String
    let courses: [String]
    let isFullTime: Bool
}

struct SchoolTeacher {
    let name: String
    let courses: [String]
    let isFullTime: Bool
}

struct SchoolStaff {
    let name: String
    let isFullTime: Bool
}

struct SchoolInternational {
    let name: String
    let isFullTime: Bool
    let courses: [String]
    let countryOfOrigin: String
}

enum SchoolUser {
    case student(SchoolStudent)
    case teacher(SchoolTeacher)
    case staff(SchoolStaff)
    case international(SchoolInternational)
}


func updateProfile(user: SchoolUser) {
    switch user {
        case .student(let student):
            print(student)
        case .teacher(let teacher):
            print(teacher)
        case .staff(let staff):
            print(staff)
        case .international(let international):
            print(international)
    }
    
}

updateProfile(user: SchoolUser.student(SchoolStudent(name: "John Doe", courses: ["Math", "Science"], isFullTime: true)))


//MARK: - enum and raw values

/*
enum NetworkError: Error {
    case badURL
    case decodingError
}

enum TemperatureUnit: String {
    case imperial = "F"
    case metric = "C"
}

private func getWeatherURL(unit: TemperatureUnit) -> URL? {
    
    switch unit {
        case .imperial:
            return URL(string: "www.weather.com/?unit=fahrenheit")
        case .metric:
            return URL(string: "wwww.weather.com/?unit=celsius")
    }
    
}

func getWeather(unit: TemperatureUnit) throws {
    
    guard let weatherURL = getWeatherURL(unit: unit) else {
        throw NetworkError.badURL
    }
    
    print(weatherURL)
    
    // code to call the weather API
    
}

do {
    try getWeather(unit: .metric)
} catch {
    print(error)
} */

enum ImageType: String {
    case jpg
    case bmp
    case png
    
    init?(rawValue: String) {
        switch rawValue.lowercased() {
            case "jpg", "jpeg": self = .jpg
            case "bmp", "bitmap": self = .bmp
            case "png": self = .png
            default: return nil
        }
    }
}

func iconName(for fileExtension: String) -> String {
    
    guard let imageType = ImageType(rawValue: fileExtension) else {
        return "assetUnknown"
    }
    
    switch imageType {
        case .jpg: return "assetJPG"
        case .bmp: return "assetBMP"
        case .png: return "assetPNG"
    }
}

iconName(for: "jpg")
iconName(for: "jpeg")

iconName(for: "bmp")
iconName(for: "bitmap")

