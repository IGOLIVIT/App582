//
//  Reviews.swift
//  App582
//
//  Created by IGOR on 28/05/2024.
//

import SwiftUI
import StoreKit

struct Reviews: View {
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                                
                Image("Reviews")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .ignoresSafeArea()
                
                Spacer()

            }
            
            VStack {
                
                Text("Rate our app in the")
                    .foregroundColor(.black)
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack {
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("prim"))
                        .font(.system(size: 20, weight: .regular))
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("prim"))
                        .font(.system(size: 20, weight: .regular))
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("prim"))
                        .font(.system(size: 20, weight: .regular))
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("prim"))
                        .font(.system(size: 20, weight: .regular))
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(Color("prim"))
                        .font(.system(size: 20, weight: .regular))
                }
                
                Spacer()
                
                NavigationLink(destination: {
                    
                    Not()
                        .navigationBarBackButtonHidden()
                    
                }, label: {
                    
                    Text("Next")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("prim")))
                })
                .padding()
            }
        }
        .onAppear {
            
            SKStoreReviewController.requestReview()
        }
    }
}

#Preview {
    Reviews()
}
