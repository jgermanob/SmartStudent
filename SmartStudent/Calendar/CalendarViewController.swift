//
//  CalendarViewController.swift
//  SmartStudent
//
//  Created by Jesús Germán Ortiz Barajas on 7/23/19.
//  Copyright © 2019 germanco. All rights reserved.
//

import UIKit
import RealmSwift
import JTAppleCalendar

class CalendarViewController: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var scheduleTableView: UITableView!
    let realm = try! Realm()
    
    //Array to store subject for an specific day
    var todaySubjects = [Subject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureCalendarView()
        configureScheduleTableView()
    }
    
    func configureCalendarView(){
        calendarView.ibCalendarDelegate = self
        calendarView.ibCalendarDataSource = self
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = true
    }
    
    func configureScheduleTableView(){
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
    }
    
}

extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate{
    
    func handleCellTextColor(cell : DateCell, cellState: CellState){
        if cellState.dateBelongsTo == .thisMonth{
            cell.dayLabel.textColor = UIColor.black
        }else{
            cell.dayLabel.textColor = UIColor.lightGray
        }
    }
    
    func handleCellSelected(cell: DateCell, cellState: CellState) {
        if cellState.isSelected {
            cell.selectedView.layer.cornerRadius =  13
            cell.selectedView.isHidden = false
        } else {
            cell.selectedView.isHidden = true
        }
    }
    
    func configureCell(view : JTAppleCell?, cellState : CellState){
        guard let cell = view as? DateCell else {return}
        cell.dayLabel.text = cellState.text
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.black.cgColor
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
        
    }
    
    //Function to get all subjects for an specific day
    func getSpecificDaySubjects(day: Int) -> [Subject]{
        var todaySubjects = [Subject]()
        let subjects = realm.objects(Subject.self)
        for subject in subjects{
            for d in subject.weekdays{
                if d.day == day{
                    todaySubjects.append(subject)
                }
            }
        }
        return todaySubjects
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2019 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
        let day = Calendar.current.component(.weekday, from: date)
        todaySubjects = getSpecificDaySubjects(day: day)
        scheduleTableView.reloadData()
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthTitle.text = formatter.string(from: range.start)
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
    
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todaySubjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
        cell.subjectNameLabel.text = todaySubjects[indexPath.row].name
        cell.subjectTeacherLabel.text = todaySubjects[indexPath.row].teacher
        cell.subjectTimeLabel.text = ""
        cell.subjectClassroomLabel.text = todaySubjects[indexPath.row].classroom
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }
}


