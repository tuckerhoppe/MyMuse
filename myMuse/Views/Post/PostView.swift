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
        
        // Use GeometryReader to get the screen width
        
        // VSTACK
        VStack(alignment: .leading) {
            // User picture User name
            HStack {
                ProfileImageView(image: profileImage)
                    //.image.resizable()
                    //.frame(width: 50, height: 50)
            
                Text(username)
                    .foregroundColor(textColor)
                    .onTapGesture {
                                            // Handle tap gesture on username
                                            print("Username tapped!")
                                        }
                Spacer()
            }
            // Text
            Text(postText ?? "Default Post")
                .font(.caption)
                .foregroundColor(textColor)
                //.fixedSize(horizontal: false, vertical: true)
                
                
            // view prompt button
            Text(promptText ?? "Default Prompt")
                .font(.caption2)
                .foregroundColor(textColor)
                .italic()
                
                
                
            
                
            // like & comment buttons
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom))
        .frame(width: 300)
        .cornerRadius(20.0)
        
        
        
        //.padding(.horizontal)
        
    }
    
        
}



struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(profileImage: Image("turtlerock"), username: "John Doe", postText: "Don't even think about it. Thats what I told her. I didn't want to regret it, but I did almost imediately.", promptText:("A cloudy day"))
    }
}
