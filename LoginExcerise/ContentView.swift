//
//  ContentView.swift
//  LoginExcerise
//
//  Created by Jose G on 4/27/25.
//

import SwiftUI

struct ContentView: View {
   
    //User Input and Login state:
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        
        //Shows the welcomeView if login works, if not it shows loginView
        if isLoggedIn {
            WelcomeView(email: email, isLoggedin: $isLoggedIn)
            
        }else{
            LoginView(email: $email, password: $password, ShowingAlert: $showingAlert, alertMessage: $alertMessage, isLoggedIn: $isLoggedIn)
        }
        
    }
    
}

//Log Screen
struct LoginView: View {
    
    //Bindings to states
    @Binding var email: String
    @Binding var password: String
    @Binding var ShowingAlert: Bool
    @Binding var alertMessage: String
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            //Title or Heading
            Text("Login")
                .font(.largeTitle)
                .bold()
            
            //Email text field
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.horizontal)
            
            //Password field
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            //Login Button
            Button(action: {
                login()
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .presentationCornerRadius(10)
                    .padding(.horizontal)
                
            }
        }
        .alert(isPresented: $ShowingAlert) {
            
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
            
    }
    //Function to handle login
    func login(){
        
        //If the fields are empty
        if email.isEmpty || password.isEmpty {
            alertMessage = "Please fill in the fields!"
            ShowingAlert = true
            return
        }
        
        //Valid Credentials
        let validEmail = ["intern@nearabl.com", "hello@nearabl.com"]
        let validPassword = "2025"
                    
        if validEmail.contains(email.lowercased()) && (validPassword == password){
            isLoggedIn = true //Login was sucessful
       
        } else {
            alertMessage = "Invalid email or password! Please try again!"
            ShowingAlert = true //Shows the error alert prompt
        }
    }
    
}

struct WelcomeView: View {
    var email: String
    @Binding var isLoggedin: Bool
    
    var body: some View {
        VStack (spacing: 20) {
            
            //Welcome message!
            Text("Welcome, \(email)")
                .font(.title)
                .padding()
            
            //Logout button
            Button(action: {
                isLoggedin = false
            }) {
                Text("Logout")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
