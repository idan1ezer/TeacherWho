//
//  PostingView.swift
//  TeacherWho
//
//  Created by Liron Ezer on 03/06/2022.
//

import UIKit

class PostingView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func Posting_BTN_english(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    

}
