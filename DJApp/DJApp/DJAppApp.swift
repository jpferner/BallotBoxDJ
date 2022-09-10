//
//  DJAppApp.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import SwiftUI
import UIKit

private struct RoomServiceKey: EnvironmentKey {
    static let defaultValue: RoomService = ServiceLocator.roomService
}

extension EnvironmentValues {
    var roomService: RoomService {
        get {
            self[RoomServiceKey.self]
        }
        set {
            self[RoomServiceKey.self] = newValue
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ServiceLocator.spotifyAPI.handleOpenURL(app, open: url, options: options)
        return true
    }
}


@main
struct DJAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .onOpenURL { url in
                    ServiceLocator.spotifyAPI.handleOpenURL(UIApplication.shared, open: url)
                }
        }
    }
}
