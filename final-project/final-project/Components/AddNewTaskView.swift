//
//  AddNewTaskView.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/28/20.
//

import SwiftUI
import UIKit

struct AddNewTaskView: View {
    @Binding var isPresented: Bool
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var title: String = ""
    @State private var dueDate: Date = Date()
    @State var image = UIImage()
    @State var displayingPhotoLibrary: Bool = false
    @State var displayingActionSheet: Bool = false
    @State var displayingCamera: Bool = false
    @State var presentSheet: Bool = false
    @State var taskPriority: Priority = .medium
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 100)
                    .padding(.top, 20)
                
                Text("Add a new task")
                    .font(.title)
                    .fontWeight(.semibold)
                Form {
                    Section(header: Text("Task name (required)")) {
                        TextField("Give this task a name!", text: $title)
                    }
                    Section(header: Text("Due date (required)")) {
                        
                        DatePicker(selection: $dueDate, displayedComponents: .date) {
                            Text("Choose a due date")
                        }
                    }
                    Section(header: Text("Task priority (required)")) {
                        Picker(selection: $taskPriority, label: Text("Choose a task priority")) {
                            
                            ForEach(Priority.allCases) { value in
                                Text(value.name).tag(value)
                            }
                        }
                        
                    }
                    Section(header: Text("Photo of task (optional)")) {
                        Text("Upload from Photos, or use camera")
                        HStack {
                            Image(uiImage: self.image)
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: 40, minHeight: 0, maxHeight: 40)
                                .edgesIgnoringSafeArea(.all)
                            Button(action: {
                                self.displayingActionSheet = true
                            }) {
                                HStack {
                                    Image(systemName: "photo")
                                        .font(.system(size: 20))
                                    
                                    Text("Upload Photo")
                                        .font(.headline)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                            }
                        }
                        .actionSheet(isPresented: $displayingActionSheet, content: {
                            ActionSheet(title: Text("Upload a photo"), message: Text("Load from"), buttons: [
                                .default(Text("From photo library")) {
                                    self.presentSheet.toggle()
                                    self.displayingPhotoLibrary.toggle()
                                },
                                .default(Text("From Camera")) {
                                    self.presentSheet.toggle()
                                    self.displayingCamera.toggle()
                                },
                                .cancel(),
                            ])
                        })
                        
                        .sheet(isPresented: $presentSheet, content: {
                            if displayingPhotoLibrary {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                                    .onDisappear(perform: {
                                        self.displayingActionSheet = false
                                        self.displayingCamera = false
                                        self.displayingPhotoLibrary = false

                                    })
                            } else if displayingCamera {
                                ImagePicker(sourceType: .camera, selectedImage: self.$image)
                                    .onDisappear(perform: {
                                        self.displayingActionSheet = false
                                        self.displayingCamera = false
                                        self.displayingPhotoLibrary = false

                                    })
                            }
                        })
                    }
                }
                
                // MARK: SUBMIT BUTTON
                Button(action: {
                    print("The submit button was activated!")
                    print(self.title)
                    let newItem = Task(context: self.managedObjectContext)
                    newItem.id = UUID()
                    newItem.title = self.title
                    newItem.completed = false
                    newItem.created = Date()
                    newItem.due = self.dueDate
                    newItem.image = self.image.pngData()
                    newItem.priority = self.taskPriority.rawValue
                    
                    // Now try and save it
                    
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print("An error occured!")
                    }
                    
                    print("Saved successfully")
                   
                    self.title = ""
                    self.dueDate = Date()
                    self.isPresented.toggle()
                    self.displayingActionSheet = false
                    self.displayingCamera = false
                    self.displayingPhotoLibrary = false
                }) {
                    HStack(alignment: .center) {
                        Image(systemName: "checkmark")
                            .padding(.horizontal)
                        Text("Submit")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color(UIColor.systemGreen))
                    .cornerRadius(40)
                }
            }
            Text("hello world")
        }
    }
}

