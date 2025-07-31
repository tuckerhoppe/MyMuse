//
//  UserProfileView.swift
//  myMuse
//
//  Created by Tucker on 10/6/23.
//
//

import SwiftUI

struct UserProfileView2: View {
    var profileImage: Image = Image("turtlerock")
    var username: String = "John Doe"
    var bio: String = "Creativity is Intelligence having fun"
    var posts: Int = 17
    var streak: Int = 11
    var followers: Int = 12
    let textColor = Color.red
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                // Picture
                ProfileImageView(image: profileImage, size:75)
                
                VStack(alignment: .leading){
                    // User name
                    Text(username)
                        .foregroundColor(textColor)
                        .font(.headline)
                    
                    // Bio
                    Text(bio)
                        .foregroundColor(textColor)
                        .font(.caption)
                    
                }
                
            }
            
            HStack {
                
                // Posts
                Text(String(posts) + " Posts")
                    .foregroundColor(textColor)
                Spacer()
                // Streak
                Text(String(streak) + " Streak")
                    .foregroundColor(textColor)
                Spacer()
                // Followers
                Text(String(followers) + " Followers")
                    .foregroundColor(textColor)
            }
            
            NavBar()
            
        }
        
        
        
    }
    
}

struct UserProfileView2_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView2()
    }
}
