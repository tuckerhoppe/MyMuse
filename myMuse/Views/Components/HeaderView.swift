//
//  header.swift
//  myMuse
//
//  Created by Tucker on 12/28/23.
//

import SwiftUI

struct header: View {
    @State private var symbolColor: Color = ColorsManager.shared.accentColor
    
    let textColor = ColorsManager.shared.textColorBack
    let imageSize: CGFloat = 275
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "moon.fill") // Replace with your image or system symbol
                    .foregroundColor(symbolColor) // Optional: Set the color of the image
                    .font(.largeTitle) // Optional: Set the font size of the image
                Spacer()
                VStack{
                    Image(systemName: "book.fill") // Replace with your image or system symbol
                        .foregroundColor(symbolColor) // Optional: Set the color of the image
                        .font(.title2)
                    Text("My Muse")
                        .foregroundColor(textColor)
                        .font(.system(size: 26, weight: .light, design: .serif))
                        .bold()
                
                }
                Spacer()
                Image(systemName: "moon.fill") // Replace with your image or system symbol
                    .foregroundColor(symbolColor) // Optional: Set the color of the image
                    .font(.largeTitle)
                    .rotationEffect(Angle.degrees(270))
                
                    
            }
        
            /*
            Image("muse3")
                .resizable()
                .frame(width: imageSize, height: imageSize)

                .clipShape(Circle())
                .overlay {
                    Circle().stroke(ColorsManager.shared.accentColor, lineWidth: 0)
                }
                */
                //.shadow(radius: 7)
            
                
        }
        
    }
}

struct header_Previews: PreviewProvider {
    static var previews: some View {
        header()
            
                }
}
