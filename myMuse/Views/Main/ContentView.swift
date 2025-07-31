//
//  ContentView.swift
//  myMuse
//
//  Created by Tucker on 10/6/23.
//

import SwiftUI



struct ContentView: View {
    @State private var isPresentingSecondView = false
    
    // colors
    //@State private var backgroundColor: Color = Color(red: 5 / 255, green: 54 / 255, blue: 80 / 255, opacity: 1.0)
    //@State private var backgroundColor: Color = Color(red: 30 / 255, green: 125 / 255, blue: 159 / 255, opacity: 1.0)
    // Elephant
    @State private var highGradient: Color = Color(red: 30 / 255, green: 50 / 255, blue: 83 / 255, opacity: 1.0)
    @State private var lowGradient: Color = Color(red: 7 / 255, green: 31 / 255, blue: 59 / 255, opacity: 1.0)
    
    @State private var gradientColors: [Color] = [
        Color(red: 30 / 255, green: 50 / 255, blue: 83 / 255, opacity: 1.0),
        Color(red: 7 / 255, green: 31 / 255, blue: 59 / 255, opacity: 1.0)
        ]
    let textColor = ColorsManager.shared.textColorFor
    
    var body: some View {
            
        
            // VSTACK
            VStack {
                // PROMPT VIEW populated from database
                header()
                //Text("My Muse")
                    
                
                   
                // SCROLLER populated with POST VIEWs from database
                PostList()
                    .background(LinearGradient(gradient: Gradient(colors: ColorsManager.shared.contrastColor), startPoint: .top, endPoint: .bottom))
                
                // FRAME VIEW post button, explore button, account button
                
              
                
               /* Button("Post") {
                                isPresentingSecondView.toggle()
                        }
                        .sheet(isPresented: $isPresentingSecondView) {
                                    WritePost(isPresented: $isPresentingSecondView)
                            }*/
                NavBar()
                    
                    
                
                
                
            }
        
            .background(LinearGradient(gradient: Gradient(colors: ColorsManager.shared.backgroundGradient), startPoint: .top, endPoint: .bottom))
                
                    
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
