//
//  PromptView.swift
//  myMuse
//
//  Created by Tucker on 10/6/23.
//
//  Displays daily prompt text, and maybe a post button

import SwiftUI

struct PromptView: View {
    var promptText: String = "This is a placeholder for the prompt of the day"
    
    @State private var gradientColors: [Color] = ColorsManager.shared.foregroundGradient
    let textColor = ColorsManager.shared.textColorFor
    var body: some View {
        
        VStack(alignment:.leading, spacing: 0){
            // Prompt
            HStack {
                Text("Today's Prompt:")
                    .foregroundColor(textColor)
                    .bold()
                
                Spacer()
            }
            
            
            Text(promptText)
                .foregroundColor(textColor)
            
            // Add Button
            //NavigationLink(destination: WritePost()) {
                // add a plus symbol
                //Circle()
                    //.frame(width: 35, height: 35)
           // }
            
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .bottom))
        .frame(width: 300)
        .cornerRadius(20.0)
        
    }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        PromptView(promptText: "A mysterious and unexpected discovery that changes a life forever")
    }
}
