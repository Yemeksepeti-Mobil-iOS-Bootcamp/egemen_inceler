import UIKit

var optional: Int? = 5
optional? = 48
print(optional as Any)
/*
 optional değişkenini nullable olarak atama yaptık ve nil olarak değer atadık.
 Alt satırda ise eğer optional değişkeninde bir atama var ise 48 ataması yap diyoruz.
 IDE optional değişkenine baktığında bir değer göremediği için bir atama yapmıyor ve nil kalıyor.
 Fakat ilk atamada 5 gibi bir Int değer ataması yapsaydık IDE optional değişkenine baktığında bir değer algılayacak ve yeni Optional(48) ataması yapacaktı.
 */

protocol Printable {
    func printToConsole()
}

extension Printable{
    func printToConsole(){
        doExtraWork()
    }
    
    func doExtraWork(){
        print("Calculatable.doExtrawork()")
    }
}

struct MyPrinter: Printable{
    func doExtraWork(){
        print("Yemeksepeti.doExtraWork")
    }
}

let printer = MyPrinter()
printer.printToConsole()
// Protocol func override???

var message = ("Hello", "World"){
    didSet {
        message.0 = "Yemeksepeti"
    }
}
message.0 = "iOS"
message.1 = "Quiz"
print(message)


enum Yemeksepeti: RawRepresentable{
    case one
    case two
    
    init?(rawValue: Int){
        self = .one
    }
    var rawValue: Int {
        return 1
    }
}

let value = Yemeksepeti.two
switch value {
case .one:
    print("1")
case .two:
    print("2")

}
print(value.rawValue)

