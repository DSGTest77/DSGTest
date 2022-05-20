//
//  EventModel.swift
//  YashwanthAdirala-Events
//
//  Created by Adirala, Yashwanth Kumar Reddy on 5/20/22.
//

import Foundation
import UIKit

struct Events: Codable {
    let events: [EventsData]
}

struct EventsData: Codable {
    var id: Int
    var title: String
    var datetime_local: String
    var venue: Location
    var performers: [Performer]
}

struct Performer: Codable {
    var image: String
}

struct Location: Codable {
    var display_location: String
}

struct EventItem {
    var id: Int
    var title: String
    var location: String
    var date: String
    var image: UIImage
    var imageUrl: String
    var liked: Bool
}
