//
//  CloudKitManager.swift
//  myMuse
//
//  Created by Tucker on 12/6/23.
//

import Foundation
import CloudKit


class CloudKitManager {
    private let container: CKContainer
    private let publicDatabase: CKDatabase
    
    //singleton pattern: This allows an instance be shared throughout the app
    static let shared = CloudKitManager()
    // CURRENT USER
        var currentUserRecordID: CKRecord.ID? {
            didSet {
                saveCurrentUserRecordID(currentUserRecordID)
            }
        }

        var currentUsername: String? {
            didSet {
                saveCurrentUsername(currentUsername)
            }
        }

        var currentBio: String? {
            didSet {
                saveCurrentBio(currentBio)
            }
        }
    
    
    
    // CURRENT PROMPT
    var currentPrompt: CKRecord?
    var currentPromptID: CKRecord.ID?
    var currentPromptText: String?
    
    init() {
        container = CKContainer(identifier: "iCloud.myMuseDatabase")
        publicDatabase = container.publicCloudDatabase
        setCurrentPrompt()
        
        // SET Current USERS
        currentUserRecordID = loadCurrentUserRecordID()
        currentUsername = loadCurrentUsername()
        currentBio = loadCurrentBio()
    }
    
    // Save methods
        private func saveCurrentUserRecordID(_ recordID: CKRecord.ID?) {
            UserDefaults.standard.set(recordID?.recordName, forKey: "currentUserRecordID")
        }

        private func saveCurrentUsername(_ username: String?) {
            UserDefaults.standard.set(username, forKey: "currentUsername")
        }

        private func saveCurrentBio(_ bio: String?) {
            UserDefaults.standard.set(bio, forKey: "currentBio")
        }
    
    
    // Load methods
        private func loadCurrentUserRecordID() -> CKRecord.ID? {
            if let recordName = UserDefaults.standard.string(forKey: "currentUserRecordID") {
                return CKRecord.ID(recordName: recordName)
            }
            return nil
        }

        private func loadCurrentUsername() -> String? {
            return UserDefaults.standard.string(forKey: "currentUsername")
        }

        private func loadCurrentBio() -> String? {
            return UserDefaults.standard.string(forKey: "currentBio")
        }
    
    
    // UPDATES CURRENT USER
    func setCurrentUser(record: CKRecord) {
        currentUserRecordID = record.recordID
        currentUsername = record["Username"] as? String
        currentBio = record["Bio"] as? String
    }

    func signInAs(username: String, password: String, completion: @escaping (Bool, CKRecord?) -> Void) {
            let predicate = NSPredicate(format: "Username == %@", username)
            let query = CKQuery(recordType: "User", predicate: predicate)

            let queryOperation = CKQueryOperation(query: query)
            queryOperation.resultsLimit = 1

            queryOperation.recordFetchedBlock = { record in
                // Check if the fetched record's password matches the provided password
                if let storedPassword = record["Password"] as? String, storedPassword == password {
                    completion(true, record)
                } else {
                    completion(false, nil)
                }
            }

            queryOperation.queryCompletionBlock = { (_, error) in
                if let error = error {
                    print("Error signing in: \(error.localizedDescription)")
                    completion(false, nil)
                }
            }

            publicDatabase.add(queryOperation)
        }
    
    
    
    func fetchPostRecord(withSearchString searchString: String, completionHandler: @escaping (CKRecord?) -> Void) {
        // Create a predicate to filter records based on the search string
        let predicate = NSPredicate(format: "promptText == %@", searchString)
        
        // Create a CKQuery for the "Post" record type with the given predicate
        let query = CKQuery(recordType: "Prompt", predicate: predicate)
        
        // Perform the query on the default container
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            // Handle the query results
            if let error = error {
                // Handle the error
                print("Error hahaha: \(error.localizedDescription)")
                completionHandler(nil)
            } else {
                // Return the first matching record (or nil if none found)
                completionHandler(records?.first)
            }
        }
    }

   

    // Call the function and set the variable in the completion handler
    func setCurrentPrompt() {
        // Get the current date in the desired format
        //let currentDate = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let currentDate = dateFormatter.string(from: Date())
        
        print(currentDate)
        fetchPromptRecord(withSearchDate: currentDate) { (record, error) in
            if let record = record {
                self.currentPrompt = record
                self.currentPromptID = record.recordID
                self.currentPromptText = record["promptText"] as? String
                print("Hey, this is it:")
                print(self.currentPromptText)
            } else {
                // Handle the case when no matching record is found
                if let error = error {
                    print("Error fetching prompt record: \(error.localizedDescription)")
                } else {
                    print("No matching records found for today's date.")
                }
            }
        }
    }


    
    
    
    func fetchPosts(withPromptText promptText: String, completion: @escaping ([CKRecord]) -> Void) {
        // Create a predicate to filter records based on the promptText
        let predicate = NSPredicate(format: "promptText == %@", promptText)
        
        // Create a CKQuery for the "Post" record type with the given predicate
        let query = CKQuery(recordType: "Post", predicate: predicate)
        
        publicDatabase.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                print("Error fetching posts from CloudKit: \(error.localizedDescription)")
                completion([])
            } else if let records = records {
                completion(records)
            }
        }
    }

    
    // FETCHES POSTS BASED ON USER
    func fetchUserPosts(forUser userRecordID: CKRecord.ID, completion: @escaping ([CKRecord]) -> Void) {
        let predicate = NSPredicate(format: "User == %@", CKRecord.Reference(recordID: userRecordID, action: .none))
        let query = CKQuery(recordType: "Post", predicate: predicate)
        
        publicDatabase.perform(query, inZoneWith: nil) {records, error in
            if let error = error {
                print("Error fetching posts from CloudKit: \(error.localizedDescription)")
                completion([])
            } else if let records = records {
                completion(records)
            }
            
        }
    }
    
    func fetchPromptRecord(withSearchDate searchDate: String, completionHandler: @escaping (CKRecord?, Error?) -> Void) {
        // Convert search date to NSDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let date = dateFormatter.date(from: searchDate) else {
            print("Invalid date format.")
            completionHandler(nil, nil)
            return
        }
        let searchNSDate = date as NSDate
        
        // Create a predicate to filter records based on the search date
        let predicate = NSPredicate(format: "date >= %@ && date < %@", searchNSDate, Calendar.current.date(byAdding: .day, value: 1, to: date) as NSDate? ?? NSDate())
        
        // Create a CKQuery for the "Prompt" record type with the given predicate
        let query = CKQuery(recordType: "Prompt", predicate: predicate)
        
        // Perform the query on the default container
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            // Handle the query results
            if let error = error {
                // Handle the error
                print("Error fetching prompt records: \(error.localizedDescription)")
                completionHandler(nil, error)
            } else {
                // Check if any records were found
                if let firstRecord = records?.first {
                    // Return the first matching record
                    print("Found prompt record: \(firstRecord)")
                    completionHandler(firstRecord, nil)
                } else {
                    // No matching records found
                    print("No matching records found for today's date.")
                    completionHandler(nil, nil)
                }
            }
        }
    }


    
/*
    func fetchPostRecord(withSearchString searchString: String, completionHandler: @escaping (CKRecord?, Error?) -> Void) {
        // Create a predicate to filter records based on the search string
        let predicate = NSPredicate(format: "promptText == %@", searchString)
        
        // Create a CKQuery for the "Post" record type with the given predicate
        let query = CKQuery(recordType: "Post", predicate: predicate)
        
        // Perform the query on the default container
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            // Handle the query results
            if let error = error {
                // Handle the error
                completionHandler(nil, error)
            } else {
                // Check if any records were found
                if let firstRecord = records?.first {
                    // Return the first matching record
                    completionHandler(firstRecord, nil)
                } else {
                    // No matching records found
                    completionHandler(nil, nil)
                }
            }
        }
    }
*/
    
    func fetchCurrentUser(completion: @escaping (CKRecord?) -> Void) {
        guard let currentUserRecordID = currentUserRecordID else {
            completion(nil)
            return
        }
        
        let fetchOperation = CKFetchRecordsOperation(recordIDs: [currentUserRecordID])
        fetchOperation.qualityOfService = .userInteractive
        
        fetchOperation.fetchRecordsCompletionBlock = { records, error in
            if let error = error {
                print("Error fetching current user from CloudKit: \(error.localizedDescription)")
                completion(nil)
            } else {
                let currentUserRecord = records?[currentUserRecordID]
                completion(currentUserRecord)
            }
        }
        
        CloudKitManager.shared.publicDatabase.add(fetchOperation)
    }



    
    // SAVES RECORDS
    func saveRecord(record: CKRecord, recordIsUser: Bool = false) {
        publicDatabase.save(record) { (savedRecord, error) in
            if let error = error {
                print("Error saving record: \(error)")
            } else if recordIsUser {
                // USER RECORD
                print("User Record saved successfully: \(savedRecord?.recordID.recordName ?? "N/A")")
                
                // Save the just created user as current user
                if let userRecord = savedRecord {
                    print("Setting current user ID:", userRecord["Username"] ?? "not here")
                    self.setCurrentUser(record: userRecord)
                    
                    // Print the current user ID immediately after setting
                    print("Current user ID after setting:", self.currentUserRecordID ?? "not here")
                    
                    // You can also perform additional actions here after a successful save
                }
            } else {
                // POST RECORD
                print("Post Record saved successfully: \(savedRecord?.recordID.recordName ?? "N/A")")
            }
        }
    }

    
}
