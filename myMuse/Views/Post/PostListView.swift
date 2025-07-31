//
//  PostList.swift
//  myMuse
//
//  Created by Tucker on 10/21/23.
//

import SwiftUI
import CloudKit

struct PostList: View {
    var homeview: Bool = true
    @State private var posts: [CKRecord] = []
    //private let cloudKitManager = CloudKitManager()
    
    // Include a way to make this configurable
    var body: some View {
       
            
            /*List(posts, id: \.recordID) { post in
                //let promptText = post["Prompt"] as? String
                let postText = post["Text"] as? String
                let usersName = post["usersName"] as? String
                let promptText = post["promptText"] as? String
                
                PostView(username: usersName ?? "Anonymous", postText: postText, promptText: promptText)
            }*/
            ScrollView {
                if homeview {
                    PromptView(promptText: CloudKitManager.shared.currentPromptText ?? "nothing today JDKLSJf")
                }
                    
                    ForEach(posts, id: \.recordID) { post in
                        let postText = post["Text"] as? String
                        let usersName = post["usersName"] as? String
                        let promptText = post["promptText"] as? String
                        
                        PostView(username: usersName ?? "Anonymous", postText: postText, promptText: promptText)
                            //.padding() // Add padding between PostViews
                    }
                }
            .onAppear {
                if homeview {
                    // This part for the home feed is likely fine
                    CloudKitManager.shared.fetchPosts(withPromptText: CloudKitManager.shared.currentPromptText ?? "Test Prompt") { fetchedPosts in
                        self.posts = fetchedPosts
                    }
                } else {
                    // --- REVISED CODE FOR USER PROFILE ---
                    // Safely unwrap the optional user ID
                    if let currentUserRecordID = CloudKitManager.shared.currentUserRecordID {
                        // Only fetch posts if a user ID exists
                        CloudKitManager.shared.fetchUserPosts(forUser: currentUserRecordID) { fetchedPosts in
                            DispatchQueue.main.async {
                                self.posts = fetchedPosts
                            }
                        }
                    }
                    // If there's no user ID, it will now safely do nothing and show an empty list.
                    // --- END REVISED CODE ---
                }
            }
                
            
            
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
