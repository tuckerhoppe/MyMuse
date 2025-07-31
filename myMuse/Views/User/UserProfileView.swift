//
//  UserProfileView.swift
//  myMuse
//
//  Created by Tucker on 10/6/23.
//
//

import SwiftUI

struct UserProfileView: View {
    var profileImage: Image = Image("turtlerock")
    var username: String = "John Doe"
    var bio: String = "Creativity is Intelligence having fun"
    var posts: Int = 17
    var streak: Int = 11
    var followers: Int = 12
    
    let textColor = ColorsManager.shared.textColorBack
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                // Enlarged Picture
                ProfileImageView(image: profileImage, size:75)
                
                VStack(alignment: .leading){
                    // User name
                    Text(username)
                        .foregroundColor(textColor)
                        .font(.headline)
                    
                    // Bio or quote
                    Text(bio)
                        .foregroundColor(textColor)
                        .font(.caption)
                    
                }
                
            }
            
            HStack {
                // followers? With a small base, this might be unnessasacry and counterintuitive
                Text(String(posts) + " Posts")
                    .foregroundColor(textColor)
                // Streak?
                Text(String(streak) + " Streak")
                    .foregroundColor(textColor)
                
                Text(String(followers) + " Followers")
                    .foregroundColor(textColor)
            }
            
            
            // posts populated from user's database
            // Maybe I should add a posts view?
            PostListView(homeview: false)
            NavBar()
        }
        .background(LinearGradient(gradient: Gradient(colors: ColorsManager.shared.backgroundGradient), startPoint: .top, endPoint: .bottom))
        
        
    }
    
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
