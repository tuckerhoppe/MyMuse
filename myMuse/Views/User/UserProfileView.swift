//
//  UserProfileView.swift
//  myMuse
//
//  Created by Tucker on 10/6/23.
//
//

import SwiftUI

struct UserProfileView: View {
    // State variable to control the sheet
    @State private var isShowingSignIn = false
    
    var profileImage: Image = Image("turtlerock")
    var username: String = "John Doe"
    var bio: String = "Creativity is Intelligence having fun"
    var posts: Int = 17
    var streak: Int = 11
    var followers: Int = 12
    
    let textColor = ColorsManager.shared.textColorBack
    
    var body: some View {
        
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Profile Header
                    VStack(spacing: 16) {
                        ProfileImageView(image: profileImage, size: 80)
                        
                        VStack {
                            Text(username)
                                .font(.title2)
                                .fontWeight(.bold)
                            Text(bio)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        
                        Divider()
                        
                        // Improved Stat Display
                        HStack {
                            Spacer()
                            StatView(value: posts, label: "Posts")
                            Spacer()
                            StatView(value: streak, label: "Streak")
                            Spacer()
                            StatView(value: followers, label: "Followers")
                            Spacer()
                        }
                        
                        
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    // The User's Post List
                    PostListView(isHomeView: false)
                }
                .padding(.top)
                
            }
            .navigationTitle("Profile") // Sets the title of the navigation bar
            .navigationBarTitleDisplayMode(.inline)
            // Add the Button to the toolbar
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Sign In / Out") {
                        isShowingSignIn.toggle()
                    }
                }
            }
            .sheet(isPresented: $isShowingSignIn) {
                SignInView()
            }
        }
    }
    
}



// A small, reusable view for displaying a single statistic
struct StatView: View {
    let value: Int
    let label: String

    var body: some View {
        VStack {
            Text(String(value))
                .font(.headline)
                .fontWeight(.bold)
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
