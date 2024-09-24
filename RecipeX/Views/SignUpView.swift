//
//  SignUpView.swift
//  RecipeX
//
//  Created by Fırat Ören on 17.09.2024.
//

import SwiftUI
import SwiftData

enum SignUpError: LocalizedError {
    case emailEmpty
    case passwordEmpty
    case confimPasswordEmpty
    case passwordsNotMatched
    case nameEmpty

    var errorDescription: String? {
        switch self {
        case .emailEmpty:
            return "Email cannot be empty"
        case .passwordEmpty:
            return "Password cannot be empty"
        case .confimPasswordEmpty:
            return "Password cannot be empty"
        case .passwordsNotMatched:
            return "Passwords not matched"
        case .nameEmpty:
            return "Name cannot be empty"
        }
    }
}

struct SignUpState {
    var email = ""
    var password = ""
    var confirmPassword = ""
    var name = ""
    var emailError: SignUpError?
    var passwordError: SignUpError?
    var confirmPasswordError: SignUpError?
    var passwordsNotMatchedError: SignUpError?
    var nameError: SignUpError?

    mutating func clearErrors() {
        emailError = nil
        passwordError = nil
        confirmPasswordError = nil
        passwordsNotMatchedError = nil
        nameError = nil
    }

    mutating func isValid() -> Bool {

        clearErrors()

        if email.isEmpty {
            emailError = .emailEmpty
        }
        if password.isEmpty {
            passwordError = .passwordEmpty
        }
        if confirmPassword.isEmpty {
            confirmPasswordError = .confimPasswordEmpty
        }
        if password != confirmPassword {
            passwordsNotMatchedError = .passwordsNotMatched
        }
        if name.isEmpty {
            nameError = .nameEmpty
        }
        return emailError == nil && passwordError == nil && confirmPasswordError == nil && passwordsNotMatchedError == nil && nameError == nil
    }
}


struct SignUpView: View {


    @Environment(\.dismiss) var dissmis

    @State var email = ""
//    @State var password = ""
//    @State var confirm_password = ""
//    @State var name = ""
    @State private var signUpError: String?
//    @State var emailError: SignUpError?
//    @State var passwordError: SignUpError?
//    @State var confirmPasswordError: SignUpError?
//    @State var passwordsNotMatched: SignUpError?
//    @State var nameError: SignUpError?
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    @State private var signUpState = SignUpState()
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]

//    private func isValidFields() -> Bool {
//
//        if email.isEmpty {
//            emailError = SignUpError.emailEmpty
//        }
//        if password.isEmpty {
//            passwordError = SignUpError.passwordEmpty
//        }
//        if confirm_password.isEmpty {
//            confirm_password = SignUpError.confimPasswordEmpty
//        }
//    }

    private func signUp() {
        // Check if username already exists
        if let user = users.first {
            signUpError = "Only one account can be created per device"
        } else {
            let newUser = User(email: signUpState.email, password: signUpState.password, name: signUpState.name)
            modelContext.insert(newUser)
            try! modelContext.save()
        }


    }

    var body: some View {
        VStack(spacing: 50){
            HStack{
                Spacer()
                Spacer()
                Text("Create Account")
                    .font(.title)
                    .bold()
                    .padding(.top)
                Spacer()
                Button(action: {
                    dissmis()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundStyle(Color("ButtonColor"))
                        .padding(.trailing)
                        .padding(.top)
                })
            }


            VStack(alignment:.leading,spacing: 10) {
                Text("Email")
                    .font(.system(size: 16,weight: .bold))

                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10), style: .continuous).stroke(Color.black,lineWidth: 1.0)
                    .frame(maxWidth: .infinity,maxHeight: 40)
                    .overlay {
                        TextField("📧 Email", text: $signUpState.email)
                            .padding()
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                    }
                if let emailError = signUpState.emailError {
                    Text(emailError.localizedDescription)
                }
                Text("Password")
                    .font(.system(size: 16,weight: .bold))

                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10), style: .continuous).stroke(Color.black,lineWidth: 1.0)
                    .frame(maxWidth: .infinity,maxHeight: 40)
                    .overlay {
                        TextField("🔐 Password", text: $signUpState.password)
                            .padding()
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                    }
                if let passwordError = signUpState.passwordError {
                    Text(passwordError.localizedDescription)
                }

                Text("Confirm Password")
                    .font(.system(size: 16,weight: .bold))

                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10), style: .continuous).stroke(Color.black,lineWidth: 1.0)
                    .frame(maxWidth: .infinity,maxHeight: 40)
                    .overlay {
                        TextField("🔐 Confirm Password", text: $signUpState.confirmPassword)
                            .padding()
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                    }
                if let confirmPasswordError = signUpState.confirmPasswordError {
                    Text(confirmPasswordError.localizedDescription)
                }
                if let passwordsNotMatchedError = signUpState.passwordsNotMatchedError {
                    Text(passwordsNotMatchedError.localizedDescription)
                }
                Text("Name")
                    .font(.system(size: 16,weight: .bold))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)

                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10), style: .continuous).stroke(Color.black,lineWidth: 1.0)
                    .frame(maxWidth: .infinity,maxHeight: 40)
                    .overlay {
                        TextField("Name", text: $signUpState.name)
                            .padding()
                    }
                if let nameError = signUpState.nameError {
                    Text(nameError.localizedDescription)
                }
                
                Button {
                    withAnimation {
                        if signUpState.isValid() {
                            signUp()
                            isLoggedIn = true
                            dissmis()
                        }
                    }
                } label: {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity,maxHeight: 50)
                        .background(Color("ButtonColor"))
                        .foregroundStyle(Color.white)
                        .font(.title2)
                        .bold()
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                        .padding(.horizontal)
                        .padding(.top)

                }


            }.padding(.horizontal)

            Spacer()



        }




    }
}

#Preview {
    SignUpView()
}
