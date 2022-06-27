//
//  PostingView.swift
//  TeacherWho
//
//  Created by Liron Ezer on 03/06/2022.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore


class PostingView: UIViewController {
    
    var topics: [String] = []
    //var user_id: String = ""
    //var email: String = ""
    //var password: String = ""
    var name: String = ""
    var phone: String = ""
    //var currUser: User = User()
    
    @IBOutlet weak var post_TXT_about: UITextField!
    @IBOutlet weak var post_TXT_price: UITextField!
    
    @IBOutlet weak var image: UIImageView!
    //@State var selecteedImage: UIImage?
    //@State var isPickerShowing = false
    //@IBOutlet weak var posting_BTN_upload: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrUser()
        
    }
    
    func getCurrUser() {
        var uID: String = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: uID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("err")
            } else {
                for d in querySnapshot!.documents {
                    self.name = d["name"] as! String
                    self.phone = d["phone"] as! String
                }
            }
        }
    }
    
    @IBAction func eng_BTN_sel(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            topics.remove(at: topics.firstIndex(of: "English")!)
        } else {
            sender.isSelected = true
            topics.append("English")
        }
    }
    
    @IBAction func geo_BTN_sel(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            topics.remove(at: topics.firstIndex(of: "Geography")!)
        } else {
            sender.isSelected = true
            topics.append("Geography")
        }
    }
    
    
    @IBAction func heb_BTN_sel(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            topics.remove(at: topics.firstIndex(of: "Hebrew")!)
        } else {
            sender.isSelected = true
            topics.append("Hebrew")
        }
    }
    
    @IBAction func mat_BTN_sel(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            topics.remove(at: topics.firstIndex(of: "Mathematics")!)
        } else {
            sender.isSelected = true
            topics.append("Mathematics")
        }
    }
    
    @IBAction func prg_BTN_sel(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            topics.remove(at: topics.firstIndex(of: "Programming")!)
        } else {
            sender.isSelected = true
            topics.append("Programming")
        }
    }
    
    
    @IBAction func postClicked(_ sender: Any) {
        
        // Create cleaned versions of the data
        let about = post_TXT_about.text!
        let price = post_TXT_price.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        // User was created successfully, now store the first name and last name
        let db = Firestore.firestore()
        let tempTopics = topics.joined(separator: " ")
        db.collection("posts").addDocument(data: ["user_id":Auth.auth().currentUser?.uid, "name":self.name, "phone":self.phone, "topics":tempTopics, "about":about, "price":price]) { (error) in
        }
        
        // Transition to the home screen
        self.transitionToHome()
    }
    
    func transitionToHome() {
        
        let tabView = storyboard?.instantiateViewController(identifier: "TabVC") as? TabView
        view.window?.rootViewController = tabView
        view.window?.makeKeyAndVisible()
    }
    
    
    
}

/*
struct ContentView: View {
    
    @State var selecteedImage: UIImage?
    @State var isPickerShowing = false
    
    var body: some View {
        VStack {
            if selecteedImage != nil {
                Image(uiImage: selecteedImage!)
                    .resizable()
                    .frame(width: 0, height: 0)
            }
            Button {
                self.isPickerShowing = true
            } label: {
                Text("")
            }
        }
        .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
            ImagePicker(selectedImage: self.$selecteedImage, isPickerShowing: self.$isPickerShowing)
        }
        
        if selecteedImage != nil {
            //image.image = selecteedImage
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

*/

