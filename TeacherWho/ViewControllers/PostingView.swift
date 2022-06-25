//
//  PostingView.swift
//  TeacherWho
//
//  Created by Liron Ezer on 03/06/2022.
//

import UIKit
import SwiftUI

class PostingView: UIViewController {

    @IBOutlet weak var image: UIImageView!
    //@State var selecteedImage: UIImage?
    //@State var isPickerShowing = false
    //@IBOutlet weak var posting_BTN_upload: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func Posting_BTN_english(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
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

