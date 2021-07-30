//
//  DatabaseManager.swift
//  TheMovieDB
//
//  Created by Egemen Inceler on 12.07.2021.
//

import UIKit
import CoreData

class DatabaseManager{
    static let shared = DatabaseManager()
    
    private init(){}
    
    func insertData(movie: Movie, completion: (Bool) -> Void){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newFavaroite = NSEntityDescription.insertNewObject(forEntityName: "MovieTable", into: context)
        
        print("inserted: \(movie.id)")
        
        
         newFavaroite.setValue(movie.id, forKey: "id")
         do{
             try context.save()
             completion(true)
         }catch{
             completion(false)
         }
        
    }
    
    func searchData(id: Int, completion: (Bool) -> Void){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieTable")
        
        fetchRequest.predicate = NSPredicate(format: "id = %ld", id)
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                completion(true)
            }else {
                completion(false)
            }
        }catch{
            
        }
        
    }
    
    func deleteData(id: Int, completion: (Bool) -> Void){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieTable")
        fetchRequest.predicate = NSPredicate(format: "id = %ld", id)
        fetchRequest.returnsObjectsAsFaults = false
        print("id \(id)")
        do{
            let results = try context.fetch(fetchRequest)
            print(results)
            for result in results as! [NSManagedObject]{
                if let _ = result.value(forKey: "id") as? Int{
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
            print("olmuyor istesemde")
            completion(false)
        }
    }
    
    func getData(completion: @escaping ([Int?]) -> Void){
        var list: [Int?] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieTable")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                guard let id = result.value(forKey: "id") as? Int else { return }
                
                list.append(id)
                completion(list)
            }
        }catch{
            
            completion([])
        }
        
    }
}
