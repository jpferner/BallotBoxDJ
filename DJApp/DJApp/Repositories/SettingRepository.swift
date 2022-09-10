//
//  SettingRepository.swift
//  DJApp
//
//  Created by user206471 on 4/3/22.
//

import Foundation

class SettingRepository {
    @Published var settings: SettingEntry = SettingEntry(displayName: "Settings", setting: .group(entries: [SettingEntry(displayName: "Colors", setting: .group(entries: [])), SettingEntry(displayName: "Host Settings", setting: .group(entries: [SettingEntry(name: "Allow Changing Votes", displayName: "Allow Changing Votes", setting: .toggle(value: false)), SettingEntry(name: "Post Votes", displayName: "Post Votes in Chat", setting: .toggle(value: false))]))]))
}
