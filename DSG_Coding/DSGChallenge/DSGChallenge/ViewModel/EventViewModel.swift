//
//  EventViewModel.swift
//  YashwanthAdirala-Events
//
//  Created by Adirala, Yashwanth Kumar Reddy on 5/20/22.
//

import Foundation
import UIKit

class EventViewModel {
    var eventListData = [EventItem]()
    var eventListFiltered = [EventItem]()
    let apiService: APIServiceProtocol
    
    init( apiService: APIServiceProtocol = EventWorker()) {
        self.apiService = apiService
    }
    
    func getEventData(completionHandler : @escaping() -> Void) {
        self.apiService.getEventsData(with: URL(string:"https://api.seatgeek.com/2/events?client_id=MjcwNTE3OTR8MTY1Mjk2Nzc5MC4yODI0NDQy&q=swift")) { [weak self] data in
            if let weakSelf = self, let parsedData = data as? Events {
                for data in parsedData.events {
                    self?.eventListData.append(EventItem(id: data.id, title: data.title, location: data.venue.display_location, date: data.datetime_local, image: UIImage(), imageUrl: data.performers[0].image, liked: false))
                }
                weakSelf.eventListFiltered = weakSelf.eventListData
            }
            
            completionHandler()
        }
    }
    
    func filterData(searchText: [Substring]) {
        self.eventListFiltered.removeAll()
        for event in eventListData {
            for token in searchText {
                if (event.title.contains(token)) {
                    self.eventListFiltered.append(event);
                    break;
                }
            }
        }
        if eventListFiltered.count == 0 {
            eventListFiltered = eventListData
        }
    }
}
