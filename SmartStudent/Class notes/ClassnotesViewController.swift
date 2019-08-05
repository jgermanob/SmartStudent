//
//  ClassnotesViewController.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 8/4/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import UIKit
import RealmSwift

class ClassnotesViewController: UIViewController {
    @IBOutlet weak var subjectsCollectionView: UICollectionView!
    let realm = try! Realm()
    var subjectsNames = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBar()
        subjectsCollectionView.delegate = self
        subjectsCollectionView.dataSource = self
        let results = realm.objects(Subject.self)
        for subject in results{
            subjectsNames.append(subject.name)
        }
    }
    
    func setupNavigationBar(){
        let imageButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takeClassnotePhoto))
        navigationItem.rightBarButtonItem = imageButton
    }
    
    @objc func takeClassnotePhoto(){
        
    }
}

extension ClassnotesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjectsNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "classnotesCell", for: indexPath) as! ClassnotesCollectionViewCell
        cell.subjectName.text = subjectsNames[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(integerLiteral: 100)
        let height = CGFloat(integerLiteral: 100)
        return CGSize(width: width, height: height)
    }
}

extension ClassnotesViewController : UIImagePickerControllerDelegate{
    
}
