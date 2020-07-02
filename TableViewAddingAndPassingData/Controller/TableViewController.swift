//
//  TableViewController.swift
//  TableViewAddingAndPassingData
//
//  Created by Bartek on 6/26/20.
//  Copyright © 2020 Bartek. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tables = [TableItem]()
   // var coreTables = [TableItem]()
    var newTitle = ""
    var image: UIImage? = nil
    
    
   

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
     
        insertNewVideoTitle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<TableItem> = TableItem.fetchRequest()
               do{
                   let tables = try PersistanceService.context.fetch(fetchRequest)
                   self.tables = tables
                   self.tableView.reloadData()
               } catch {
                   print("error")
               }
        
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
        

       
        
        self.navigationController?.popToRootViewController(animated: true)

        //here I will want to save core data to the app 
        
    }
    
    func insertNewVideoTitle(){
        
        //append the new protocol ? vs new
        if image != nil {
            let coreTable = TableItem(context: PersistanceService.context)
                     let convertedImage = image?.pngData()
                      coreTable.imageName = newTitle
                      coreTable.tableImage = convertedImage
            PersistanceService.saveContext()
            
            

                    
                    tables.append(coreTable)
                    tableView.reloadData()
      

            
            tableView.reloadData()
    
        }
        
        
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
       // let table = tables[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
      //  let convertedCell = cell.tableImageView.image?.pngData()
        

     
        cell.tableImageView.image = UIImage(data: tables[indexPath.row].tableImage!)
        cell.tableLabel.text = tables[indexPath.row].imageName

//
//        cell.tableImageView.image = tables[indexPath.row].image
//        cell.tableLabel.text = tables[indexPath.row].label
        
        

        
//        func setTable(table: Table) {
//             tableImageView.image = table.image
//             tableLabel.text = table.label
//         }
//
        
  //    cell.setTable(table: table)
        
        return cell
        
    }
    //Will work on deleting the Cell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
           // tables.remove(at: indexPath.row)
            tables.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            
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
