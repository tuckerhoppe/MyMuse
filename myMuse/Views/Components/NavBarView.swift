//
//  NavBar.swift
//  myMuse
//
//  Created by Tucker on 11/10/23.
//

import SwiftUI

struct NavBar: View {
    @State private var symbolColor: Color = ColorsManager.shared.accentColor
    
    @State private var isPresentingHomeView = false
    @State private var isPresentingWriteView = false
    @State private var isPresentingProfileView = false
    @State private var isPresentingSignInView = false
    
    var body: some View {
        
        /*
        NavigationView {
            NavigationLink(destination: UserProfileView()) { ProfileImage(image: Image("turtlerock")) }
            
            // Home
            NavigationLink(destination: PostView()) { Text("Home") }
            
            // Post
            NavigationLink(destination: UserProfileView()) { ProfileImage(image: Image("turtlerock")) }
            
            
            
        }*/
        HStack(alignment: .center){
            
            Spacer()
            // Home Button
            Button(action: {
                        // Action to perform when the image is clicked
                isPresentingHomeView.toggle()
                    }) {
                        //ProfileImage(image: Image("turtlerock"))
                        Image(systemName: "house.fill") // Replace with your image or system symbol
                            .foregroundColor(symbolColor) // Optional: Set the color of the image
                            .font(.largeTitle) // Optional: Set the font size of the image
                    }
                    .fullScreenCover(isPresented: $isPresentingHomeView) {
                                ContentView()
                            
                            }
                            
                     Spacer()
                    
                            
            
            // Write Post Button
            Button(action: {
                        // Action to perform when the image is clicked
                        isPresentingWriteView.toggle()
                        
                    }) {
                        //ProfileImage(image: Image("turtlerock"))
                        Image(systemName: "pencil") // Replace with your image or system symbol
                            .foregroundColor(symbolColor) // Optional: Set the color of the image
                            .font(.largeTitle) // Optional: Set the font size of the image
                    }
                    .fullScreenCover(isPresented: $isPresentingWriteView) {
                        WritePostView()
                            }
            
            Spacer()
            
            // Profile Button
            Button(action: {
                        // Action to perform when the image is clicked
                        
                        isPresentingProfileView.toggle()
                    }) {
                        //ProfileImage(image: Image("turtlerock"))
                        Image(systemName: "person.fill") // Replace with your image or system symbol
                            .foregroundColor(symbolColor) // Optional: Set the color of the image
                            .font(.largeTitle) // Optional: Set the font size of the image
                    }
                    .fullScreenCover(isPresented: $isPresentingProfileView) {
                                // Call current USER and put it in there bb
                        UserProfileView(username: CloudKitManager.shared.currentUsername ?? "Anonymous", bio: CloudKitManager.shared.currentBio ?? "NO Bio")
                        
                        }
            
            Spacer()
            
            // Sign in Button
            Button(action: {
                        // Action to perform when the image is clicked
                isPresentingSignInView.toggle()
                    }) {
                        //ProfileImage(image: Image("turtlerock"))
                        Image(systemName: "star.fill") // Replace with your image or system symbol
                            .foregroundColor(symbolColor) // Optional: Set the color of the image
                            .font(.largeTitle) // Optional: Set the font size of the image
                    }
                    .fullScreenCover(isPresented: $isPresentingSignInView) {
                                SignInView()
                            
                            }
                            
                     Spacer()

            
        }
        .frame(minHeight: 40) // Adjust the minimum height to control the size
        .border(Color.gray, width: 3) // Add a border for visual separation
        .padding()
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
