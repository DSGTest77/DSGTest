//
//  EventWorker.swift
//  YashwanthAdirala-Events
//
//  Created by Adirala, Yashwanth Kumar Reddy on 5/20/22.
//

import Foundation

class EventWorker: APIServiceProtocol {
    
    /// Fetches list of all events
    /// - Parameters:
    ///   - url: URL
    ///   - completionHandler: completion handler to execute when request is completed by API
    func getEventsData(with url: URL?, completionHandler: @escaping (Any) -> Void) {
        guard let parsedUrl = url else {
            return
        }
        let task = URLSession.shared.dataTask(with: parsedUrl) { data, _, error in
            if let error = error {
                print("Error with fetching event data: \(error)")
                return
            }
            if let jsonData = data, let eventData = try? JSONDecoder().decode(Events.self, from: jsonData) {
                completionHandler(eventData)
            }
        }
        task.resume()
    }
}
