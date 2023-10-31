//
//  SettingsViewModel.swift
//  DJApp
//
//  Created by user206471 on 12/2/21.
//

import Foundation

class SettingsViewModel: ObservableObject {
        
    @Published var entry: SettingEntry
    
//    @Published var settings: [Bool]?
    
    init(entry: SettingEntry) {

  //  init(entry: SettingEntry = SettingEntry(displayName: "Settings", setting: .group(entries: [SettingEntry(displayName: "Colors", setting: .group(entries: [])), SettingEntry(displayName: "Host Settings", setting: .group(entries: [SettingEntry(name: "Allow Changing Votes", displayName: "Allow Changing Votes", setting: .toggle(value: false)), SettingEntry(name: "Post Votes", displayName: "Post Votes in Chat", setting: .toggle(value: false))]))])))
   // {
  //      entry = SettingEntry(displayName: "Settings", setting: .group(entries: [SettingEntry(displayName: "Colors", setting: .group(entries: [])), SettingEntry(displayName: "Host Settings", setting: .group(entries: [SettingEntry(name: "Allow Changing Votes", displayName: "Allow Changing Votes", setting: .toggle(value: false)), SettingEntry(name: "Post Votes", displayName: "Post Votes in Chat", setting: .toggle(value: values[0]))]))]))
    
        self.entry = entry
        
    }
}
