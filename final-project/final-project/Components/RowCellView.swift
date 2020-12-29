//
//  RowCellView.swift
//  final-project
//
//  Created by Ivan Martinez Morales on 11/28/20.
//

import SwiftUI

struct RowCellView: View {
    @Environment(\.managedObjectContext) var managedItemContext
    @FetchRequest(fetchRequest: Task.getAllTasks()) var tasks
    
    var task: Task

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: task.completed ? "checkmark.circle" :"circle")
                .onTapGesture(perform: {
                    // remove the piece of code
                    let deletedTask = self.tasks.first(where: { (item) -> Bool in
                        return item.id == self.task.id
                    })
                    
                        self.managedItemContext.delete(deletedTask!)
                    do {
                        try self.managedItemContext.save()
                    } catch {
                        print("Error, an error has occured!!!!!!!!")
                    }

                })

                CoreDataImage()
                .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
            if self.task.completed {
                Text(self.task.title!)
                    .strikethrough()
            } else {
                Text(self.task.title!)
            }

            Spacer()
            // MARK: Due date
            Text("Due \(formatDate())")
        }
        .padding()
        .animation(.spring())
    }
    
    func formatDate() -> String {
       let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.setLocalizedDateFormatFromTemplate("MMM-dd")
        let datetime = formatter.string(from: self.task.due!)
        return datetime
    }
    
    func CoreDataImage() -> Image {
        guard let imageData = self.task.image else { return Image(uiImage: UIImage()) }
        var image = Image(uiImage: UIImage())
        if imageData != nil {
            
            return Image(uiImage: UIImage(data: imageData) ?? UIImage())
        }

        
        return Image(uiImage: UIImage())
    }
    
}
