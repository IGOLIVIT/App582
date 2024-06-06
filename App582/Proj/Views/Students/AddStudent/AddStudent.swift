//
//  AddStudent.swift
//  App582
//
//  Created by IGOR on 30/05/2024.
//

import SwiftUI

struct AddStudent: View {

    @StateObject var viewModel: StudentsViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Add a student")
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
                .padding(.bottom)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {
                        
                        Menu(content: {
                            
                            ForEach(viewModel.photos, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.currentPhoto = index
                                    
                                }, label: {
                                    
                                    Image(index)
                                })
                                
                            }
                            
                        }, label: {
                            
                            if viewModel.currentPhoto.isEmpty {
                                
                                Image(systemName: "photo")
                                    .foregroundColor(.white.opacity(0.4))
                                    .padding(25)
                                    .background(Circle().fill(.white.opacity(0.15)))
                                
                            } else {
                                
                                Image(viewModel.currentPhoto)
                            }
                            
                        })
                        
                        Text("Information")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Name*")
                                .foregroundColor(.white.opacity(0.3))
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.stName.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.stName)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))
                        .padding(.bottom)
                        
                        Text("Payment history")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVStack {
                                
                                ForEach(viewModel.payments, id: \.self) { index in
                                
                                    HStack {
                                        
                                        Text("$ \(index.payMoney ?? "")")
                                            .foregroundColor(.white)
                                            .font(.system(size: 15, weight: .regular))
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))
                                    .padding()
                                }
                            }
                            
                            Button(action: {
                                
                                withAnimation(.spring()) {
                                    
                                    viewModel.isAddPayment = true
                                }
                                
                            }, label: {
                                
                                HStack {
                                    
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .medium))
                                    
                                    Text("Click to add a payment")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14, weight: .regular))
                                }
                                .padding(12)
                                .padding(.horizontal)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(.white.opacity(0.4)))
                                .padding(1)
                            })
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                
                Button(action: {

                    viewModel.stPhoto = viewModel.currentPhoto
                    
                    viewModel.addStudent()
                    
                    viewModel.stName = ""
                    viewModel.currentPhoto = ""
                    
                    viewModel.fetchStudents()
                    
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
                .opacity(viewModel.stName.isEmpty ? 0.5 : 1)
                .disabled(viewModel.stName.isEmpty ? true : false)
            }
            .padding()
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddPayment ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddPayment = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddPayment = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Add payment")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .medium))
                        .padding()
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Enter payment")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.payMoney.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.payMoney)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .semibold))
                        
                    })
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(RoundedRectangle(cornerRadius: 5).fill(.white))

                        Button(action: {
                            
                            viewModel.currentStudent = viewModel.stName
                            
                            viewModel.addPayment()
                            
                            viewModel.payMoney = ""
                            
                            viewModel.fetchPayments()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddPayment = false
                                
                            }
                            
                        }, label: {
                            
                            Text("Save")
                                .foregroundColor(.blue)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)

                        })
                        
                        Button(action: {
                                                        
                            withAnimation(.spring()) {
                                
                                viewModel.isAddPayment = false
                            }
                            
                        }, label: {
                            
                            Text("Cancel")
                                .foregroundColor(.blue)
                                .font(.system(size: 18, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                            
                        })

                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                .padding()
                .offset(y: viewModel.isAddPayment ? 0 : UIScreen.main.bounds.height)
            }
        )
        .onAppear {
            
            viewModel.fetchPayments()
        }
    }
}

#Preview {
    AddStudent(viewModel: StudentsViewModel())
}
