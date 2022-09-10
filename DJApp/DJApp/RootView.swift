//
//  RootView.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import SwiftUI

struct BackgroundColorStyle: ViewModifier {
    var colors = [Color(hex: "#327846"), Color(hex: "#97a2dd"), Color(hex: "#8400ff"), Color(hex: "#e8657f"), Color(hex: "#ff8f43")]

    func body(content: Content) -> some View {
        return content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
          //  .background(colors[2])
            .foregroundColor(colors[2])
            .accentColor(.black)
            .font(Font.system( size: 30).bold())
            
            
            
          //  .background(AngularGradient(colors: [colors[2], colors[3], colors[0], colors[2]], center: .center))
            //.background(LinearGradient(colors: [colors[3], colors[0], colors[2], colors[1], colors[4]], startPoint: .topTrailing, endPoint: .bottomLeading))
        //    .background(LinearGradient(colors: [colors[0], colors[2], colors[3]], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct RootView: View {
    @StateObject var viewModel = RootViewModel()
    
    var body: some View {
        VStack() {
            if let room = viewModel.room {
                if room.hosting {
                    HostSectionView()
                } else {
                    GuestSectionView()
                }
            } else {
                HomeView()
                
            
            }
        }
      //  .frame(width: .infinity, height: .infinity)
   //     .modifier(BackgroundColorStyle())
  //      .background(LinearGradient(colors: [Color(hex: "#327846"), viewModel.colors[2], viewModel.colors[3]], startPoint: .bottomLeading, endPoint: .topTrailing))
    }
        
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
