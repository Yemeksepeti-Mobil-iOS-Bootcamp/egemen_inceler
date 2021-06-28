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
