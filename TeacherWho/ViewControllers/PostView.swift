//
//  PostView.swift
//  TeacherWho
//
//  Created by Liron Ezer on 03/06/2022.
//

import UIKit
import Lottie

class PostView: UIViewController {
    
    @IBOutlet weak var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottieAnimation()
        // Do any additional setup after loading the view.
    }
    
    func lottieAnimation() {
        let animationview = AnimationView(name: "lottieTeacher")
        animationview.frame = CGRect(x: 0, y: -50, width: 400, height: 600)
        //animationview.center = self.view.center
        animationview.contentMode = .scaleAspectFit
        view.addSubview(animationview)
        animationview.play()
        animationview.loopMode = .loop
    }

}
