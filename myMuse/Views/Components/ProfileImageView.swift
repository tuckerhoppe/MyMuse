//
//  ProfileImage.swift
//  myMuse
//
//  Created by Tucker on 10/20/23.
//

import SwiftUI

struct ProfileImageView: View {
    var image: Image
    var size: CGFloat = 50

    var body: some View {
        image
            .resizable()
            .frame(width: size, height: size)

            .clipShape(Circle())
            .overlay {
                Circle().stroke(ColorsManager.shared.textColorFor, lineWidth: 4)
            }
            .shadow(radius: 7)
        
        }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(image: Image("turtlerock"))
    }
}
