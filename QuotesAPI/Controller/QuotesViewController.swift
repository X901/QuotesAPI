////
//QuotesViewController.swift
//QuotesAPI
//
//Created by Basel Baragabah on 26/06/2020.
//Copyright © 2020 Basel Baragabah. All rights reserved.
//

import UIKit
import RealmSwift

class QuotesViewController: UIViewController {

    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var randomQuoteButton: UIButton!
    @IBOutlet weak var quoteView: UIViewX!
    
    
    var id : String?
    var quote : String?
    var author : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showOrHideObjects(true)
        reachabilityObserver()
        
            }

    
    @IBAction func randomQuoteTapped(_ sender: UIButton) {
        getRandomQouteData()
    }
    
    @IBAction func favoriteQuoteTapped(_ sender: UIButton) {
        
        let realm = try! Realm()
        let quoteFavorite = FavoritesQuotes(id: id, en: quote, author: author)
        
        try! realm.write {
            realm.add(quoteFavorite)
        }
        
        favoriteButton.setImage(UIImage(named: "starOn"), for: .normal)
            
    }
    
    private func getRandomQouteData(){
        favoriteButton.setImage(UIImage(named: "starOff"), for: .normal)

        
        requestRandomQuote { (result, state) in
            
            if state {
                
                if let result = result {
                self.showOrHideObjects(false)
                
                guard let idString = result.id else {return}
                guard let quoteString = result.en else {return}
                guard let authorString = result.author else {return}

                self.id = idString
                self.quote = quoteString
                self.author = authorString

                self.quoteTextView.text = quoteString
                self.authorLabel.text = authorString

                DispatchQueue.main.async {
                    self.saveLastQuote()
                }

                }
            }
            
        }
        
    }
    
     func requestRandomQuote(completionHandler: @escaping(_ quote: Quote?,_ status: Bool) -> Void){
        APIClient.getRandomQouteData(){ result in
                   
                   switch result {
                   case .success(let result):
                    completionHandler(result,true)
                       
                   case .failure(let error):
                    completionHandler(nil,false)
                       print(error.localizedDescription)
                   }
               }
    }
    
    private func showOrHideObjects(_ isHidden:Bool){
        quoteView.isHidden = isHidden
        randomQuoteButton.isHidden = isHidden
    }
    
    private func saveLastQuote(){
         UserDefults.clearLastQuote()
        let lastQuote = UserDefults.LastQuote(id: id, en: quote, author: author)
         UserDefults.saveLastQuote(lastQuote)
    }
    
    func displayLastQuote(){
                
          if let lastQuote = UserDefults.getLastQuote() {
            showOrHideObjects(false)
              quoteTextView.text = lastQuote.en
              authorLabel.text = lastQuote.author
          }
      }
    
    func reachabilityObserver() {

      NetworkReachability.shared.reachabilityObserver = { [weak self] status in
            switch status {
                case .connected:
                    self?.randomQuoteButton.isEnabled = true
                    self?.getRandomQouteData()
                    print("Reachability: Network available")
                
                case .disconnected:
                    self?.randomQuoteButton.isEnabled = false
                    self?.displayLastQuote()
                    print("Reachability: Network unavailable")
            }
        }
    }
    
}


