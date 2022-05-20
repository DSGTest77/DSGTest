//
//  EventDetailCell.swift
//  YashwanthAdirala-Events
//
//  Created by Adirala, Yashwanth Kumar Reddy on 5/20/22.
//

import UIKit

class EventDetailCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDateLbl: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventFavButton: UIButton!
    var liked: Bool = false
    let defaults = UserDefaults.standard
    var eventItem: EventItem? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateData(eventObj : EventItem) {
        self.eventItem = eventObj
        let dateFormatter = DateFormatter();
        titleLabel.text = eventObj.title
        eventLocationLabel.text = eventObj.location
        eventDateLbl.text = returnProperDate(date: dateFormatter.date(from: eventObj.date))
        eventImage.imageFromServerURL(urlString: eventObj.imageUrl)
        if let item = self.eventItem {
            if defaults.bool(forKey: "\(item.id)") {
                setToLiked ()
                liked = true
            }
        }
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        toggleLikeButton()
    }
    
    func toggleLikeButton () {
        liked.toggle()
        eventFavButton?.setImage((self.liked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")), for: .normal)
        eventFavButton?.tintColor = self.liked ? .red : .black
        if let item = self.eventItem{
            if  self.liked {
                defaults.set(true, forKey: "\(item.id)")
            } else {
                defaults.removeObject(forKey: "\(item.id)")
            }
        }
    }
    
    func setToLiked () {
        eventFavButton?.setImage( UIImage(systemName: "heart.fill"), for: .normal)
        eventFavButton?.tintColor = .red
        eventFavButton?.setNeedsLayout()
        
    }
    
    func returnProperDate(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, d MMM yyyy h:mm a"
        return dateFormatter.string(from: date ?? Date())
    }
}
