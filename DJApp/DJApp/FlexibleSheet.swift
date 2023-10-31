//
//  FlexibleSheet.swift
//  DJApp
//
//  Created by user206471 on 12/29/21.
//

import SwiftUI

enum SheetMode {
    case none
    case quarter
    case half
    case full
}

struct FlexibleSheet<Content: View>: View {
    
    
    let content: () -> Content
    var sheetMode: Binding<SheetMode>
    
    init(sheetMode: Binding<SheetMode>, @ViewBuilder content: @escaping () -> Content) {
        
        self.content = content
        self.sheetMode = sheetMode
    }
    
    private func calculateOffset() -> CGFloat {
        switch sheetMode.wrappedValue {
        case .none:
            return UIScreen.main.bounds.height
        case .quarter:
            return UIScreen.main.bounds.height - 200
        case .half:
            return UIScreen.main.bounds.height/2
        case.full:
            return 0
        }
    }
    
    var body: some View {
        content()
            .offset(y: calculateOffset())
            .edgesIgnoringSafeArea(.all)
    }
}

struct FlexibleSheet_Previews: PreviewProvider {
    static var previews: some View {
        FlexibleSheet(sheetMode: .constant(.none)) {
            VStack {
                Text("Hello World")
            }
        }
    }
}
