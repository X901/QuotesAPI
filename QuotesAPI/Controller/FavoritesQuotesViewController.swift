////
//FavoritesQuotesViewController.swift
//QuotesAPI
//
//Created by Basel Baragabah on 26/06/2020.
//Copyright © 2020 Basel Baragabah. All rights reserved.
//

import UIKit
import Unrealm
import RealmSwift
import DZNEmptyDataSet

class FavoritesQuotesViewController: UIViewController {
    
    @IBOutlet weak var favoritesQuotesTableview: UITableView!
    
    private var favoritesArray: Unrealm.Results<FavoritesQuotes>?
    private var favoritesToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTableViewResults()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesToken = favoritesArray?.observe { [weak favoritesQuotesTableview] changes in
            guard let tableView = favoritesQuotesTableview else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let updates):
                tableView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
            case .error: break
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          favoritesToken?.invalidate()
      }
    
    func updateTableViewResults() {
        favoritesArray = FavoritesQuotes.all()
    }
    
}

extension FavoritesQuotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesQuotesCell", for: indexPath) as? FavoritesQuotesTableViewCell else {return UITableViewCell()}
        
        if let favoritesArray = favoritesArray {
            cell.fillCell(favorite: favoritesArray[indexPath.row])
        }
        
        return cell
        
    }
    
}

extension FavoritesQuotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let quote = favoritesArray?[indexPath.row], editingStyle == .delete else { return }
        quote.delete()
    }
}

extension FavoritesQuotesViewController : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No favorite to show !"
        var attrs: [NSAttributedString.Key : UIColor]
        
        if #available(iOS 13.0, *) {
            attrs = [NSAttributedString.Key.foregroundColor: UIColor.label]
        } else {
            // Fallback on earlier versions
            attrs = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Tab on star button to add quote to favorite page"
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "starBackground")
    }
    
}
