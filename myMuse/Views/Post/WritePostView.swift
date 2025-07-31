//
//  WritePost.swift
//  myMuse
//
//  Created by Tucker on 10/21/23.
//

import SwiftUI
import CloudKit


@available(iOS 16.0, *)
struct WritePostView: View {
    var prompt: String =  "This is where the prompt will show"
    @State private var postText: String = ""
    let container = CKContainer(identifier: "iCloud.myMuseDatabase")
    
    @Binding var isPresented: Bool
    
        var body: some View {
            VStack(spacing: 20){
                
            Text("Write a Response")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
            PromptView(promptText: CloudKitManager.shared.currentPromptText ?? "No Prompt Available At the time being.")
        
             
            TextEditor(text: $postText)
                    .scrollContentBackground(.hidden) //
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .frame(minHeight: 200, maxHeight: .infinity)
                
                
            Spacer()
                
                Button(action: postButtonTapped) {
                    Text("Post Your Muse")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(ColorsManager.shared.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    
                }
            
            
                
            
                
                
//            Button("Post") {
//                // post function
//                // create post ck record
//                //let userRecord = CKRecord(recordType: "User")
//                let promptRecord = CKRecord(recordType: "Prompt")
//
//                CloudKitManager.shared.fetchCurrentUser { userRecord in
//                    if let userRecord = userRecord {
//                        // Create a CKRecord.Reference using the user record ID
//                        let userRecordID = userRecord.recordID
//                        let usersName = userRecord["Username"] as? String
//                        print(usersName!)
//                        
//                        let promptReference = CKRecord.Reference(recordID: CloudKitManager.shared.currentPromptID ?? promptRecord.recordID, action: .none)
//
//                        let record = CKRecord(recordType: "Post")
//                        record.setValuesForKeys([
//                            "Prompt": promptReference,
//                            "Text": postText,
//                            "User": CKRecord.Reference(recordID: userRecordID, action: .none),
//                            "usersName": usersName ?? "Anonymous",
//                            "promptText": CloudKitManager.shared.currentPromptText ?? "THE DOME"
//                        ])
//
//                        CloudKitManager.shared.saveRecord(record: record)
//                    } else {
//                        // Handle the case where the user record couldn't be fetched
//                        print("Hey Tuck, unfortunately it didn't work.")
//                    }
//                }
//            }

            
            
            
           // NavBar()
            
        }
            .padding()
            // The main app background will show through, no .background modifier needed here
    }
    
    
    // It's good practice to move the button's logic into its own function
    private func postButtonTapped() {
        let promptRecord = CKRecord(recordType: "Prompt")
        
        CloudKitManager.shared.fetchCurrentUser { userRecord in
            if let userRecord = userRecord {
                let userRecordID = userRecord.recordID
                let usersName = userRecord["Username"] as? String
                
                let promptReference = CKRecord.Reference(recordID: CloudKitManager.shared.currentPromptID ?? promptRecord.recordID, action: .none)
                
                let record = CKRecord(recordType: "Post")
                record.setValuesForKeys([
                    "Prompt": promptReference,
                    "Text": postText,
                    "User": CKRecord.Reference(recordID: userRecordID, action: .none),
                    "usersName": usersName ?? "Anonymous",
                    "promptText": CloudKitManager.shared.currentPromptText ?? "THE DOME"
                ])
                
                CloudKitManager.shared.saveRecord(record: record)
                
                // Clear the text field after posting
                postText = ""
                
            } else {
                print("Could not fetch user to post.")
            }
        }
        
    }
        
}

@available(iOS 16.0, *)
struct WritePost_Previews: PreviewProvider {
    static var previews: some View {
        // Create a binding for isPresented in the preview
        let isPresented = Binding.constant(false)
        
        // Pass the binding to WritePost in the preview
        WritePostView(isPresented: isPresented)
    }
}
