//
//  CalendarView.swift
//  App582
//
//  Created by IGOR on 29/05/2024.
//

import SwiftUI

struct CalendarView: View {
    
    @StateObject var viewModel = CalendarViewModel()
    
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Calendar")
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
                
                if viewModel.trainings.isEmpty {
                    
                    VStack {
                        
                        Text("No classes")
                            .foregroundColor(.white.opacity(0.4))
                            .font(.system(size: 16, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .padding()
                    .frame(height: 70)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))
                    .padding()
                    
                    Spacer()
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack(spacing: 14) {
                            
                            ForEach(viewModel.trainings, id: \.self) { index in
                            
                                VStack {
                                    
                                    HStack {
                                        
                                        VStack(alignment: .leading, spacing: 10) {
                                            
                                            Text(index.trName ?? "")
                                                .foregroundColor(.white)
                                                .font(.system(size: 16, weight: .medium))
                                            
                                            HStack {
                                                
                                                Text("\(index.trStTime ?? "") - \(index.trETime ?? "")")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 12, weight: .regular))
                                                    .padding(4)
                                                    .background(RoundedRectangle(cornerRadius: 4).fill(Color("prim")))
                                                
                                                Text(index.trDay ?? "")
                                                    .foregroundColor(.white.opacity(0.4))
                                                    .font(.system(size: 13, weight: .regular))
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            
                                            viewModel.selectedTraining = index
                                            
                                            withAnimation(.spring()) {
                                                
                                                viewModel.isMore = true
                                            }
                                            
                                        }, label: {
                                            
                                            VStack(spacing: 4) {
                                                
                                                Circle()
                                                    .fill(.white)
                                                    .frame(width: 3, height: 3)
                                                
                                                Circle()
                                                    .fill(.white)
                                                    .frame(width: 3, height: 3)
                                                
                                                Circle()
                                                    .fill(.white)
                                                    .frame(width: 3, height: 3)
                                            }
                                        })
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 15).fill(.white.opacity(0.1)))
                                    .background(RoundedRectangle(cornerRadius: 15).stroke(.white.opacity(0.4)))
                                    .padding()
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchTrainings()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddTraining(viewModel: viewModel)
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
                        
                        Text("\(viewModel.selectedTraining?.trName ?? "") \(viewModel.selectedTraining?.trStTime ?? "")-\(viewModel.selectedTraining?.trETime ?? "")")
                            .foregroundColor(.black.opacity(0.6))
                            .font(.system(size: 13, weight: .regular))
                            .padding()
                        
                        Button(action: {
                            
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
                        
                        CoreDataStack.shared.deleteTraining(withTrName: viewModel.selectedTraining?.trName ?? "", completion: {
                            
                            viewModel.fetchTrainings()
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
            
            TrainingDetail(viewModel: viewModel)
        })
    }
}

#Preview {
    CalendarView()
}
