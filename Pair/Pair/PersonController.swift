//
//  PersonController.swift
//  Pair
//
//  Created by Bradley GIlmore on 5/26/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    
    static let shared = PersonController()
    
    var people: [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    func create(fullName: String) {
        let _ = Person(fullName: fullName)
        saveToPersistence()
    }
    
    func saveToPersistence() {
        let moc = CoreDataStack.context
        
        do {
            try moc.save()
        } catch {
            print("Error")
        }
    }
    
    func shuffle() {
        var newArray: [Person] = []
        var counter = 0
        
        while counter < people.count { // Changed this from < to <=
            
//            var i = arc4random_uniform(UInt32(people.count)) // This is too random
            let az = people
            newArray.append(az[Int(counter)])
            counter += 1
            
        }
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try CoreDataStack.context.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                CoreDataStack.context.delete(item)
            }
            
            // Save Changes
            try CoreDataStack.context.save()
            
        } catch {
            // This is where my amazing Error Handling would go if I had time to do it :(
            
        }
        
        counter = 0
        while counter < newArray.count {
            guard let full = newArray[counter].fullName else { NSLog("Person was nil"); return }
            create(fullName: full)
        }
        
//        let newnewArray = newArray.flatMap { Person(fullName: $0.fullName!) }
        
        saveToPersistence()
        
    }
    
    
}











