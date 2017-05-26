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
    
}
