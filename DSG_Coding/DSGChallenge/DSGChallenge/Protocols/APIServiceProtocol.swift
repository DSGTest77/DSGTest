//
//  Protocol.swift
//  YashwanthAdirala-Events
//
//  Created by Adirala, Yashwanth Kumar Reddy on 5/20/22.
//

import Foundation

/// Protocol to fetch data from API
protocol APIServiceProtocol {
    func getEventsData(with url: URL?, completionHandler: @escaping (Any) -> Void)
}
