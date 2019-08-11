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
    @IBOutlet weak var semesterTitleLabel: UILabel!
    @IBOutlet weak var beginDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    var beginDate = Date()
    var endDate = Date()
    var semester = Semester()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        beginDatePicker.translatesAutoresizingMaskIntoConstraints = false
        beginDatePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        beginDatePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        beginDatePicker.topAnchor.constraint(equalTo: beginDateLabel.bottomAnchor).isActive = true
        beginDatePicker.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        endDateLabel.topAnchor.constraint(equalTo: beginDatePicker.bottomAnchor).isActive = true
        
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        endDatePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        endDatePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        endDatePicker.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor).isActive = true
        endDatePicker.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }

    @IBAction func nextButton(_ sender: Any) {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "configurationSegue"{
            let subjectsConfigurationViewController = segue.destination as! SubjectsConfigurationViewController
        }
    }
    
    func setupContraints(){
        beginDatePicker.translatesAutoresizingMaskIntoConstraints = false
        beginDatePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        beginDatePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        beginDatePicker.topAnchor.constraint(equalTo: beginDateLabel.bottomAnchor).isActive = true
        beginDatePicker.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
        endDateLabel.topAnchor.constraint(equalTo: beginDatePicker.bottomAnchor).isActive = true
        
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        endDatePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        endDatePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        endDatePicker.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor).isActive = true
        endDatePicker.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
}

