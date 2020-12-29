//
//  TaskView.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/28/20.
//

import SwiftUI

struct TaskView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Task.getAllTasks()) var taskItems: FetchedResults<Task>
    
    // We need to instantiate our observed object here
    @State var willAddNewTask: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if self.taskItems.count == 0 {
                VStack(alignment: .center) {
                    
                    Text("No tasks!")
                     .font(.title)
                        .bold()
                        .padding()
                    Text("Click the plus button to add a new task!")
                        .font(.title2)
                        .bold()
                        .padding()
                     Spacer()
                    
                        .padding()
                }
            }
                
            List {
                ForEach(self.taskItems, id: \.id){ item in
                        RowCellView(task: item)
                    }
                .onDelete(perform: { indexSet in
                    // Delete this item
                    self.managedObjectContext.delete(self.taskItems[indexSet.first!])
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print("Oh no an error has occured!")
                    }
                })
                
                .listStyle(PlainListStyle())
            }
            // MARK: Adding todos
            .navigationBarItems(trailing: Button(action: {
                self.willAddNewTask.toggle()
                print("opening the add task pane")
            }) {
                HStack {
                    Text("New task")
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                }
                .accentColor(Color(UIColor.systemRed))
                .padding()
            })
            .onAppear {
                print(self.taskItems)
            }
            // MARK: Sheet
            .sheet(isPresented: $willAddNewTask, content: {
                AddNewTaskView(isPresented: $willAddNewTask)
            })
        }
    }
}
