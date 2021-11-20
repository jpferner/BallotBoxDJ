//
//  Observer.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

protocol PlaylistObserver: AnyObject {
    func onChanged(_ playlist: Playlist?)
}
