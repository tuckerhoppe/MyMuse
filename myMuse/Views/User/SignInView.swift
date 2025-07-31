//
//  SignInView.swift
//  myMuse
//
//  Created by Tucker on 12/8/23.
//

import SwiftUI
import CloudKit

struct SignInView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var bio: String = ""
    
    @State private var signInMessage: String?
    let textColor = ColorsManager.shared.textColorFor
    //private let cloudKitManager = CloudKitManager()
    
    var body: some View {
        VStack {
            
            TextField("Username", text: $username)
                .background(textColor)
            TextField("Password", text: $password)
                .background(textColor)
            TextField("bio", text: $bio)
                .background(textColor)
            
            HStack {
                Button("Create Account") {
                    let record = CKRecord(recordType: "User")
                    record.setValuesForKeys([
                        "Username": username,
                        "Password": password,
                        "Bio": bio
                    ])
                    CloudKitManager.shared.saveRecord(record: record, recordIsUser: true)
                    //automatically sign in
                }
                
                Button("Sign In") {
                    CloudKitManager.shared.signInAs(username: username, password: password) { success, userRecord in
                        if success, let userRecord = userRecord {
                            // Sign in successful, do something with userRecord
                            print("Sign in successful!")
                            CloudKitManager.shared.setCurrentUser(record: userRecord)
                            signInMessage = "Sign in successful!"
                        } else {
                            // Sign in failed
                            print("Sign in failed. Incorrect username or password.")
                            signInMessage = "Sign in failed. Incorrect username or password."
                        }
                    }
                }
                
            }
            
            if let signInMessage = signInMessage {
                        Text(signInMessage)
                            .foregroundColor(signInMessage.contains("successful") ? .green : .red)
                    }
            
            Spacer()
            NavBar()
            
        }
        .background(LinearGradient(gradient: Gradient(colors: ColorsManager.shared.contrastColor), startPoint: .top, endPoint: .bottom))
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
