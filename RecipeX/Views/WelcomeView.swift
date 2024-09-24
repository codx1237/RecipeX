//
//  ContentView.swift
//  RecipeX
//
//  Created by Fırat Ören on 16.09.2024.
//

import SwiftUI

struct WelcomeView: View {

    @State private var isShowingSignUp = false
    @State private var isShowingLogin  = false
    
    var body: some View {

            VStack {
                Image("Logo")
                    .resizable()
                    .frame(width: 200,height: 200)
                    .clipShape(Circle())

                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi tincidunt, urna non dictum aliquam, ex metus commodo risus, in mollis.")
                        .multilineTextAlignment(.center)
                        .padding()

                Button(action: {
                    withAnimation {
                        isShowingSignUp.toggle()
                    }
                }, label: {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity,maxHeight: 50)
                        .background(Color("ButtonColor"))
                        .foregroundStyle(Color.white)
                        .font(.title2)
                        .bold()
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                        .padding(.horizontal)
                }).fullScreenCover(isPresented: $isShowingSignUp, content: {
                    SignUpView()
                })


                Button(action: {
                    withAnimation {
                        isShowingLogin.toggle()
                    }
                }, label: {
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 20), style: .circular)
                        .stroke(Color.green,lineWidth: 1.0)
                        .frame(maxWidth: .infinity,maxHeight: 50)
                        .padding(.horizontal)
                        .overlay {
                            Text("Login")
                                .foregroundStyle(Color.green)
                                .font(.title2)
                                .bold()
                        }
                }).fullScreenCover(isPresented: $isShowingLogin, content: {
                    LoginView()
                })



            }


    }
}

#Preview {
    WelcomeView()
}
