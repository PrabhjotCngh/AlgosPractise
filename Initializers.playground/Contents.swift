import UIKit

//MARK: - Initializers - Memberwise and custom initialisation in structs

/// When we need to access default memberwise initilizer we can declare the struct like below
struct Student {
    let firstName: String
    let lastName: String
    let grade: String
    
}

let defaultStudent = Student(firstName: "", lastName: "", grade: "")

/// When we need to customize the initilization  we can declare the struct  in extension like below
extension Student {
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.grade = ""
    }
}

let customStudent = Student(firstName: "", lastName: "")

//MARK: - Convenience Initializers - Instead of passing three or four arguments we can pass one or two arguments in initialiser for our convenience. Convenience Initializer needs to call designated initializer with the required arguments.

class Car {
    var make: String
    var model: String
    var color: String
    
    init(make: String, model: String, color: String) {
        self.make = make
        self.model = model
        self.color = color
    }
    
    // Convenience Initializer
    convenience init(make: String, model: String) {
        self.init(make: make, model: model, color: "White")
    }
}

let car = Car(make: "Honda", model: "Accord")

//MARK: - Subclassing - If we do not want to loose the superclass initializers(designated and convenience) than we have to override the superclass initialiser in subclass, so that we can access both designated and convenience initializers.

class Tesla: Car {
    var range: Double
    
    // override the superclass initialiser instead of creating its own initialiser
    override init(make: String, model: String, color: String) {
        self.range = 300
        super.init(make: make, model: model, color: color)
    }
}

//MARK: - Required Initializers -

/// Final - It is a final defination of a class. Always use final keyword before class in order to protect it from subclassing/inheriting.

/// If we want to remove required  in convenience initializer than we only need to declare our class as final

/// First use of required when using protocols
protocol BusType {
    init(make: String, model: String)
}

class Bus: BusType {
    var make: String
    var model: String
    var color: String
    
    init(make: String, model: String, color: String) {
        self.make = make
        self.model = model
        self.color = color
    }
    
    //We need to make convenience initializer as required because Bus class is conforming to BusType protocol and convenience initializer has same defination as method in protocol.
    required convenience init(make: String, model: String) {
        self.init(make: make, model: model, color: "White")
    }
    
    /// Second use of required when returning same class

    //Self here means it can return car object itself or any car which is subclass of this class
    class func makeCar(make: String, model: String) -> Self {
        // self will give error if we do not make convenience initializer as required because every single subclass should be able to call convenience initializer and should be accessable and is also required by any subclass.
        let car = self.init(make: make, model: model)
        //setup fuel line
        //setup engine
        //setup tires
        return car
    }
}
