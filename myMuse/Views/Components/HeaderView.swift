//
//  header.swift
//  myMuse
//
//  Created by Tucker on 12/28/23.
//

import SwiftUI

struct headerView: View {
    @State private var symbolColor: Color = ColorsManager.shared.accentColor
    
    let textColor = ColorsManager.shared.textColorBack
    let imageSize: CGFloat = 275
    
    var body: some View {
        VStack(spacing: 4){
            
            Image(systemName: "book.fill")
                .font(.system(size:22)) // Sets a specific size for the icon
                .foregroundStyle(ColorsManager.shared.accentColor)
            
            Text("My Muse")
                .font(.system(size: 28, weight: .regular, design: .serif))
                //.foregroundStyle(ColorsManager.shared.textColorFor)
                
        }
        .padding(.top) // Add some outer paddingso there's space at the top
        
    }
}

struct header_Previews: PreviewProvider {
    static var previews: some View {
        headerView()
            
                }
}
