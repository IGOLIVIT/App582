//
//  AddTraining.swift
//  App582
//
//  Created by IGOR on 29/05/2024.
//

import SwiftUI

struct AddTraining: View {

    @StateObject var viewModel: CalendarViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Add a class")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                        .padding()
                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 18, weight: .regular))
                            
                            Text("Back")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 16, weight: .regular))
                        })
                        
                        Spacer()
                    }
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {
                        
                        Text("Information")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Workout name*")
                                .foregroundColor(.white.opacity(0.3))
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.trName.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.trName)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))

                        
                        Menu(content: {
                            
                            ForEach(viewModel.days, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.currentDay = index
                                    
                                }, label: {
                                    
                                    Text(index)
                                })
                            }
                            
                        }, label: {
                            
                            if viewModel.currentDay.isEmpty {
                                
                                Text("Day of the week*")
                                    .foregroundColor(.white.opacity(0.3))
                                    .font(.system(size: 14))
 
                                
                            } else {
                                
                                Text(viewModel.currentDay)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                            }
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))

                        HStack {
                            
                                ZStack(alignment: .leading, content: {
                                    
                                    Text("Start time*")
                                        .foregroundColor(.white.opacity(0.3))
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.trStTime.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.trStTime)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))

                                ZStack(alignment: .leading, content: {
                                    
                                    Text("End time*")
                                        .foregroundColor(.white.opacity(0.3))
                                        .font(.system(size: 14, weight: .regular))
                                        .opacity(viewModel.trETime.isEmpty ? 1 : 0)
                                    
                                    TextField("", text: $viewModel.trETime)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 14, weight: .semibold))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))

                        }
                        .padding(.vertical)
                        
                        Text("Members")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Enter names a students")
                                .foregroundColor(.white.opacity(0.3))
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.trMembers.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.trMembers)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))

                    }
                }
                
                Button(action: {
                    
                    viewModel.trDay = viewModel.currentDay
                    
                    viewModel.addTraining()
                    
                    viewModel.currentDay = ""
                    viewModel.trName = ""
                    viewModel.trStTime = ""
                    viewModel.trETime = ""
                    viewModel.trMembers = ""
                    
                    viewModel.fetchTrainings()
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = false
                    }
                    
                }, label: {

                    Text("Save")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                })
                .opacity(viewModel.trName.isEmpty || viewModel.currentDay.isEmpty || viewModel.trStTime.isEmpty || viewModel.trETime.isEmpty ? 0.5 : 1)
                .disabled(viewModel.trName.isEmpty || viewModel.currentDay.isEmpty || viewModel.trStTime.isEmpty || viewModel.trETime.isEmpty ? true : false)
            }
            .padding()
        }
    }
}

#Preview {
    AddTraining(viewModel: CalendarViewModel())
}
