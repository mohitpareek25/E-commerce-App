//
//  ProductDetailsVC.swift
//  E-commerce App
//
//  Created by MOHIT PAREEK on 11/07/19.
//  Copyright © 2019 MOHIT PAREEK. All rights reserved.
//

import UIKit
import CoreData


struct itemsForCollectionView {
    var images = UIImage()
}

class ProductDetailsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    //outlets
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var itemDetailsLabel: UILabel!
    @IBOutlet weak var itemPriceDetails: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    
    @IBOutlet weak var popUpView: DesignableView!
    @IBOutlet weak var imageForPopUp: UIImageView!
    @IBOutlet weak var itemDetailsForPopUp: UILabel!
    @IBOutlet weak var priceDetailsForPopup: UILabel!
    @IBOutlet weak var numberOfItemsInCartButton: DesignableButton!
    @IBOutlet weak var bottomOutlet: NSLayoutConstraint!
    
    //declaring variables
    var itemImage = UIImage()
    var itemName = ""
    var price = 0.0
    var id = ""
    var number = 0.0
    var color = ""
    
    var likes : Int?
    
    var sumOfNumbers = 0.0
    
    //coreData variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var timer = Timer()
    
    
    var arrayOfImages = [itemsForCollectionView(images: UIImage(named: "1")!),
                         itemsForCollectionView(images: UIImage(named: "2")!),
                         itemsForCollectionView(images: UIImage(named: "3")!),
                         itemsForCollectionView(images: UIImage(named: "4")!),
                         itemsForCollectionView(images: UIImage(named: "5")!),
                         itemsForCollectionView(images: UIImage(named: "6")!),
                         itemsForCollectionView(images: UIImage(named: "7")!),
                         itemsForCollectionView(images: UIImage(named: "8")!),
                         itemsForCollectionView(images: UIImage(named: "9")!),
                         itemsForCollectionView(images: UIImage(named: "10")!)]
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //Mark - setting up corner and border of button
        
        addToCartButton.layer.cornerRadius = 5
        addToCartButton.layer.borderWidth = 0.5

        // setting up the image and labels
        itemPriceDetails.text = String(price)
        itemDetailsLabel.text = itemName
        imageOutlet.image = itemImage
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        view.addGestureRecognizer(tap)
        
    }
    
 
    
    
    override func viewWillAppear(_ animated: Bool) {
        print(id)
        print(someEntityExists(id: id))
        if someEntityExists(id: id) {
            addToCartButton.setImage(UIImage(named: "check_icon"), for: .normal)
            addToCartButton.setTitle("Added to cart", for: .normal)
            addToCartButton.backgroundColor = .gray
            addToCartButton.imageEdgeInsets.left = self.view.frame.width - 80
            addButton.setImage(UIImage(named: "favoriteditemenabled"), for: .normal)
            animate()
            
        }else{
            addToCartButton.setImage(nil, for: .normal)
            addToCartButton.setTitle("Add to cart", for: .normal)
            addToCartButton.backgroundColor = .red
            addToCartButton.imageEdgeInsets.left = self.view.frame.width - 80
            addButton.setImage(UIImage(named: "favoriteditem"), for: .normal)
            bottomOutlet.constant = -80
        }
        
        // pop up view customization
        
        imageForPopUp.image = imageOutlet.image
        itemDetailsForPopUp.text = itemDetailsLabel.text
        priceDetailsForPopup.text = itemPriceDetails.text
        sumOfNumbers = sumOfAllNumbers()
        print(sumOfNumbers)
        numberOfItemsInCartButton.setTitle(String(Int(sumOfNumbers)), for: .normal)
        
        
        
        if likes == 0 {
            likeButton.setImage(UIImage(named: "heartitem"), for: .normal)
            numberOfLikesLabel.text = "0 Likes"
        } else{
            likeButton.setImage(UIImage(named: "heartitemenabled"), for: .normal)
            numberOfLikesLabel.text = "1 Like"
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    // add to cart button pressed
    
    @IBAction func addToCartPressed(_ sender: UIButton) {

        if someEntityExists(id: id) {
            return
        } else{
            addToCartButton.setImage(UIImage(named: "check_icon"), for: .normal)
            addToCartButton.setTitle("Added to cart", for: .normal)
            addToCartButton.backgroundColor = .gray
            addToCartButton.imageEdgeInsets.left = self.view.frame.width - 80
            addButton.setImage(UIImage(named: "favoriteditemenabled"), for: .normal)
            openDatabse()
            bottomOutlet.constant = 0
            sumOfNumbers = sumOfAllNumbers()
            numberOfItemsInCartButton.setTitle(String(Int(sumOfNumbers)), for: .normal)
            
            animate()
            
        }
        
    }
    
    // mark : function to make an animation for popup window
    func animate(){
        
        UIView.animate(withDuration: 0.5) {
            self.bottomOutlet.constant = 0
        }
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(showCart), userInfo: nil, repeats: false)
        
    }
    
    @objc func showCart(){
        print("cart")
        UIView.animate(withDuration: 0.5) {
            self.bottomOutlet.constant = -80
        }
        
        
    }
 
    @IBAction func viewCartPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "cart", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "cartVC") as! CartVC
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    
    // Mark - methods for collection view delegate and data source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PeopleWhoLikedCollectionViewCell
        
        cell.imageOutlet.image = arrayOfImages[indexPath.row].images
        cell.layoutIfNeeded()
        cell.imageOutlet.layer.cornerRadius = cell.imageOutlet.frame.height/2
        
        return cell
    }
    
    //function to save data in core data
    
    func openDatabse()
    {
        let entity = NSEntityDescription.entity(forEntityName: "Item", in: context)
        let newItem = NSManagedObject(entity: entity!, insertInto: context)
        saveData(UserDBObj:newItem)
    }

    
    func saveData(UserDBObj:NSManagedObject){
        
            UserDBObj.setValue(price, forKey: "price")
            UserDBObj.setValue(itemDetailsLabel.text, forKey: "name")
            UserDBObj.setValue(id, forKey: "id")
            UserDBObj.setValue(Double(number), forKey: "number")
            UserDBObj.setValue(color, forKey: "color")
            let data = imageOutlet.image!.pngData() as NSData?
            UserDBObj.setValue(data, forKey: "image")
            
            print("Storing Data..")
            do {
                try context.save()
            } catch {
                print("Storing data Failed")
            }
        
    }
    
    //function to fetch data from core data
    
//    func loadData(){
//
//        let fetchrequest : NSFetchRequest<Item> = Item.fetchRequest()
//        do {
//            print("Fetching Data")
//            try context.fetch(fetchrequest)
//        } catch {
//            print("Error fetching the data")
//        }
    
    
    
    func sumOfAllNumbers() -> Double{
        sumOfNumbers = 0.0
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        fetchRequest.returnsObjectsAsFaults = false;
        do {
            let results = try context.fetch(fetchRequest) as! [Item]
            for res in results {
                let totalNumber = res.value(forKey: "number") as! Double
                sumOfNumbers += totalNumber
            }
        } catch  {
            print("Cannot fetch sum of all numbers")
        }

        
        return sumOfNumbers
        
        
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
    
    //function to delete data from coredata
    
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


}

