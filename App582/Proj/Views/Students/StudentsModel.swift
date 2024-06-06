//
//  StudentsModel.swift
//  App582
//
//  Created by IGOR on 29/05/2024.
//

import SwiftUI

struct StudentsModel: View {
    
    @StateObject var viewModel = StudentsViewModel()
    
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Students")
                        .foregroundColor(.white)
                        .font(.system(size: 32, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = true
                        }
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .medium))
                        
                    })
                }
                .padding()
                
                Rectangle()
                    .foregroundColor(.gray.opacity(0.4))
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                
                if viewModel.students.isEmpty {
                    
                    VStack {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = true
                            }
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .medium))
                                
                                Text("Click to add a student")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                            }
                            .padding(12)
                            .padding(.horizontal)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(.white.opacity(0.4)))
                        })
                    }
                    .padding()
                    .frame(maxHeight: .infinity)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                            
                            ForEach(viewModel.students, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.selectedStudent = index
                                    viewModel.currentStudent = viewModel.selectedStudent?.stName ?? ""
                                    viewModel.isMore = true
                                    
                                }, label: {
                                    
                                    VStack(spacing: 15) {
                                        
                                        Image(index.stPhoto ?? "")
                                        
                                        Text(index.stName ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18, weight: .medium))
                                        
                                        Text("New")
                                            .foregroundColor(.black)
                                            .font(.system(size: 11, weight: .regular))
                                            .padding(4)
                                            .background(RoundedRectangle(cornerRadius: 3).fill(.gray.opacity(0.4)))
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))
                                })
                            }
                        })
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            
            viewModel.fetchStudents()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddStudent(viewModel: viewModel)
        })
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isMore ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isMore = false
                        }
                    }
                
                VStack {
                    
                    VStack {
                        
                        Text("\(viewModel.selectedStudent?.stName ?? "")")
                            .foregroundColor(.black.opacity(0.6))
                            .font(.system(size: 13, weight: .regular))
                            .padding()
                        
                        Button(action: {
                            
                            viewModel.currentStudent = viewModel.selectedStudent?.stName ?? ""
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isMore = false
                                
                            }
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDetail = true
                            }
                            
                        }, label: {
                            
                            Text("Details")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                            
                        })
                        .padding(.top, 25)
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isMore = false
                                
                                viewModel.isDelete = true
                            }
                            
                        }, label: {
                            
                            Text("Delete")
                                .foregroundColor(.red)
                                .font(.system(size: 16, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                            
                        })
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isMore = false
                        }
                        
                    }, label: {

                        Text("Cancel")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                    })
                    
                }
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.black))
                .padding()
                .offset(y: viewModel.isMore ? 0 : UIScreen.main.bounds.height)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        )
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Delete")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    Text("Are you sure you want to delete?")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        
                        CoreDataStack.shared.deleteStudent(withStName: viewModel.selectedStudent?.stName ?? "", completion: {
                            
                            viewModel.fetchStudents()
                        })
          
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                            
                        }
                                
                    }, label: {
                        
                        Text("Delete")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                    .padding(.top, 25)
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                        
                    }, label: {
                        
                        Text("Close")
                            .foregroundColor(.red)
                            .font(.system(size: 18, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .padding()
                .offset(y: viewModel.isDelete ? 0 : UIScreen.main.bounds.height)
            }
        )
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            StudentsDetail(viewModel: viewModel)
        })
    }
}

#Preview {
    StudentsModel()
}
