//
//  TaskViewViewModel.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/29/20.
//

import Foundation
import CoreData
import SwiftUI


class TaskViewViewModel: ObservableObject {
    @Published var tasks = [TaskPayload]()
    
    init() {
        print("starting application state container")
        let application = UIApplication.shared.delegate as! AppDelegate
        let context = application.persistentContainer.viewContext
        
        let taskRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            let results = try context.fetch(taskRequest)
            for result in results as! [NSManagedObject] {
                print(result)
            }
        } catch {
            print("Could not complete this request")
        }
    }
}
