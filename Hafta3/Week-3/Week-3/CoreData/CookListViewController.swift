//
//  CookListViewController.swift
//  Week-3
//
//  Created by Kerim Caglar on 4.07.2021.
//

import UIKit
import CoreData

class CookListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var cooks = [CookModel]()
    
    //MARK: Resmi cell de gösteriniz
    //Silme işlemi yapınız. Direk silmeden ziyade kullanıcıya uyarı gösterip silmek istediğinizden emin misiniz uyarısı ile işlemi yapınız.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCooks()
        
    }
    
    private func getCooks() {
        cooks.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cook")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let name = result.value(forKey: "name") as? String,
                          let img = result.value(forKey: "image") as? Data else { return }
                
                    let cook = CookModel(cookName: name, cookImage:  UIImage(data: img)!)
                    cooks.append(cook)
                }
                self.tableView.reloadData()
            } else {
                //TODO:
            }
        } catch {
            print("Error")
        }
        
    }

}



extension CookListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cookCell", for: indexPath)
        
        cell.textLabel?.text = cooks[indexPath.row].cookName
        cell.imageView?.image = cooks[indexPath.row].cookImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Hey!", message: "Silmek istediğine emin misin?", preferredStyle: .alert)
            alert.addAction((UIAlertAction(title: "Evet", style: .default, handler: { (clicked) in
    
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                let context = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cook")
                if let result = try? context.fetch(fetchRequest) {
                    for object in result as! [NSManagedObject]{
                        if self.cooks[indexPath.row].cookName == object.value(forKey: "name") as? String{
                            context.delete(object)
                        }
                    }
                }
                
                do {
                    try context.save()
                    DispatchQueue.main.async {
                        self.getCooks()
                    }
                } catch  {
                    print("Silinemedi...")
                }
            })))
            alert.addAction(UIAlertAction(title: "İptal", style: .cancel))
            present(alert, animated: true)
            
        }
        
    }
    
}
