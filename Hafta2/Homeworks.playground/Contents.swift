import UIKit

// Soru 6
func difference() -> Int{
    var squareOfSum = 0
    var sumOfSquares = 0
    
    /**
     (1+2+3+....+100)^2  ve (1^2 + 2^2 + ...... + 100^2)
     ikinci kısmı direkt for içerisinde,
     birinci kısmı ise toplamlarını bulup return ederken hesaplıyorum.
     */
    for number in 1...100{
        squareOfSum += number
        sumOfSquares += number*number
    }
    
    return squareOfSum*squareOfSum - sumOfSquares
}

print(difference())


// Soru 7
func primeNumber() -> Int{
    var count = 2 // 2 ve 3'ü saydığım için 2'den başlattım.
    var number = 3 // ikişer artırabilmek için.
    while count <= 10_001{
        if isPrime(number){
            count += 1
        }
        number+=2
    }
    return number
}

func isPrime(_ n: Int) -> Bool {
    // Asal sayı mı kontrolü.
    if n <= 1 {
        return false
    }
    if n <= 3 {
        return true
    }
    var i = 2
    while i <= Int(sqrt(Double(n))) {
        if n % i == 0 {
            return false
        }
        i = i + 1
    }
    return true
    
}
print(primeNumber())

// Girilen sayi asal mi?
extension Int {
    func isPrime() -> Bool{
        if self <= 1 {
                return false
            }
            if self <= 3 {
                return true
            }
            var i = 2
            while i <= Int(sqrt(Double(self))) {
                if self % i == 0 {
                    return false
                }
                i = i + 1
            }
            return true
    }
}

18.isPrime()


// İki farklı parametreli Generic Func
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    switch someT {
    case is Class2:
        someU.func1()
    case is Class3:
        someU.func2()
    default:
        break
    }
}

class SomeClass{}

protocol SomeProtocol{}
extension SomeProtocol{
    func func1(){}
    func func2(){}
}

class Class2: SomeClass{}
class Class3: SomeClass{}
class Class4: SomeProtocol{}

someFunction(someT: Class2(), someU: Class4())

/*
If let, guard let tercihi
 Ben genel olarak guard let'i tercih ediyorum. Eğer nil ise veya başka bir kontrolü yaparken bir hata ile karşılaşılırsa
direkt olarak çıkış yapıyoruz. Herhangi bir sorun yok ise direkt alt satırdan devam ediyoruz.
Kod okuması olarak da bence daha düzgün duruyor.
guard let self = self else { return }
self.
 diyerek koda devam edebiliyoruz.
 
 ----------------------------------------------------------------------------------------------------------------------
 
 Static keyword
 Genel olarak bir değişkeni veya fonksiyonu uygulamanın her yerinde kullanacaksak static yaparız.
    static let reuseID = "HomeCell"
 Singleton pattern izleyeceksek kullanabiliriz.
    static let shared = NetworkManager()

 
 //Segment control -> segmentedControl.selectedSegmentIndex = -1 ?????
 */
