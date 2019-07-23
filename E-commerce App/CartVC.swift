//
//  CartVC.swift
//  E-commerce App
//
//  Created by MOHIT PAREEK on 15/07/19.
//  Copyright © 2019 MOHIT PAREEK. All rights reserved.
//

import UIKit
import CoreData


// structure to take the data
struct itemsForCart {
    var name = ""
    var price = 0.0
    var id = ""
    var number = 0.0
    
    var images = UIImage()
    
}

class CartVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, updatePriceLabelProtocol {


    // variable dec;aration
    let defaults = UserDefaults.standard
    var itemArray = [Item]()
    var numberOfItems : Double = 0
    var itemPrice : Double = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // outlet declaration
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var subTotalPrice: UILabel!
    @IBOutlet weak var taxesLabel: UILabel!
    @IBOutlet weak var taxesPrice: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.collectionView.register(UINib(nibName: "CartCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        loadData()
        
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        // load the data in core data then reload the collection view and the update the labels
        loadData()
        collectionView.reloadData()
        updateLabels()
        
        let total = getPrice()
        totalPrice.text = "$" + String(format: "%.2f", total)
        subTotalPrice.text = "$" + String(format: "%.2f", total)
        
        collectionView.reloadData()
    }
   
    // protocol function
    func updateLabels() {
        
        print("function called")
        let total = getPrice()
        totalPrice.text = "$" + String(format: "%.2f", total)
        subTotalPrice.text = "$" + String(format: "%.2f", total)
        loadData()
    }
    
    
    //methods for delegate and datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return itemArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CartCollectionViewCell
        cell.itemPrice.text = String((itemArray[indexPath.row].price))
        cell.itemDetailsOutlet.text = itemArray[indexPath.row].name
        if let imageData = itemArray[indexPath.row].image as NSData? {
            if let image = UIImage(data:imageData as Data) {
                cell.imageOutlet.image = image
            }
        }
        cell.id = itemArray[indexPath.row].id!
        cell.countOfItemLabel.text = String(Int(itemArray[indexPath.row].number))
        cell.delegate = self
        cell.subtractButton.tag = indexPath.row
        cell.addButton.tag = indexPath.row
        if cell.currentValue == 1 {
            
            cell.subtractButton.addTarget(self, action: #selector(deleteCell(button:)), for: .touchUpInside)
            
        }
        if cell.currentValue == 0 {
            cell.deleteData(Id: cell.id)
        }
        
        cell.colorView.backgroundColor = UIColor(named: cell.color)
        return cell
    }
    
    // selector function for deleting the cell
    
    @objc func deleteCell(button : UIButton){
        let i : Int = button.tag
        deleteData(Id: "\(i)")
        self.collectionView!.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: UIScreen.main.bounds.height/2.5)
    }
    

    
    
    // function to load data from coredata
    func loadData(){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Item")
        do {
            print("Fetching Data")
            itemArray = try context.fetch(fetchRequest) as! [Item]
        } catch {
            print("Error fetching the data")
        }
        
        
        
    }
    
    
    //function to delete coredata
    
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
    
    // function to get the price
    
    func getPrice() -> Double {
        var total : Double = 0
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        fetchRequest.returnsObjectsAsFaults = false;
        do {
            let results = try context.fetch(fetchRequest) as! [Item]
            
            var numberofItems : Double = 0
            var priceOfAnItem : Double = 0
            for res in results {
                numberofItems = res.value(forKey: "number") as? Double ?? 0
                priceOfAnItem = res.value(forKey: "price") as? Double ?? 0
                 total = total + (numberofItems * priceOfAnItem)
            
            }
            
            print("Sum = \(total)")
        } catch  {
            print("Error! cannot updat price data")
        }
        
        return total
        
    }
    
    
}
