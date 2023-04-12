//
//  ContentView.swift
//  HW2
//
//  Created by 贺力 on 4/11/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Data.date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Data>
    
    @State var dateE: String = ""
    @State var systolicE: String = ""
    @State var diastolicE: String = ""
    @State var weightE: String = ""
    @State var sugarE: String = ""
    @State var symptomsE: String = ""
    
    var body: some View {
        
        VStack
        {
            Image("cat")
                .resizable()
                .scaledToFit()
            HStack
            {
                Text("Date: ")
                TextField("mm/dd/yy e.g. 4/11/23", text: $dateE)
            }
            HStack
            {
                Text("Pressure: ")
                TextField("Systolic", text: $systolicE)
                TextField("Diastolic", text: $diastolicE)
            }
            HStack
            {
                Text("Weight (lb): ")
                TextField("Weight", text: $weightE)
            }
            HStack
            {
                Text("Sugar Level: ")
                TextField("Sugar level", text: $sugarE)
            }
            HStack
            {
                Text("Any Symptoms: ")
                TextField("Describe any other symptoms here", text: $symptomsE)
            }
            Button(action: {
                addItem(d: dateE, s: systolicE, dia: diastolicE, w: weightE, su: sugarE, sy: symptomsE)
            })
            {
                Text("Submit")
                  
            }
          
        }
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
    }

    private func addItem(d:String, s: String, dia: String, w: String, su:String, sy:String) {
        withAnimation {
            let newItem = Data(context: viewContext)
            //newItem.date = Date()
            let formatDate = itemFormatter.date(from: d)!
            newItem.date = formatDate
            newItem.systolic = Double(s) ?? 0.0
            newItem.diastolic = Double(dia) ?? 0.0
            newItem.weight = Double(w) ?? 0.0
            newItem.sugar = Double(su) ?? 0.0
            newItem.symptoms = sy
            
            
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
    //formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
