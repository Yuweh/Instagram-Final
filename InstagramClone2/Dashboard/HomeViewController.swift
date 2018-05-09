//
//  HomeViewController.swift
//  InstagramClone2
//
//  Created by Republisys on 08/05/2018.
//  Copyright © 2018 Francis Jemuel Bergonia. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var post = [Post]()
    
    @IBOutlet weak var tableView: UITableView!
    
    private func  loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Post(name: "Cassiopeia", photo: photo1) else {
            fatalError("Unable to instantiate meal1")
        }
        guard let meal2 = Post(name: "Fae", photo: photo2) else {
            fatalError("Unable to instantiate meal1")
        }
        guard let meal3 = Post(name: "Xian", photo: photo3) else {
            fatalError("Unable to instantiate meal1")
        }
        
        post += [meal1, meal2, meal3]
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.loadSampleMeals()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let posts = post[indexPath.row]
        cell.usernameButton.text = posts.userName
        cell.photoImageView.image = posts.photo
        
        
        return cell
    }


}
