//
//  RoomObserver.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import Foundation

protocol RoomObserver: AnyObject {
    func onChanged(_ room: Room?)
}
