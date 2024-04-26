//
//  BottomBarViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 26/04/24.
//

import UIKit

class BottomBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isLogin = UserDefaults.standard.bool(forKey: "logged_in")
        if !isLogin{
            let vc = OnBoardingViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true, completion: nil)
        }else{
            super.viewDidAppear(animated)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
