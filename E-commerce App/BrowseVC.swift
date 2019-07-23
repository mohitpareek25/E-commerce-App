//
//  BrowseVC.swift
//  E-commerce App
//
//  Created by MOHIT PAREEK on 11/07/19.
//  Copyright © 2019 MOHIT PAREEK. All rights reserved.
//

import UIKit
import CoreData

// user defaults constant defined
let defaults = UserDefaults.standard

// structure for taking data into array defined
struct items {
    var name = ""
    var price = 0.0
    var id = ""
    var number = 0.0
    var color = ""
    
    var images = UIImage()
    
}


class BrowseVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, likeButtonProtocol {
   
    
    // outlet for collecction view
    @IBOutlet weak var browseCollectionView: UICollectionView!
    

    //coreData variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    
    
    // array of items which will be displayedon browse screen
    var arrayOfItemsToDisplay : [items] = [items(name: "Samsung S10E 64GB", price: 700.00, id : "101",number: 1, color : "Blue MidNight", images: #imageLiteral(resourceName: "Samsung-Galaxy-S10ee.png")),
                                           items(name: "MacBook Pro 15 inch 256GB", price: 1450.99, id: "102",number: 1, color : "Gray", images: #imageLiteral(resourceName: "macbook pro")),
                                           items(name: "XBox Scarlett 2TB", price: 500.99, id: "103",number: 1, color : "Black", images: #imageLiteral(resourceName: "xbox")),
                                           items(name: "LG foldable O-Led TV", price: 2000.00, id: "104",number: 1, color : "Gray",  images: #imageLiteral(resourceName: "lgTV")),
                                           items(name: "One Plus Pro 256 GB", price: 650.50, id: "105",number: 1, color :  "Blue MidNight", images: #imageLiteral(resourceName: "oneplusPro")),
                                           items(name: "Beats Pill Bluetooth Speaker", price: 250.99, id: "106",number: 1, color : "Black", images: #imageLiteral(resourceName: "beats_pill")),
                                           items(name: "Google Pixel 3", price: 849.99, id: "107",number: 1 , color : "Black", images: #imageLiteral(resourceName: "pixel3")),
                                           items(name: "Fitbit fitness Band", price: 250.00, id: "108",number: 1 , color : "Black", images: #imageLiteral(resourceName: "fitbit")),
                                           items(name: "Nike Air 90 classic", price: 455.78, id: "109",number: 1 , color : "Gray", images: #imageLiteral(resourceName: "shoe")),
                                           items(name: "GTA 5 PS4", price: 99.99, id: "110",number: 1 , color : "PSBlue", images: #imageLiteral(resourceName: "gtav")),
                                           items(name: "Samsung VR", price: 149.98, id: "111",number: 1 , color :"Black", images: #imageLiteral(resourceName: "samsung-gear-vr")),
                                           items(name: "Amazon Echo Home Assistant", price: 250.49,id: "112", number: 1 , color :  "Black", images: #imageLiteral(resourceName: "amazon_echo")),
                                           items(name: "Google Home mini", price: 49.99, id: "113",number: 1, color : "Gray", images: #imageLiteral(resourceName: "google_mini"))]
    
    // array which will store the likes
    var arrayOfLikes = [0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // registering the xib file
        self.browseCollectionView.register(UINib(nibName: "BrowseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        browseCollectionView.reloadData()
        
    }
    
    // the function definition of defined protocol
    func addFunc(tag : Int) {
        arrayOfLikes[tag] = 1
        browseCollectionView.reloadData()
    }
    
    func subFunc(tag : Int) {
        arrayOfLikes[tag] = 0
        browseCollectionView.reloadData()
    }
    
    
    
    // Mark -   Collection View data source and delegate methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfItemsToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BrowseCollectionViewCell
        
        cell.itemDetailLabel.text = arrayOfItemsToDisplay[indexPath.row].name
        cell.itemImage.image = arrayOfItemsToDisplay[indexPath.row].images
        cell.itemPriceLabel.text = String(arrayOfItemsToDisplay[indexPath.row].price)
        cell.id = arrayOfItemsToDisplay[indexPath.row].id
        cell.likes = arrayOfLikes[indexPath.row]
        if someEntityExists(id: arrayOfItemsToDisplay[indexPath.row].id) {
            cell.addButton.setImage(UIImage(named: "favoriteditemenabled"), for: .normal)
        } else {
            cell.addButton.setImage(UIImage(named: "favoriteditem"), for: .normal)
        }
        
        cell.heartButton.tag = indexPath.row
        cell.numberOfLikesLabel.text = String("\(arrayOfLikes[indexPath.row]) Likes")
        cell.delegate = self
        cell.color = arrayOfItemsToDisplay[indexPath.row].color
        if arrayOfLikes[indexPath.row] == 0 {
            cell.heartButton.setImage(UIImage(named: "heartitem"), for: .normal)
            cell.numberOfLikesLabel.text = String("\(arrayOfLikes[indexPath.row]) Likes")
        } else {
            cell.heartButton.setImage(UIImage(named: "heartitemenabled"), for: .normal)
            cell.numberOfLikesLabel.text = String("\(arrayOfLikes[indexPath.row]) Likes")
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width , height: 280)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // sending the data to product details vc
        let storyBoard = UIStoryboard(name: "ProductDetails", bundle: nil)
        let Vc = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        
        Vc.itemImage = arrayOfItemsToDisplay[indexPath.row].images
        Vc.itemName = arrayOfItemsToDisplay[indexPath.row].name
        Vc.price = arrayOfItemsToDisplay[indexPath.row].price
        Vc.id = arrayOfItemsToDisplay[indexPath.row].id
        Vc.number = arrayOfItemsToDisplay[indexPath.row].number
        Vc.likes  = arrayOfLikes[indexPath.row]
        Vc.color = arrayOfItemsToDisplay[indexPath.row].color
        navigationController?.pushViewController(Vc, animated: true)
        
        
    }
    
    
    // to check whether some thing exist or not
    
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
    
    
    

}
