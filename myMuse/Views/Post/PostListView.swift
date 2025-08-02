//
//  PostList.swift
//  myMuse
//
//  Created by Tucker on 10/21/23.
//
import SwiftUI
import CloudKit
import Combine

struct PostListView: View {
    // We will manage the data directly in this view.
    @State private var posts: [CKRecord] = []
    @State private var promptText: String = "Loading Prompt..."
    
    // This property determines which feed to show.
    var isHomeView: Bool
    
    var body: some View {
        // We use a conditional check to show a loading state.
        if isHomeView && posts.isEmpty {
            ProgressView()
                .onAppear(perform: fetchData) // Use a simple onAppear to load data.
        } else {
            // Once data is loaded, show the content.
            ScrollView {
                VStack(spacing: 16) {
                    if isHomeView {
                        headerView()
                        
                        PromptView(promptText: promptText)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                            .padding(.horizontal)
                    }

                    ForEach(posts, id: \.recordID) { post in
                        let postText = post["Text"] as? String
                        let usersName = post["usersName"] as? String
                        let promptText = post["promptText"]as? String
                        
                        PostView(username: usersName ?? "Anonymous", postText: postText, promptText: promptText)
                    }
                }
                .padding(.vertical)
            }
            .scrollIndicators(.hidden)
            // This is the key: it listens for the "new post" signal and refreshes the data.
            .onReceive(CloudKitManager.shared.postDidSave) { _ in
                if isHomeView {
                    print("New post detected, refreshing home feed...")
                    fetchData()
                }
            }
            // Load data when the view first appears.
            .onAppear(perform: fetchData)
        }
    }

    private func fetchData() {
        if isHomeView {
            // Fetch data for the Home feed
            if let currentPrompt = CloudKitManager.shared.currentPromptText {
                self.promptText = currentPrompt
                CloudKitManager.shared.fetchPosts(withPromptText: currentPrompt) { fetchedPosts in
                    DispatchQueue.main.async {
                        self.posts = fetchedPosts
                    }
                }
            }
        } else {
            // Fetch data for the User Profile feed
            if let currentUserRecordID = CloudKitManager.shared.currentUserRecordID {
                CloudKitManager.shared.fetchUserPosts(forUser: currentUserRecordID) { fetchedPosts in
                    DispatchQueue.main.async {
                        self.posts = fetchedPosts
                    }
                }
            }
        }
    }
}



struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostListView(isHomeView: true)
    }
}
