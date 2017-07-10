//
//  PuppyImageViewController.swift
//  RocketDataDemo
//
//  Created by Kevin Smith on 7/9/17.
//  Copyright © 2017 Kevin Smith. All rights reserved.
//

import UIKit

class PuppyImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    var imageURL:URL? {
        didSet {
            guard let url = imageURL else { return }
            session.dataTask(with: url) {
                (data: Data?, response:URLResponse?, error: Error?) in
                guard error == nil, let data = data else {
                    print ("Error")
                    return
                }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
