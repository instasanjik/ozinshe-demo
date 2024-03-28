//
//  ProfileNavigationViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 28.03.2024.
//

import UIKit

class ProfileNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers = [ProfileViewController()]
        self.topViewController?.extendedLayoutIncludesOpaqueBars = false
        self.navigationBar.barTintColor = .clear
        self.navigationBar.backgroundColor = .clear
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
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
