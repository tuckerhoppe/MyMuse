//
//  Post.swift
//  myMuse
//
//  Created by Tucker on 11/10/23.
//

import Foundation
import CloudKit


struct Post {
    var recordId: CKRecord.ID?
    var Text: String
    var userName: String
    var prompt: String
}
