//
//  ColorListView.swift
//  DJApp
//
//  Created by user206471 on 12/27/21.
//

import SwiftUI

struct ColorListView: View {
    @StateObject var viewModel = ColorListViewModel()
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct ColorListView_Previews: PreviewProvider {
    static var previews: some View {
        ColorListView()
    }
}
