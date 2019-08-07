//
//  BrowseCollectionViewCell.swift
//  E-commerce App
//
//  Created by MOHIT PAREEK on 11/07/19.
//  Copyright © 2019 MOHIT PAREEK. All rights reserved.
//

import UIKit
import CoreData

protocol likeButtonProtocol {
    func addFunc(tag : Int)
    func subFunc(tag : Int)
 }

class BrowseCollectionViewCell: UICollectionViewCell {

    //coreData variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var id = ""
    lazy var number = 1.0
    
    var likes : Int?
    var likeButtonPressed = false
    
    var color = ""
    
    
    
    var delegate : likeButtonProtocol!
    
    
    
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var itemDetailLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if someEntityExists(id: id) {
            addButton.setImage(UIImage(named: "favoriteditemenabled"), for: .normal)
        } else {
            addButton.setImage(UIImage(named: "favoriteditem"), for: .normal)
        }
        
    }
    
    // action when addToCartIsPressed
    @IBAction func addToCartPressed(_ sender: Any) {
        
        if someEntityExists(id: id) {
            return
        }
        else{
            addButton.setImage(UIImage(named: "favoriteditemenabled"), for: .normal)
            openDatabse()
        }
        
    }

    @IBAction func likeButtonPressed(_ sender: UIButton) {
        if numberOfLikesLabel.text == "0 Likes" {
            heartButton.setImage(UIImage(named: "heartitemenabled"), for: .normal)
            numberOfLikesLabel.text = "\(String(describing: likes! + 1)) likes"
            delegate.addFunc(tag: sender.tag)
            
        } else{
            
            heartButton.setImage(UIImage(named: "heartitem"), for: .normal)
            numberOfLikesLabel.text = "\(String(describing: likes!)) likes"
            
            delegate.subFunc(tag: sender.tag)
        }
      
    
        
    }

    
    //function to save data in core data
    
    func openDatabse()
    {
        let entity = NSEntityDescription.entity(forEntityName: "Item", in: context)
        let newItem = NSManagedObject(entity: entity!, insertInto: context)
        saveData(UserDBObj:newItem)
    }
    
    
    func saveData(UserDBObj:NSManagedObject){

        UserDBObj.setValue((itemPriceLabel.text! as NSString).doubleValue, forKey: "price")
        UserDBObj.setValue(itemDetailLabel.text, forKey: "name")
        UserDBObj.setValue(id, forKey: "id")
        UserDBObj.setValue(Double(number), forKey: "number")
        UserDBObj.setValue(color, forKey: "color")
        let data = itemImage.image!.pngData() as NSData?
        UserDBObj.setValue(data, forKey: "image")

        print("Storing Data..")
        do {
            try context.save()
        } catch {
            print("Storing data Failed")
        }

    }
    
     //function to check whether the data exist or not in cart
    
    func someEntityExists(id: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "id == %@" ,id)
        do {
            let count = try context.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    
    // function to retrieve particular id
    
//    func retrieveIdOfitems(id: String) -> String {
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
//        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
//
//        do {
//            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
//            let id = results![0].value(forKey: "id")
//            return id as! String
//
//        }
//        catch {
//            print("Fetch Failed: \(error)")
//            return ""
//        }
//
//    }
    
     // function to retrieve particular attribute data from coredata
    func retrieveNumberOfitems(id: String) -> Double {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            let valueOfNo = results![0].value(forKey: "number") as! Double
            return valueOfNo
            
        }
        catch {
            print("Fetch Failed: \(error)")
            return 0
        }
        
    }
    
    func retrieveLikes(id : String) -> Int {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            let valueOfNo = results![0].value(forKey: "likes") as! Int
            return valueOfNo
            
        }
        catch {
            print("Fetch Failed: \(error)")
            return 0
        
        }
    }
    

}
