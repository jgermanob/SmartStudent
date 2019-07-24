//
//  ViewController.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 7/22/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import UIKit
import RealmSwift

class SemesterConfigurationViewController: UIViewController {
    @IBOutlet weak var beginDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var semesterTitleTextField: UITextField!
    
    var beginDate = Date()
    var endDate = Date()
    var semester = Semester()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
    }

    @IBAction func nextButton(_ sender: Any) {
        print("nextButton")
        if semesterTitleTextField.text != ""{
            semester.title = semesterTitleTextField.text!
            semester.beginDate = beginDate
            semester.endDate = endDate
            //Writting semester object on the database
            try! realm.write{
                realm.add(semester)
            }
            performSegue(withIdentifier: "configurationSegue", sender: self)
        }
    }
}

