//
//  CartCollectionViewCell.swift
//  E-commerce App
//
//  Created by MOHIT PAREEK on 15/07/19.
//  Copyright © 2019 MOHIT PAREEK. All rights reserved.
//

import UIKit
import CoreData

protocol updatePriceLabelProtocol {
    func updateLabels()
}

class CartCollectionViewCell: UICollectionViewCell {

    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    lazy var id = retrieveIdOfitems(id : "id")
    
    
    var delegate : updatePriceLabelProtocol?
    
    lazy var currentValue = retrieveNumberOfitems(id: id)
    
    lazy var color = retrieveColorOfItems(id: id)
    
    
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var itemDetailsOutlet: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var countOfItemLabel: UILabel!
    @IBOutlet weak var subtractButton: DesignableButton!
    @IBOutlet weak var addButton: DesignableButton!

    @IBOutlet weak var colorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print(id)
//       colorView.backgroundColor = UIColor(named: color)
        
    }
    
    

    @IBAction func addButtonPressed(_ sender: Any) {
       
        currentValue = retrieveNumberOfitems(id: id)
        currentValue = currentValue + 1.0
        countOfItemLabel.text = String(Int(currentValue))

        updateData(data: currentValue, id: id)
        
        delegate?.updateLabels()
    }
    
    
    @IBAction func subtractButtonPressed(_ sender: Any) {
        currentValue = retrieveNumberOfitems(id: id)
        if currentValue > 1.0 {
            currentValue = currentValue - 1.0
            countOfItemLabel.text = String(Int(currentValue))
            updateData(data: currentValue, id: id)
            delegate?.updateLabels()
        }else{
            deleteData(Id: id)
            delegate?.updateLabels()
        }
        
    }
    
    // function to delete from core data
    
    func deleteData(Id:String)
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Item")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(Id)")
        print("Deleting Data..")
        do
        {
            let fetchedResults =  try context.fetch(fetchRequest) as? [NSManagedObject]
            
            for entity in fetchedResults! {
                
                context.delete(entity)
                do
                {
                    try context.save()
                    
                }
                catch let error as Error?
                {
                    print(error!.localizedDescription)
                }
                
                
            }
        }
        catch _ {
            print("Could not delete")
            
        }
    }
    
    //function to update data in coredata
    
    func updateData(data : Double, id : String){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            results![0].setValue(data, forKey: "number")
           
            print("the value of current products:\(String(describing: results))")
            }
        catch {
            print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
        
    }
    
    // function to retrieve particular attribute data from coredata
    func retrieveNumberOfitems(id: String) -> Double {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
         fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            let valueOfNo = results![0].value(forKey: "number")
            return valueOfNo as! Double

        }
        catch {
            print("Fetch Failed: \(error)")
            return 0
        }

    }
    
    
    // function to retrieve particular id
    
    func retrieveIdOfitems(id: String) -> String {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
//         fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            let results = try context.fetch(fetchRequest) as? [Item]
            print(results!)
            let id1 = results![0].value(forKey: id)
            return id1 as! String
            
        }
        catch {
            print("Fetch Failed: \(error)")
            return ""
        }
        
    }
    
    // method to get price
    func getPrice() -> Double {
        var cartItem = [Item]()
        var total = 0.0
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")
        do{
            cartItem = try context.fetch(fetchRequest) as! [Item]
            if cartItem.isEmpty == false{
                for data in cartItem as [NSManagedObject] {
                    
                    let numberOfParticularItem = data.value(forKey: "number") as! Double
                    let priceOfParticularItem = data.value(forKey: "price") as! Double
                    
                    print(numberOfParticularItem)
                    print(priceOfParticularItem)
                    
                    total=total+(numberOfParticularItem*priceOfParticularItem)
                    
                    print(total)
                }
            }
        }  catch{
                    print("\ncant get the data")
        }
        return total
    }

    
    //Mark : retrieve color of item
    
    func retrieveColorOfItems(id: String) -> String {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
    
        
        do {
            let results = try context.fetch(fetchRequest) as? [Item]
            print(results!)
            let valueOfColor = results![0].value(forKey: "color") as! String
            return valueOfColor 
            
        }
        catch {
            print("Fetch Failed: \(error)")
            return ""
        }
        
    }
    
    
}

