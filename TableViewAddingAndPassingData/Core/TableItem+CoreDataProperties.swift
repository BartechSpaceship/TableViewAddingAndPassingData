//
//  TableItem+CoreDataProperties.swift
//  TableViewAddingAndPassingData
//
//  Created by Bartek on 6/30/20.
//  Copyright © 2020 Bartek. All rights reserved.
//
//

import Foundation
import CoreData


extension TableItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TableItem> {
        return NSFetchRequest<TableItem>(entityName: "TableItem")
    }

    @NSManaged public var tableImage: Data?
    @NSManaged public var imageName: String?

}
