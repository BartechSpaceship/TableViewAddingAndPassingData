//
//  ViewController.swift
//  TableViewAddingAndPassingData
//
//  Created by Bartek on 6/26/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var label: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func button(_ sender: UIButton) {
        let tableVC = storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        
   
        tableVC.cellDelegate = self
         
//
        self.navigationController?.pushViewController(tableVC, animated: true)
        
        
        
        
    }
    
}

extension ViewController: PushTheAmountOfCellsProtocol {
    func getAmountOfCells(amountOfCells: Int) {
        label.text = "there are \(String(amountOfCells)) Cells"
    }
    
    
}
