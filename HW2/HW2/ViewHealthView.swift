//
//  ViewHealthView.swift
//  HW2
//
//  Created by 贺力 on 4/11/23.
//

import SwiftUI
import CoreData

struct ViewHealthView: View {
    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Data.date, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Data>
    
    
    @State var fromDate: Date = Date()
    @State var endDate: Date = Date()
    
    @FetchRequest(entity: Data.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Data.date, ascending: true)])
        private var healthData: FetchedResults<Data>
        
        private var filteredData: [Data]
        {
            let filteredData = healthData.filter { data in
                guard let date = data.date else { return false }
                return date >= fromDate && date <= endDate
            }
            return filteredData
        }

    var body: some View {
        
        VStack
        {

                DatePicker("Begin Date", selection: $fromDate, displayedComponents: [.date])
                DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
                Button(action: filterByDateRange)
                {
                    Text("Get information")
                }
                Text("Date   Sys   Dia   Sug   Wei")
            
                List(filteredData, id: \.self) { data in
                    HStack
                    {
                        Text("\(data.date ?? Date(), formatter: itemFormatter)")
                        Text("\(String(format: "%.2f", data.systolic))")
                        Text("\(String(format: "%.2f", data.diastolic))")
                        Text("\(String(format: "%.2f", data.sugar))")
                        Text("\(String(format: "%.2f", data.weight))")
                    }
                }
            
        }
    }
    private func filterByDateRange()
    {
        let fetchRequest: NSFetchRequest<Data> = Data.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Data.date, ascending: true)]
            fetchRequest.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", fromDate as NSDate, endDate as NSDate)
            do {
                let filteredData = try viewContext.fetch(fetchRequest)
                // do something with the filtered data
            } catch {
                print("Error fetching data: \(error.localizedDescription)")
            }

    }
    private let itemFormatter: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        //formatter.timeStyle = .medium
        return formatter
    }()
}


struct ViewHealthView_Previews: PreviewProvider {
    static var previews: some View {
        ViewHealthView()
    }
}
