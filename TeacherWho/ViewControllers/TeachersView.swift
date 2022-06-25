//
//  TeachersView.swift
//  TeacherWho
//
//  Created by Liron Ezer on 04/06/2022.
//

import UIKit
import FirebaseFirestore

class TeachersView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var myData = [Post]()
    var tempInfo: [String] = []
    var tempName: String = ""
    var tempImage: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadPosts()
        readPosts()
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        //cell.myLabel.text = myData[indexPath.row]
        //cell.myImageView.backgroundColor = .cyan
        
        let db = Firestore.firestore()
        db.collection("posts").whereField("user_id", isEqualTo: myData[indexPath.row].user_id).getDocuments() {
            (snapshot, err) in
            if let err = err {
                print("Error")
            }
            else {
                for d in snapshot!.documents {
                    //var tempName = self.getName(user_id: (d["user_id"] as? String)!, completion: <#(String) -> Void#>)
                    var tempUserID = d["user_id"] as? String
                    self.getNameAndImage(user_id: tempUserID!)
                    
                    var tempTopics = "Topics: "
                    tempTopics += (d["topics"] as? String)!
                    var tempAbout = d["about"] as? String
                    var tempPrice = "Price: "
                    tempPrice += (d["price"] as? String)!
                    
                    //self.tempInfo.append(contentsOf: [tempName, tempTopics, tempAbout, tempPrice])

                    self.tempInfo.append(self.tempName)
                    self.tempInfo.append(tempTopics)
                    self.tempInfo.append(tempAbout!)
                    self.tempInfo.append(tempPrice)
                    var tempLbl = self.tempInfo.joined(separator: "\n")
                    print(tempLbl)
                    cell.myLabel.adjustsFontSizeToFitWidth = true
                    cell.myLabel.numberOfLines = 6
                    cell.myLabel.text = tempLbl
                    //cell.
                }
            }
        }
        return cell
    }

    /*
    
    func loadPosts(){
            let db = Firestore.firestore().collection("posts")
            db.addSnapshotListener{snapshot,error in
                if let err = error {
                    debugPrint("error fetching docs: \(err)")
                } else {
                    guard let snap = snapshot else {
                        return
                    }
                    for d in snap.documents {
                        print(d["user_id"] as! String)
                        print(d["about"] as! String)
                        print(d["topics"] as! String)
                        let post = Post(user_id: d["user_id"] as! String, image: "", about: d["about"] as! String, topics: d["topics"] as! String, price: d["price"] as! String)
                        //d["image"] as! String
                        if (!self.myData.contains(where: {$0.user_id == post.user_id})){
                            self.myData.append(post)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
    }
     
     */
    
    func readPosts() {
        let db = Firestore.firestore().collection("posts").getDocuments() { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for d in snapshot!.documents {
                    let post = Post(user_id: d["user_id"] as! String, image: "", about: d["about"] as! String, topics: d["topics"] as! String, price: d["price"] as! String)
                    //d["image"] as! String
                    if (!self.myData.contains(where: {$0.user_id == post.user_id})){
                        self.myData.append(post)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func getNameAndImage(user_id: String) {
        let db = Firestore.firestore()
        db.collection("users").whereField("user_id", isEqualTo: user_id).getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error")
            }
            else {
                for d in querySnapshot!.documents {
                    self.tempName = String((d["name"] as! String?)!)
                    self.tempImage = String((d["image"] as! String?)!)
                }
            }
        }
    }
    
    
    /*
    func getName(user_id: String, completion: @escaping (String) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").whereField("user_id", isEqualTo: user_id).getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error")
            }
            else {
                for d in querySnapshot!.documents {
                    completion(d["name"] as! String? ?? "")
                }
            }
        }
        completion("")
    }
     */
    

}
