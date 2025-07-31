//
//  WritePost.swift
//  myMuse
//
//  Created by Tucker on 10/21/23.
//

import SwiftUI
import CloudKit


struct WritePost: View {
    var prompt: String =  "This is where the prompt will show"
    @State private var postText: String = ""
    let container = CKContainer(identifier: "iCloud.myMuseDatabase")
    
    @Binding var isPresented: Bool
    
        var body: some View {
        VStack{
           // Text(prompt)
            //.background(Color.gray)
            PromptView(promptText: CloudKitManager.shared.currentPromptText ?? "nothing today JDKLSJf")
        
             
            TextEditor(text: $postText)
                .frame(minHeight: 100) // Adjust the minimum height to control the size
                .border(Color.gray, width: 1) // Add a border for visual separation
                .padding()
            
            
            Button("Post") {
                // post function
                // create post ck record
                //let userRecord = CKRecord(recordType: "User")
                let promptRecord = CKRecord(recordType: "Prompt")

                CloudKitManager.shared.fetchCurrentUser { userRecord in
                    if let userRecord = userRecord {
                        // Create a CKRecord.Reference using the user record ID
                        let userRecordID = userRecord.recordID
                        let usersName = userRecord["Username"] as? String
                        print(usersName!)
                        
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
                    } else {
                        // Handle the case where the user record couldn't be fetched
                        print("Hey Tuck, unfortunately it didn't work.")
                    }
                }
            }

            
            
            
            NavBar()
            
        }
        .background(LinearGradient(gradient: Gradient(colors: ColorsManager.shared.backgroundGradient), startPoint: .top, endPoint: .bottom))
    }
        
}

struct WritePost_Previews: PreviewProvider {
    static var previews: some View {
        // Create a binding for isPresented in the preview
        let isPresented = Binding.constant(false)
        
        // Pass the binding to WritePost in the preview
        WritePost(isPresented: isPresented)
    }
}
