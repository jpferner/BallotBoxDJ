//
//  Setting.swift
//  DJApp
//
//  Created by user206471 on 12/18/21.
//

import Foundation
import SwiftUI

enum Setting {
    case group (entries: [SettingEntry])
    case toggle (value: Binding<Bool>)
}

struct SettingEntry { 
    var name: String? = nil
    var displayName: String
    var setting: Setting
    
}

