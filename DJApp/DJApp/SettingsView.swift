//
//  SettingsView.swift
//  DJApp
//
//  Created by user206471 on 12/2/21.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel: SettingsViewModel
    
    // @Binding var toggleValues: [String: Bool]
    
    var isRoot: Bool
    @Binding var isShowing: Bool
    
    
    
//    ForEach(viewModel.settings.groups) {
//
//    }
    init(model: SettingsViewModel, root: Bool, showing: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: model)
        self.isRoot = root
        self._isShowing = showing
    }
    
    var body: some View {

        
        
        switch viewModel.entry.setting {
        case .group(var entries):
            if isRoot {
                NavigationView {
                    
                    
                    
                    SettingsListView(isShowing: $isShowing, name: viewModel.entry.displayName, entries: entries)
//                        .navigationBarItems(trailing:
//                                                Button(action:  { isShowing.toggle()}) {
//                            Text("Close")
//
//                        )
                }
                
            }
            else {
                SettingsListView(isShowing: $isShowing, name: viewModel.entry.displayName, entries: entries)
            }
            
        default:
            EmptyView()
        }
        
        
    }
}

struct ToggleView: View {
    
    
    
    @Binding var value: Bool
    var displayName: String
    
    var body: some View {
        Toggle(isOn: $value) {
            Text(displayName)
        }
    }
}

struct SettingsListView: View {
    @Binding var isShowing: Bool
//    @Binding var bindingVal: Bool
    var name: String
     var entries: [SettingEntry]
    

    
    var body: some View {
        List {
            
            ForEach(entries, id: \.displayName) { entry in
                switch entry.setting {
                case .group(let groupEntries):
                    NavigationLink(destination: SettingsView(model: SettingsViewModel(entry: entry), root: false, showing: $isShowing)) {
                        Text(entry.displayName)
                    }
                case .toggle(var $value):
                        
                    Toggle(isOn: $value) {
                        Text(entry.displayName)
                    }
                  //  ToggleView(setting: , displayName: entry.displayName)
//
                }
                
                
            }
            
        }
        .navigationTitle(name)
    }
}

//struct SettingsView_Previews: PreviewProvider {
  //  static var previews: some View {
   //     SettingsView(model: SettingsViewModel(), root: true, showing: Binding<Bool>(get: {true}, set: {_ in}))
   // }
//}
