//
//  HotVC.swift
//  E-commerce App
//
//  Created by MOHIT PAREEK on 12/07/19.
//  Copyright © 2019 MOHIT PAREEK. All rights reserved.
//

import UIKit
import CoreImage

struct itemsForHotScreen {
    var name = ""
    var price = 0.0
    var id = ""
    var number = 0.0
    var color = ""
    
    var images = UIImage()
    
}

class HotVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    //variable declaration
    let context = CIContext(options: nil)
    let filter = CIFilter(name: "CIGaussianBlur")
    
      var arrayOfItems = [itemsForHotScreen(name: "SAMSUNG S10E", price: 700.0, id: "114", number: 1 , color: "\(String(describing: UIColor(named: "Blue MidNight")))", images: #imageLiteral(resourceName: "samsung s10 for hot")),
                          itemsForHotScreen(name: "ORIGINS PC", price: 2000.0, id: "115", number: 1, color: "\(String(describing: UIColor(named: "Black")))", images: #imageLiteral(resourceName: "origins for hot")),
                          itemsForHotScreen(name: "iPHONE X", price: 1499.00, id: "116", number: 1,color: "\(String(describing: UIColor(named: "Black")))", images: #imageLiteral(resourceName: "iphones for hot")),
                          itemsForHotScreen(name: "APPLE WATCHES", price: 700.0, id: "117", number: 1,color: "\(String(describing: UIColor(named: "Black")))", images: #imageLiteral(resourceName: "apple watches for hot")),
                          itemsForHotScreen(name: "VIDEO GAMES", price: 50.00, id: "118", number: 1,color: "\(String(describing: UIColor(named: "PSBlue")))", images: #imageLiteral(resourceName: "games for hot"))]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.collectionView.register(UINib(nibName: "HotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    

    // Mark- Collection view delegate and data source methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayOfItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HotCollectionViewCell
        
    
        
        DispatchQueue.global(qos: .userInteractive).async {
                let uiimage = self.arrayOfItems[indexPath.row].images
                let beginImage = CIImage(image: uiimage)
                let filter = CIFilter(name: "CIGaussianBlur")
                filter?.setValue(beginImage, forKey: "inputImage")
                filter?.setValue(5, forKey: "inputRadius")
                let outputImage = filter?.outputImage
                let cgimg = self.context.createCGImage(outputImage!,from: outputImage!.extent)
                let newImage = UIImage(cgImage: cgimg!)
                
                DispatchQueue.main.async {
                    cell.blurImage.image = newImage
                }
        }

        cell.itemImage.image = arrayOfItems[indexPath.row].images
        cell.itemName.text = arrayOfItems[indexPath.row].name
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "ProductDetails", bundle: nil)
        let Vc = storyBoard.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        
        Vc.itemImage = arrayOfItems[indexPath.row].images
        Vc.itemName = arrayOfItems[indexPath.row].name
        Vc.price = arrayOfItems[indexPath.row].price
        Vc.id = arrayOfItems[indexPath.row].id
        Vc.number = arrayOfItems[indexPath.row].number
        Vc.color = arrayOfItems[indexPath.row].color
        navigationController?.pushViewController(Vc, animated: true)
        
    }
    
    
    
    //
    

    
    
    

}
