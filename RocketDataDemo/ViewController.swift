//
//  ViewController.swift
//  RocketDataDemo
//
//  Created by Kevin Smith on 7/5/17.
//  Copyright © 2017 Kevin Smith. All rights reserved.
//

import UIKit
import RocketData

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    /// The data provider which backs this view controller
    fileprivate let dataProvider = CollectionDataProvider<PuppyModel>()
    /// The cache key for our data provider
    fileprivate let cacheKey = "Puppies!!!"
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // In parallel, we're going to fetch from the cache and fetch from the network
        // There's no chance of a race condition here, because it's handled by RocketData
        dataProvider.fetchDataFromCache(withCacheKey: cacheKey) { (_, _) in
            self.tableView.reloadData()
        }
        
        session.dataTask(with: URL(string:"https://puppygifs.tumblr.com/api/read/json?callback=csod")!) {
            (data: Data?, response:URLResponse?, error: Error?) in
            if error == nil, let data = data, data.count > 7 {
                let json = data.subdata(in:5..<data.count-2)
                
                let serviceResult = try! JSONDecoder().decode(PuppyService.self, from: json)
                let collection = serviceResult.posts.filter({ (model) -> Bool in
                    return model.caption?.count ?? 0 > 0 && model.imageURL?.count ?? 0 > 0
                })
                
                self.dataProvider.setData(collection, cacheKey: self.cacheKey)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataProvider.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PuppyCell", for: indexPath) as! PuppyCell
        
        let puppy = dataProvider[indexPath.row]
        
        cell.caption.attributedText = puppy.caption?.html2AttributedString
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = dataProvider[indexPath.row].imageURL else { return }
        let vc = PuppyImageViewController()
        vc.imageURL = URL(string: url)
        self.show(vc, sender:nil)
    }
    
}

extension ViewController: CollectionDataProviderDelegate {
    func collectionDataProviderHasUpdatedData<T>(_ dataProvider: CollectionDataProvider<T>, collectionChanges: CollectionChange, context: Any?) {
        // Optional: Use collectionChanges to do tableview animations
        self.tableView.reloadData()
    }
}

