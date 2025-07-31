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
        
        VStack(alignment:.leading, spacing: 8){
            // Title Header
            HStack {
                Image(systemName: "lightbulb.fill") // icon for visual interest
                    .foregroundStyle(ColorsManager.shared.accentColor)
                
                Text("Today's Prompt:")
                    .fontWeight(.bold)
                
                Spacer()
            }
            .font(.subheadline)
            
            
            Text(promptText)
                .font(.title3) // Makes the prompt text stand out more
                .fontWeight(.semibold)
                .lineLimit(3) // Prevents extremely long prompts
            
            // TODO: Add Button
            //NavigationLink(destination: WritePost()) {
                // add a plus symbol
                //Circle()
                    //.frame(width: 35, height: 35)
           // }
            
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .cornerRadius(20.0)
        .padding(.horizontal)
        
    }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        PromptView(promptText: "A mysterious and unexpected discovery that changes a life forever")
    }
}
