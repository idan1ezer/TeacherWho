//
//  InfoView.swift
//  TeacherWho
//
//  Created by Liron Ezer on 27/06/2022.
//

import UIKit
import FirebaseStorage

class InfoView: UIViewController {

    @IBOutlet weak var info_IMG_image: UIImageView!
    @IBOutlet weak var info_LBL_info: UILabel!
    
    var post: Post?
    var tempInfo: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInfo()
        // Do any additional setup after loading the view.
    }
    
    func loadInfo() {
        if self.post != nil {
            self.tempInfo.append(self.post!.name)
            self.tempInfo.append(self.post!.topics)
            self.tempInfo.append(self.post!.about)
            self.tempInfo.append(self.post!.price)
            
            info_LBL_info.adjustsFontSizeToFitWidth = true
            info_LBL_info.numberOfLines = 16
            info_LBL_info.text = self.tempInfo.joined(separator: "\n\n")
            
            loadImage()
        }
    }
    
    func loadImage() {
        let tempUserID = self.post?.user_id
        let start = tempUserID?.index(tempUserID!.startIndex, offsetBy: 0)
        let end = tempUserID?.index(tempUserID!.startIndex, offsetBy: (tempUserID!.count - 1))
        let range = start!...end!
        var newID = String(tempUserID![range])
        newID = "\"" + newID + "\""
        
        //let start = tempUserID.index(tempUserID.startIndex, offSetBy: 10)
        //let end = tempUserID.index(tempUserID.startIndex, offSetBy: (tempUserID.count - 1))

        let storageRef = Storage.storage().reference()
        let imgRef = storageRef.child("images/\(newID).jpg")
        //print("images/\(newID).jpg")
        //print(newID)
        //print(d["user_id"])
        imgRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                //
            } else {
                let image = UIImage(data: data!)
                self.info_IMG_image.image = image
            }
        }

    }
    

    @IBAction func sendMessage(_ sender: Any) {
        
    }
    
}
