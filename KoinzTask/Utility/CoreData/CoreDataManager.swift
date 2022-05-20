//
//  CoreDataManager.swift
//  KoinzTask
//
//  Created by Rowaad on 20/05/2022.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataManagerOperation {
    func save(page: Int, _ url: String) 
    func fetchImages(page: Int, completion: @escaping ([String]) -> Void)
}

class CoreDataManager: CoreDataManagerOperation {

    private  var coreDataPhotos: [PhotoEntity] = []
    
    static var shared = CoreDataManager()

    init() { }

    func save(page: Int, _ url: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PhotoEntity", in: managedContext)
        let newPhoto = NSManagedObject(entity: entity!, insertInto: managedContext)
        newPhoto.setValue(url, forKeyPath: "url")
        newPhoto.setValue(page, forKeyPath: "page")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchImages(page: Int, completion: @escaping ([String]) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PhotoEntity")
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            guard let data = result as? [NSManagedObject] else {
                return
            }
            let currentPagePhotos = data.compactMap { (t) -> String? in
                if (t.value(forKey: "page") as! Int) == page {
                    return (t.value(forKey: "url") as! String)
                }
                return nil
            }
            completion(currentPagePhotos)
        } catch {
            print("Failed")
            completion([])
        }
    }
}
