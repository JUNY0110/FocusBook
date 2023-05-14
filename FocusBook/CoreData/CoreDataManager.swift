//
//  CoreDataManager.swift
//  FocusBook
//
//  Created by 지준용 on 2023/04/26.
//

import CoreData
import Foundation
import UIKit
import SwiftUI

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FocusBook")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveImage(image: UIImage) {
        let context = persistentContainer.viewContext
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Page", in: context) else { return }
        
        let imageObject = NSManagedObject(entity: entityDescription, insertInto: context)
        
        if let imageData = image.pngData() {
            imageObject.setValue(imageData, forKey: "image")
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving Image: \(error.localizedDescription)")
        }
    }
    
    func fetchImage() -> [UIImage] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Page")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            var images: [UIImage] = []
            
            for result in results as! [NSManagedObject]{
                if let imageData = result.value(forKey: "image") as? Data,
                    let image = UIImage(data: imageData) {
                    images.append(image)
                }
            }
            if let plusImage = UIImage(named: ImageLiteral.plus), !images.contains(plusImage) {
                images.append(plusImage)
            }
            
            return images
        } catch {
            print("Error: Failed to fetch images: \(error)")
            return []
        }
    }
    
    func deleteImage(object: NSManagedObject) {
        let context = persistentContainer.viewContext
        context.delete(object)
        do {
            try context.save()
        } catch {
            print("Failed to delete Image: \(error.localizedDescription)")
        }
    }
}
