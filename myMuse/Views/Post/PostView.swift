//
//  PostView.swift
//  myMuse
//
//  Created by Tucker on 10/6/23.
//
//  Displays a post from a user

import SwiftUI


struct PostView: View {
    @State private var backgroundColor: Color = Color(red: 30 / 255, green: 125 / 255, blue: 159 / 255, opacity: 1.0)
    
    @State private var gradientColors: [Color] = ColorsManager.shared.foregroundGradient
    let textColor = ColorsManager.shared.textColorFor
    
    var profileImage: Image = Image("turtlerock")
    var username: String = "User Name"
    var postText: String?
    var promptText: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // User Header
            HStack {
                ProfileImageView(image: profileImage, size: 40)
                Text(username)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            // Main Post Content
            Text(postText ?? "This is where the post content will appear.")
                .font(.body)
                .lineSpacing(4)
            
            // Prompt Reference
            HStack(spacing: 8) {
                Image(systemName: "book.closed.fill")
                    .font(.caption)
                Text(promptText ?? "In response to a prompt")
                    .font(.caption)
                    .italic()
            }
            .foregroundStyle(.secondary)
            
        }
        .padding()
        .background(.ultraThinMaterial) // The key change for the glass effect
        .cornerRadius(20)
        .padding(.horizontal)
    }
    
        
}



struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(profileImage: Image("turtlerock"), username: "John Doe", postText: "Don't even think about it. Thats what I told her. I didn't want to regret it, but I did almost imediately.", promptText:("A cloudy day"))
    }
}
