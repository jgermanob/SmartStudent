//
//  DirectoryManager.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 8/4/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import Foundation

class DirectoryManager {
    
    func createDirectory(directoryName: String){
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let logsPath = documentsPath.appendingPathComponent(directoryName)
        do{
            try FileManager.default.createDirectory(atPath: logsPath!.path, withIntermediateDirectories: true, attributes: nil)
        }catch let error as NSError{
            print("Unable to create directory: \(error.localizedDescription)")
        }
    }
}
