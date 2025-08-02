//
//  PostListViewModel.swift
//  myMuse
//
//  Created by Tucker Hoppe on 8/1/25.
//

import Foundation
import CloudKit
import Combine

// NOT USING ANYMORE 


//// This ViewModel will manage the data for your PostListView
//class PostListViewModel: ObservableObject {
//    @Published var posts: [CKRecord] = []
//    @Published var promptText: String = "Loading Prompt..."
//
//    private var cancellables = Set<AnyCancellable>()
//
//    init() {
//        // Observe the CloudKitManager for changes to the prompt
//        CloudKitManager.shared.$currentPromptText
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] newPrompt in
//                guard let newPrompt = newPrompt, !newPrompt.isEmpty else { return }
//                self?.promptText = newPrompt
//                self?.fetchPosts(for: newPrompt)
//            }
//            .store(in: &cancellables)
//        
//        // --- ADD THIS NEW SUBSCRIPTION ---
//        // This subscription listens for the "new post" signal
//        CloudKitManager.shared.postDidSave
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] in
//                print("ViewModel received new post signal. Refetching posts.")
//                guard let self = self, !self.promptText.isEmpty else { return }
//                // Re-fetch the posts for the current prompt
//                self.fetchPosts(for: self.promptText)
//            }
//            .store(in: &cancellables)
//        
//    }
//
//    func fetchPosts(for prompt: String) {
//        CloudKitManager.shared.fetchPosts(withPromptText: prompt) { fetchedPosts in
//            DispatchQueue.main.async {
//                self.posts = fetchedPosts
//            }
//        }
//    }
//}
