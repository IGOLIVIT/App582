//
//  CalendarViewModel.swift
//  App582
//
//  Created by IGOR on 29/05/2024.
//

import SwiftUI
import CoreData

final class CalendarViewModel: ObservableObject {
    
    @Published var days: [String] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    @Published var currentDay = ""
    
    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isReset: Bool = false
    @Published var isDetail: Bool = false
    @Published var isMore: Bool = false

    @Published var trName = ""
    @Published var trDay = ""
    @Published var trStTime = ""
    @Published var trETime = ""
    @Published var trMembers = ""
    
    @Published var trainings: [TrainingModel] = []
    @Published var selectedTraining: TrainingModel?
    
    func addTraining() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "TrainingModel", into: context) as! TrainingModel
        
        loan.trName = trName
        loan.trDay = trDay
        loan.trStTime = trStTime
        loan.trETime = trETime
        loan.trMembers = trMembers
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchTrainings() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TrainingModel>(entityName: "TrainingModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.trainings = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.trainings = []
        }
    }
}

