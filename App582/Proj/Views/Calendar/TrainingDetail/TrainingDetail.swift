//
//  TrainingDetail.swift
//  App582
//
//  Created by IGOR on 29/05/2024.
//

import SwiftUI

struct TrainingDetail: View {
    
    @StateObject var viewModel: CalendarViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text(viewModel.selectedTraining?.trName ?? "")
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
                        
                        Text(viewModel.selectedTraining?.trName ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))
                        
                        Text(viewModel.selectedTraining?.trDay ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))
                        
                        HStack {
                            
                            Text(viewModel.selectedTraining?.trStTime ?? "")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .regular))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))
                            
                            Text(viewModel.selectedTraining?.trETime ?? "")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .regular))
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))
                            
                        }
                        .padding(.vertical)
                        
                        Text("Members")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(viewModel.selectedTraining?.trMembers ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.1)))
                        
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    TrainingDetail(viewModel: CalendarViewModel())
}
