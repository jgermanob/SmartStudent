//
//  ClassesConfigurationViewController.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 7/23/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import UIKit

class ClassesConfigurationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addClass(_ sender: UIButton) {
        let viewController = AddClassViewController()
        self.present(viewController, animated: true, completion: nil)
    }
}
