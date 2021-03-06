//
//  ContentView.swift
//  CoreDataTodoSample
//
//  Created by CHENGHUNG on 2021/05/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>

    @State private var taskName: String = ""
    
    var body: some View {
        VStack{
            HStack{
                EditButton().frame(width: 100, height: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .background(Color.red)
                Spacer()
                TextField("Task Name", text: $taskName).textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }.frame(width: 100, height: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .background(Color.red)
            }
            List {
                ForEach(items) { item in
                    Text("\(item.name!) at \(item.timestamp!, formatter: itemFormatter)")
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                #if os(iOS)
                EditButton()
                #endif

                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
        
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.isComplete = false
            newItem.name = taskName
            newItem.timestamp = Date()

            do {
                try viewContext.save()
                taskName = ""
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
