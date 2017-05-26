//
//  Person+Convenience.swift
//  Pair
//
//  Created by Bradley GIlmore on 5/26/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation
import CoreData

extension Person {
    
    convenience init(fullName: String, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.fullName = fullName
        
    }
    
}
