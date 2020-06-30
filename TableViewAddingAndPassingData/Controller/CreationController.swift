//
//  CreationController.swift
//  TableViewAddingAndPassingData
//
//  Created by Bartek on 6/27/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import Foundation
import UIKit

//On save tap need a protocol that is true or false, if true add the table

protocol TableProtocol {
    func getTableInformation(picture: UIImage, name: String)
}

class CreationController: UIViewController {
    
    var delegate: TableProtocol?
    var stringName = ""
    var imageExample = UIImage(named: "1")

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!

    let picArray = [
        UIImage(named: "1"),
        UIImage(named: "2"),
        UIImage(named: "3"),
        UIImage(named: "4"),
        UIImage(named: "5")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    @IBAction func saveNavButton(_ sender: UIBarButtonItem) {
        
        delegate?.getTableInformation(picture: imageExample!, name: stringName)
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    
}

extension CreationController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        picArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.imageViewCollectionCell.image = picArray[indexPath.row]
        

        
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        switch indexPath.row {
        case 0:
            nameLabel.text = "Image 1"
            stringName = "Image 1"
            imageExample = UIImage(named: "1")
        case 1:
            nameLabel.text = "Image 2"
            stringName = "Image 2"
            imageExample = UIImage(named: "2")
        case 2:
            nameLabel.text = "Image 3"
            stringName = "Image 3"
            imageExample = UIImage(named: "3")
        case 3:
            nameLabel.text = "Image 4"
            stringName = "Image 4"
            imageExample = UIImage(named: "4")
        case 4:
            nameLabel.text = "Image 5"
            stringName = "Image 5"
            imageExample = UIImage(named: "5")
        default:
            print("error state switch")
        }
        
    }
    
    
}
