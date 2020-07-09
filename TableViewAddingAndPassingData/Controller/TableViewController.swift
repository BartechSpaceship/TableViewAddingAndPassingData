//
//  TableViewController.swift
//  TableViewAddingAndPassingData
//
//  Created by Bartek on 6/26/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

//I might have to do notifications and observers here as well as the add button has to have a different observer then the save button! 

import Foundation
import UIKit
import CoreData

protocol PushTheAmountOfCellsProtocol {
    func getAmountOfCells(amountOfCells: Int)
}

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellDelegate: PushTheAmountOfCellsProtocol?
    
    var tables = [TableItem]()
   // var coreTables = [TableItem]()
    var newTitle = ""
    var image: UIImage? = nil
    let fetchRequest: NSFetchRequest<TableItem> = TableItem.fetchRequest()
    
     
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if image != nil {
            
            //Instead of having createNewItem() I can do editCurrentItem()
        createNewItem()
        }
        
     
    }

    
    
    func createNewItem() {
        let coreTable = TableItem(context: PersistanceService.context)
        let convertedImage = image?.pngData()
        coreTable.imageName = newTitle
        coreTable.tableImage = convertedImage
        tables.append(coreTable)
        tableView.reloadData()
        
    }
    func saveItems() {
        do {
            try PersistanceService.context.save()
        } catch {
            print(error)
        }
    }
    func loadItems() {
        do{
        let tables = try PersistanceService.context.fetch(fetchRequest)
                      self.tables = tables
                      self.tableView.reloadData()
                  } catch {
                      print("error")
                  }
    }
    func editItems() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadItems()
          
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
       
    
    }
    @IBAction func cancelNavButton(_ sender: UIBarButtonItem) {
        
        
        self.navigationController?.popViewController(animated: true)
        
         
    }
    @IBAction func editNavButton(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func addNavButton(_ sender: UIBarButtonItem) {
        let tableVC = storyboard?.instantiateViewController(withIdentifier: "CreationController") as! CreationController
        tableVC.delegate = self
        
        self.navigationController?.pushViewController(tableVC, animated: true)
       
        
        
    }
    @IBAction func saveNavButton(_ sender: UIBarButtonItem) {
        

       
        saveItems()
        
        cellDelegate?.getAmountOfCells(amountOfCells: tables.count)
        self.navigationController?.popToRootViewController(animated: true)

        //here I will want to save core data to the app 
        
    }
    
 
        
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        cell.tableImageView.image = UIImage(data: tables[indexPath.row].tableImage!)
        cell.tableLabel.text = tables[indexPath.row].imageName
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    
    
    //Will work on deleting the Cell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
             tableView.beginUpdates()

            PersistanceService.context.delete(tables[indexPath.row])
              tables.remove(at: indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
   

    
}

extension TableViewController: TableProtocol {
    func getTableInformation(picture: UIImage, name: String) {
        newTitle = name
        image = picture
    }
    
    
}
