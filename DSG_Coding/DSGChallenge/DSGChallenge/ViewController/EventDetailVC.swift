//
//  EventDetailVC.swift
//  YashwanthAdirala-Events
//
//  Created by Adirala, Yashwanth Kumar Reddy on 5/20/22.
//

import UIKit

class EventDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var eventDetailTableView: UITableView!
    var event: EventItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension EventDetailVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventDetailCell") as? EventDetailCell else {
            return UITableViewCell()
        }
        if let eventItem = event {
            cell.populateData(eventObj: eventItem)
        }
        return cell
    }
}
