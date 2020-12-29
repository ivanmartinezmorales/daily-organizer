//
//  Task.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/28/20.
//

import Foundation
import CoreData

public class Task: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var due: Date?
    @NSManaged public var created: Date?
    @NSManaged public var image: Data?
    @NSManaged public var completed: Bool
    @NSManaged public var priority: Int
}

extension Task {
    static func getAllTasks() -> NSFetchRequest<Task> {
        print("Getting all tasks")
        let request: NSFetchRequest<Task> = Task.fetchRequest() as! NSFetchRequest<Task>
        
        let sortDescriptor = NSSortDescriptor(key: "due", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}

public enum Priority: Int, Codable, CaseIterable, Identifiable {
    public var id: Priority { self }
    
    case high
    case medium
    case low
    
    var name: String {
            return "\(self)".map {
                $0.isUppercase ? " \($0)" : "\($0)" }.joined().capitalized
        }
    
}
