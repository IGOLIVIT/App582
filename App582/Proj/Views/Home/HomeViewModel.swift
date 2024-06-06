//
//  HomeViewModel.swift
//  App582
//
//  Created by IGOR on 29/05/2024.
//

import SwiftUI
import CoreData

final class HomeViewModel: ObservableObject {

    @Published var isAdd: Bool = false
    
    @AppStorage("newStud") var newStud = ""
    @AppStorage("paid") var paid = ""
    @AppStorage("didntPay") var didntPay = ""
    @AppStorage("revenue") var revenue = ""
    
    @Published var newStud1 = ""
    @Published var paid1 = ""
    @Published var didntPay1 = ""
    @Published var revenue1 = ""
    
}

