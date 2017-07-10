//
//  ViewController.swift
//  RocketDataDemo
//
//  Created by Kevin Smith on 7/5/17.
//  Copyright © 2017 Kevin Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var collection:[PuppyModel] = []
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        session.dataTask(with: URL(string:"https://puppygifs.tumblr.com/api/read/json?callback=csod")!) {
            (data: Data?, response:URLResponse?, error: Error?) in
            if error == nil, let data = data, data.count > 7 {
                let json = data.subdata(in:5..<data.count-2)
                
                let debugStr:NSString = String(data:json, encoding:.utf8)! as NSString
                print(debugStr.substring(to:14))
                print(debugStr.substring(from: debugStr.length - 14))
                
                let serviceResult = try! JSONDecoder().decode(PuppyService.self, from: json)
                self.collection = serviceResult.posts.filter({ (model) -> Bool in
                    return model.caption?.count ?? 0 > 0 && model.imageURL?.count ?? 0 > 0
                })
                
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
        return self.collection.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PuppyCell", for: indexPath) as! PuppyCell
        
        let puppy = collection[indexPath.row]
        
        cell.caption.attributedText = puppy.caption?.html2AttributedString
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
}
