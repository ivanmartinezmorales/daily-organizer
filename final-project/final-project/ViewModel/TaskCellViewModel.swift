//
//  TaskCellViewModel.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/29/20.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable {
    @Published var task: TaskPayload
    @Published var completedIcon: String = ""
    
    var id: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    static func newTask() -> TaskCellViewModel {
        TaskCellViewModel(task: TaskPayload(title: ""))
    }
    
    init(task: TaskPayload) {
        self.task = task
        
        $task.map { $0.completed ? "checkmark.circle.fill" : "circle" }
            .assign(to: \.completedIcon, on: self)
            .store(in: &cancellables)
        
        $task.compactMap { $0.id?.uuidString }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
    }
}
