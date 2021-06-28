import UIKit

//Soru 1:
func multipleof35() -> Int{
    
    var toplam = 0
    for sayi in 1...999{
        if sayi%3==0 || sayi%5==0{
            toplam += sayi
        }
    }
    return toplam
}

print(multipleof35())

//Soru 2:
func fibo() -> Int {
    
    var a = 0
    var b = 1
    var toplam = 0
    
    while b < 4000000 {
        let temp = a + b
        a = b
        b = temp
        
        if b % 2 == 0 {
            toplam += b
        }
    }
    return toplam
}
print(fibo())

//Soru 3:
func primeFactor(n: Double){
    
    let border = Int(sqrt(n))
    var liste: [Int] = []
    
    for sayi in 2...border{
        if Int(n)%sayi == 0{
            if isPrime(sayi){
                liste.append(sayi)
            }
        }
    }
    print(liste.last)
}


func isPrime(_ n: Int) -> Bool {
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
primeFactor(n: 600851475143)

//Soru 4:
func palindrome() -> Int{
    var num = -1
    for sayi in 9009...999999{
    //let sayi = 9009
        let len = String(sayi).count
    
        var dizi: [Character] = []
        for i in String(sayi){
            dizi.append(i)
        }
    
        for i in 0...(len/2){
            if dizi[i] == dizi[len-i-1]{
                num = (sayi)
            }else{
                break
            }
        }
    }
    return num
    
}
print(palindrome())

//Soru 5:
func smallest(){
    
    let a = 11
    let b = 20
    var num = 2520
    var i = 0
    
    while i < 10{
        i = 0
        num += 1
        for sayi in a...b{
            if num%sayi == 0 {
                i+=1
            }else{
                break
            }
        }
    }
    print(num)
}
smallest()


