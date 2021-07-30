import UIKit
import CoreData

class DatabaseManager {
    static let shared = DatabaseManager()
    private init () {}
    
    func deleteData(slug: String, completion: (Bool) -> Void){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameTable")
        fetchRequest.predicate = NSPredicate(format: "slug = %@", slug)
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                if let _ = result.value(forKey: "slug") as? String{
                    context.delete(result)
                    do{
                        try context.save()
                        completion(true)
                    }catch{
                        completion(false)
                    }
                    break
                }
            }
        }catch{
            completion(false)
        }
    }
    
    func searchData(slug: String, completion: (Bool) -> Void){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameTable")
        
        fetchRequest.predicate = NSPredicate(format: "slug = %@", slug)
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                completion(true)
            }else {
                completion(false)
            }
        }catch{
            completion(false)
        }
    }
    
    func insertData(game: GameDetail, completion: (Bool) -> Void){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newFavaroite = NSEntityDescription.insertNewObject(forEntityName: "GameTable", into: context)
        
        
        newFavaroite.setValue(game.img, forKey: "img")
        newFavaroite.setValue(game.name, forKey: "name")
        newFavaroite.setValue(game.rating, forKey: "rating")
        newFavaroite.setValue(game.released, forKey: "released")
        newFavaroite.setValue(game.slug, forKey: "slug")
        do{
            try context.save()
            completion(true)
        }catch{
            completion(false)
        }
    }
    
    func getData(completion: @escaping ([Game]?) -> Void){
        var list: [Game]? = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameTable")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                guard let nameText = result.value(forKey: "name") as? String,
                      let image = result.value(forKey: "img") as? String,
                      let rat = result.value(forKey: "rating") as? Double,
                      let released = result.value(forKey: "released") as? String,
                      let slug = result.value(forKey: "slug") as? String else { return }
            
                let newGame = Game(image: image, name: nameText, rating: rat, released: released, slug: slug)
                list?.append(newGame)
            }
            completion(list)
        }catch{
            completion(nil)
        }
    }
}
