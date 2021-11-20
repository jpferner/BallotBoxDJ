//
//  RootView.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewModel = RootViewModel()
    
    var body: some View {
        if let room = viewModel.room {
            if room.hosting {
                HostSectionView()
            } else {
                
            }
        } else {
            HomeView()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
