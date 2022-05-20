//
//  EventCell.swift
//  YashwanthAdirala-Events
//
//  Created by Adirala, Yashwanth Kumar Reddy on 5/20/22.
//

import UIKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var eventTitleLbl: UILabel!
    @IBOutlet weak var eventLocationLbl: UILabel!
    @IBOutlet weak var eventDateLbl: UILabel!
    @IBOutlet weak var eventImageLabel: UIImageView!
    @IBOutlet weak var favIconImage: UIButton!
    let defaults = UserDefaults.standard
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateData(event: EventItem) {
        let dateFormatter = DateFormatter();
        eventTitleLbl.text = event.title
        eventLocationLbl.text = event.location
        eventDateLbl.text = returnProperDate(date: dateFormatter.date(from: event.date))
        eventImageLabel.imageFromServerURL(urlString: event.imageUrl)
        if defaults.bool(forKey: "\(event.id)") {
            favIconImage.setImage( UIImage(systemName: "heart.fill"), for: .normal)
            favIconImage.tintColor = .red
            favIconImage.setNeedsLayout()
            favIconImage.isHidden = false
        } else {
            favIconImage.isHidden = true
        }
    }
    
    func returnProperDate(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, d MMM yyyy h:mm a"
        return dateFormatter.string(from: date ?? Date())
    }
}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}
