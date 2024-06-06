//
//  StudentsViewModel.swift
//  App582
//
//  Created by IGOR on 29/05/2024.
//

import SwiftUI
import CoreData

final class StudentsViewModel: ObservableObject {
    
    @Published var photos: [String] = ["girl1", "girl2", "girl3", "boy"]
    @Published var currentPhoto = ""
    
    @Published var isAdd: Bool = false
    @Published var isAddPayment: Bool = false
    @Published var isDelete: Bool = false
    @Published var isReset: Bool = false
    @Published var isDetail: Bool = false
    @Published var isMore: Bool = false
    
    @Published var currentStudent = ""

    @Published var stPhoto = ""
    @Published var stName = ""
    
    @Published var students: [StudentModel] = []
    @Published var selectedStudent: StudentModel?
    
    func addStudent() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "StudentModel", into: context) as! StudentModel
        
        loan.stName = stName
        loan.stPhoto = stPhoto
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchStudents() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<StudentModel>(entityName: "StudentModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.students = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.students = []
        }
    }
    
    @Published var payMoney = ""
    @Published var payStName = ""
    
    @Published var payments: [PaymentsModel] = []
    @Published var selectedPayment: PaymentsModel?
    
    func addPayment() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "PaymentsModel", into: context) as! PaymentsModel
        
        loan.payMoney = payMoney
        loan.payStName = payStName
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchPayments() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PaymentsModel>(entityName: "PaymentsModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.payments = result.filter{($0.payStName ?? "") == currentStudent}
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.payments = []
        }
    }
}
