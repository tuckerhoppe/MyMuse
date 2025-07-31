//
//  Model.swift
//  myMuse
//
//  Created by Tucker on 11/10/23.
//

import Foundation
import CloudKit

@MainActor
class Model: ObservableObject {
    private var db = CKContainer.default().publicCloudDatabase
    
    func addPost(post: Post) async throws {
        // db.save(post.record)
    }
}
