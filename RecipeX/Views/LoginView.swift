//
//  LoginView.swift
//  RecipeX
//
//  Created by Fırat Ören on 17.09.2024.
//

import SwiftUI
import SwiftData

enum LoginError: LocalizedError {
    case emailEmpty
    case passwordEmpty


    var errorDescription: String? {
        switch self {
        case .emailEmpty:
            return "Email cannot be empty"
        case .passwordEmpty:
            return "Password cannot be empty"
        }
    }
}

struct LoginState {
    var email = ""
    var password = ""
    var emailError: LoginError?
    var passwordError: LoginError?


    mutating func clearErrors() {
        emailError = nil
        passwordError = nil
    }

    mutating func isValid() -> Bool {

        clearErrors()

        if email.isEmpty {
            emailError = .emailEmpty
        }
        if password.isEmpty {
            passwordError = .passwordEmpty
        }
        return emailError == nil && passwordError == nil
    }
}


struct LoginView: View {



    @Environment(\.dismiss) var dissmis

    @State private var loginState = LoginState()

    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var loginError: String?
    @Query private var users: [User]

    private func login() {
        if let user = users.first {
            if user.email == loginState.email && user.password == loginState.password {
                isLoggedIn = true
                dissmis()
            } else {
                loginError = "Email or password is incorrect"
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 12){
            HStack{
                Spacer()
//                Spacer()
//                Text("Log In")
//                    .font(.title)
//                    .bold()
//                    .padding(.top)
//                Spacer()
                Button(action: {
                    dissmis()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundStyle(Color("ButtonColor"))
                        .padding(.trailing)
                        .padding(.top)
                })
            }.padding(.bottom,50)
           // Spacer()
            Image("Logo")
                .resizable()
                .frame(width: 200,height: 200)
                .clipShape(Circle())

            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10), style: .continuous).stroke(Color.black,lineWidth: 1.0)
                .frame(maxWidth: .infinity,maxHeight: 40)
                .overlay {
                    TextField("📧 Email", text: $loginState.email)
                        .padding()
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
            if let emailError = loginState.emailError {
                Text(emailError.localizedDescription)
            }

            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10), style: .continuous).stroke(Color.black,lineWidth: 1.0)
                .frame(maxWidth: .infinity,maxHeight: 40)
                .overlay {
                    TextField("🔐 Password", text: $loginState.password)
                        .padding()
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
            if let passwordError = loginState.passwordError {
                Text(passwordError.localizedDescription)
            }
            if let loginError = loginError {
                Text(loginError)
                    .foregroundStyle(Color.red)
            }

            Button(action: {
                withAnimation {
                    if loginState.isValid() {
                        login()
                    }

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
                    .padding(.top)
            })

            Spacer()
//            Spacer()
//            Spacer()

        }.padding(.horizontal)
    }
}

#Preview {
    LoginView()
}
