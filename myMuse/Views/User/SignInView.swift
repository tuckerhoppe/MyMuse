//
//  SignInView.swift
//  myMuse
//
//  Created by Tucker on 12/8/23.
//

import SwiftUI
import CloudKit

enum AuthMode {
    case signIn, createAccount
}

struct SignInView: View {
    @State private var authMode: AuthMode = .signIn
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var bio: String = ""
    
    @State private var statusMessage: String?
    @State private var isError: Bool = false
    let textColor = ColorsManager.shared.textColorFor
    //private let cloudKitManager = CloudKitManager()
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Picker to switch Nodes
            Picker("Mode", selection: $authMode) {
                Text("Sign In").tag(AuthMode.signIn)
                Text("Create Account").tag(AuthMode.createAccount)
            }
            .pickerStyle(.segmented)
            
            // Main Form Content
            VStack(spacing: 16){
                TextField("Username", text: $username)
                    .textContentType(.username)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .textContentType(.password)
                
                if authMode == .createAccount {
                    TextField("A short bio", text: $bio)
                }
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            
            // Status message for success or failure
            if let statusMessage = statusMessage {
                Text(statusMessage)
                    .foregroundColor(isError ? .red : .green)
                    .font(.footnote)
            }
            
            // Single Primary action Button
            Button(action: handleAuthAction) {
                Text(authMode == .signIn ? "Sign In" : "Create Account")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(ColorsManager.shared.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            Spacer()
        }
        .padding()
    }
        
    // A single function to handle both signing in and creating an account
    private func handleAuthAction() {
        if authMode == .signIn {
            CloudKitManager.shared.signInAs(username: username, password: password) { success, userRecord in
                if success, let userRecord = userRecord {
                    CloudKitManager.shared.setCurrentUser(record: userRecord)
                    self.statusMessage = "Sign in successful!"
                    self.isError = false
                } else {
                    self.statusMessage = "Sign in failed. Check username or password."
                    self.isError = true
                }
            }
        } else {
            let record = CKRecord(recordType: "User")
            record.setValuesForKeys([
                "Username": username,
                "Password": password, // Remember to replace this with secure auth later!
                "Bio": bio
            ])
            CloudKitManager.shared.saveRecord(record: record, recordIsUser: true)
            self.statusMessage = "Account created successfully! You can now sign in."
            self.isError = false
        }
    }
}





struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
