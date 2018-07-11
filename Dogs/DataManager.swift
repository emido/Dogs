//
//  DataManager.swift
//  Dogs
//
//  Created by steve on 2018-07-11.
//  Copyright © 2018 steve. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {
  
  var context: NSManagedObjectContext!
  
  override init() {}
  
  convenience init(context: NSManagedObjectContext) {
    self.init()
    self.context = context
  }
  
  struct Key {
    static let dog = "Dog"
  }
  
  internal func dogCount()-> Int {
    let request = NSFetchRequest<Dog>(entityName: Key.dog)
    let result = try! context.count(for: request)
    return result
  }
  
  private func fetchWithSort()-> [Dog] {
    
    let fetchRequest = NSFetchRequest<Dog>(entityName: Key.dog)
    let sortDescriptor = NSSortDescriptor(key: "age", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    let dogs = try! context.fetch(fetchRequest)
//    for dog in dogs {
//      print(#line, dog.name!, dog.color!, dog.age)
//    }
    return dogs
  }
  
  internal func dog(at indexPath: IndexPath)-> Dog {
    let dogs = fetchWithSort()
    return dogs[indexPath.row]
  }
  
  // called from AddViewController
  internal func createDog(with name: String, age: Int16, color: String) {
    let dog = Dog(context: context)
    dog.age = age
    dog.name = name
    dog.color = color
    saveContext()
  }
  
  // MARK - Old Methods
  
  private func createDogs() {
    let dog1 = Dog(context: context)
    dog1.age = 1
    dog1.name = "Spot"
    dog1.color = "White"
    guard let image1 = UIImage(named: "dog1.jpeg") else { return }
    dog1.image = UIImageJPEGRepresentation(image1, 1.0)
    
    let dog2 = Dog(context: context)
    dog2.age = 5
    dog2.name = "Walter"
    dog2.color = "Black"
    guard let image2 = UIImage(named: "dog2.jpeg") else { return }
    dog2.image = UIImageJPEGRepresentation(image2, 1.0)
    
    let dog3 = Dog(context: context)
    dog3.age = 10
    dog3.name = "Zeke"
    dog3.color = "Spotted"
    
    saveContext()
    
  }
  
  
  
  private func simpleFetch() {
    
    let fetchRequest = NSFetchRequest<Dog>(entityName: Key.dog)
    let dogs = try! context.fetch(fetchRequest)
    for dog in dogs {
      print(#line, dog.name!, dog.color!, dog.age)
    }
    
  }
  
  
  
  private func fetchWithPredicate()-> Dog? {
    
    let fetchRequest = NSFetchRequest<Dog>(entityName: Key.dog)
    let predicate = NSPredicate(format: "age > 5")
    fetchRequest.predicate = predicate
    let dogs = try! context.fetch(fetchRequest)
    print(#line, dogs.count)
    guard let firstDog = dogs.first else { return nil}
    print(#line, firstDog.name!, firstDog.color!, firstDog.age)
    return firstDog
  }
  
  private func update(dog: Dog) {
    dog.age += 1
    saveContext()
  }
  
  private func delete(dog: Dog) {
    context.delete(dog)
    saveContext()
  }
  
  private func saveContext () {
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
