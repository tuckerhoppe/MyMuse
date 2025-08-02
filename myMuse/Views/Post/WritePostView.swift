//
//  WritePost.swift
//  myMuse
//
//  Created by Tucker on 10/21/23.
//

import SwiftUI
import CloudKit


struct WritePostView: View {
    @ObservedObject var cloudKitManager = CloudKitManager.shared
    @FocusState private var isTextEditorFocused: Bool
    
    @State private var postText: String = ""
    @State private var lastPostedText: String = ""
    @State private var isPosting: Bool = false
    @State private var showSuccessMessage: Bool = false
    @State private var errorMessage: String?
    
    private var isPostButtonDisabled: Bool {
        isPosting || postText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || postText == lastPostedText
    }
    
    var body: some View {
        // Use a ZStack as the root view to layer the success message on top.
        ZStack {
            // This VStack contains all your main UI content.
            VStack(spacing: 20) {
                Text("Write a Response")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                PromptView(promptText: cloudKitManager.currentPromptText ?? "Loading Prompt...")

                TextEditor(text: $postText)
                    .focused($isTextEditorFocused)
                    .scrollContentBackground(.hidden)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .frame(minHeight: 200, maxHeight: .infinity)
                    
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                    
                Spacer()
                    
                Button(action: postButtonTapped) {
                    if isPosting {
                        ProgressView()
                    } else {
                        Text("Post Your Muse")
                    }
                }
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isPostButtonDisabled ? Color.gray : ColorsManager.shared.accentColor)
                .foregroundColor(.white)
                .cornerRadius(20)
                .disabled(isPostButtonDisabled)
            }
            .padding()
            // The keyboard "Done" button can be attached here, no NavigationStack needed.
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isTextEditorFocused = false
                    }
                }
            }
            
            // This is the success message overlay.
            if showSuccessMessage {
                Text("Post Successful!")
                    .fontWeight(.bold)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSuccessMessage = false
                            }
                        }
                    }
            }
        }
    }
    
    private func postButtonTapped() {
        isTextEditorFocused = false
        errorMessage = nil
        isPosting = true

        let textToPost = postText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !textToPost.isEmpty else {
            errorMessage = "Cannot post an empty muse."
            isPosting = false
            return
        }
        
        guard textToPost != lastPostedText else {
            errorMessage = "You've already posted that."
            isPosting = false
            return
        }

        let promptRecord = CKRecord(recordType: "Prompt")
        
        CloudKitManager.shared.fetchCurrentUser { userRecord in
            if let userRecord = userRecord {
                let userRecordID = userRecord.recordID
                let usersName = userRecord["Username"] as? String
                let promptReference = CKRecord.Reference(recordID: CloudKitManager.shared.currentPromptID ?? promptRecord.recordID, action: .none)
                let record = CKRecord(recordType: "Post")
                record.setValuesForKeys([
                    "Prompt": promptReference,
                    "Text": textToPost,
                    "User": CKRecord.Reference(recordID: userRecordID, action: .none),
                    "usersName": usersName ?? "Anonymous",
                    "promptText": CloudKitManager.shared.currentPromptText ?? "THE DOME"
                ])
                
                CloudKitManager.shared.saveRecord(record: record)
                
                DispatchQueue.main.async {
                    self.lastPostedText = textToPost
                    self.postText = ""
                    self.isPosting = false
                    withAnimation {
                        self.showSuccessMessage = true
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Could not post. Please sign in."
                    self.isPosting = false
                }
            }
        }
    }
}

struct WritePost_Previews: PreviewProvider {
    static var previews: some View {
        WritePostView()
    }
}

