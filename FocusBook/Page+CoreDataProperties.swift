//
//  Page+CoreDataProperties.swift
//  FocusBook
//
//  Created by 지준용 on 2023/04/25.
//
//

import Foundation
import CoreData


extension Page {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Page> {
        return NSFetchRequest<Page>(entityName: "Page")
    }

    @NSManaged public var image: Data?
    @NSManaged public var id: UUID?

}

extension Page : Identifiable {

}
