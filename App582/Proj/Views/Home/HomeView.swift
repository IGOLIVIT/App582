//
//  HomeView.swift
//  App582
//
//  Created by IGOR on 29/05/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Text("Home")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Rectangle()
                    .foregroundColor(.gray.opacity(0.4))
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                
                VStack(spacing: 14) {
                    
                    HStack {
                        
                        Text("New students:")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .regular))
                        
                        Spacer()
                        
                        Text(viewModel.newStud)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                    }
                    
                    Rectangle()
                        .fill(.gray.opacity(0.3))
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                    
                    HStack {
                        
                        Text("Paid:")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .regular))
                        
                        Spacer()
                        
                        Text(viewModel.paid)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                    }
                    
                    Rectangle()
                        .fill(.gray.opacity(0.3))
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                    
                    HStack {
                        
                        Text("Didn't paid:")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .regular))
                        
                        Spacer()
                        
                        Text(viewModel.didntPay)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                    }
                    
                    Rectangle()
                        .fill(.gray.opacity(0.3))
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                    
                    HStack {
                        
                        Text("Revenue for month:")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                        
                        Spacer()
                        
                        Text("$ \(viewModel.revenue)")
                            .foregroundColor(Color("prim"))
                            .font(.system(size: 16, weight: .medium))

                    }
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 14).fill(.gray.opacity(0.2)))
                .padding()
                
                Spacer()
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = true
                    }
                    
                }, label: {

                    Text("Edit")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                })
                .padding()
            }
        }
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isAdd ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAdd = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Edit data")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .medium))
                        .padding()
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("New students")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.newStud1.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.newStud1)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .semibold))
                        
                    })
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(RoundedRectangle(cornerRadius: 5).fill(.white))
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Paid")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.paid1.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.paid1)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .semibold))
                        
                    })
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(RoundedRectangle(cornerRadius: 5).fill(.white))
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Didn't pay")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.didntPay1.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.didntPay1)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .semibold))
                        
                    })
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(RoundedRectangle(cornerRadius: 5).fill(.white))
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Revenue for month")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .opacity(viewModel.revenue1.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.revenue1)
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .semibold))
                        
                    })
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(RoundedRectangle(cornerRadius: 5).fill(.white))
                                            
                        Button(action: {
                            
                            viewModel.newStud = viewModel.newStud1
                            viewModel.paid = viewModel.paid1
                            viewModel.didntPay = viewModel.didntPay1
                            viewModel.revenue = viewModel.revenue1
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                                
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
                                
                                viewModel.isAdd = false
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
                .offset(y: viewModel.isAdd ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    HomeView()
}
