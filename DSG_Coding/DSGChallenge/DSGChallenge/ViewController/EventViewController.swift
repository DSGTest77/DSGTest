//
//  ViewController.swift
//  YashwanthAdirala-Events
//
//  Created by Adirala, Yashwanth Kumar Reddy on 5/20/22.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var eventSearchBar: UISearchBar!
    let viewModel = EventViewModel()
    var isSearching = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventSearchBar.delegate = self
        activityIndicator.startAnimating()
        viewModel.getEventData { [weak self] in
            DispatchQueue.main.async {
                self?.relaodData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.relaodData()
    }
}

extension EventsViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.eventListFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as? EventCell else {
            return UITableViewCell()
        }
        cell.populateData(event: viewModel.eventListFiltered[indexPath.row])
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "EventDteailSegue",
            let destination = segue.destination as? EventDetailVC,
            let index = eventTableView.indexPathForSelectedRow?.row {
            destination.event = viewModel.eventListData[index]
        }
    }

    // reloading UI
    func relaodData() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.eventTableView.reloadData()
    }
}

extension EventsViewController: UISearchBarDelegate {
    
    /// Delegate for search bar
    /// - Parameters:
    ///   - searchBar: UISearchBar
    ///   - searchText: String
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.count == 0) {
            self.isSearching = false;
            searchBar.showsCancelButton = false;
            searchBar.endEditing(true);
            self.eventTableView.reloadData();
        }
        else {
            let searchTextSplit = searchText.split(separator: " ");
            searchBar.showsCancelButton = true;
            self.isSearching = true;
            viewModel.filterData(searchText: searchTextSplit)
            self.eventTableView.reloadData();
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.eventSearchBar.showsCancelButton = true
    }
    
    //Resetting Data after clicking cancel from search bar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        eventSearchBar.showsCancelButton = false
        eventSearchBar.text = ""
        eventSearchBar.resignFirstResponder()
        viewModel.eventListFiltered = viewModel.eventListData
        eventTableView.reloadData()
    }
}
