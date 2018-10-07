//
//  ViewController.swift
//  Key-PCOFF
//
//  Created by Awesome S on 01/10/2018.
//  Copyright © 2018 Awesome S. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var deleteKey: UITextField!
    @IBOutlet private weak var useKey: UITextField!
    
    private var brain = KeyBrain()
    private let dateFormatter = DateFormatter()
    
    private var dateValue: String{
        get{ return date.text! }
        set{ date.text = String(newValue) }
    }
    
    private var deleteValue: String{
        get{ return deleteKey.text! }
        set{ deleteKey.text = String(newValue) }
    }
    
    private var useValue: String{
        get{ return useKey.text! }
        set{ useKey.text = String(newValue) }
    }
    

    
    // 최초 시작
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 날짜포맷 설정
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // 오늘날짜 초기화
        brain.setDate(date: Date())
        dateValue = dateFormatter.string(from: brain.getDate)
        
        // 키값 초기화
        brain.setKey()
        
        updateUI()
    }
    
    // 날짜 및 키값 변경
    private func updateUI(){
        let now = dateFormatter.string(from: brain.getDate)
        dateValue = now
        
        deleteValue = brain.getDeleteKey(now: now)
        useValue = brain.getUseKey(now: now)
    }
    
    
    @IBAction func tapTwice(_ recognizer: UITapGestureRecognizer) {
        // 오늘
        if recognizer.state == .ended{
            let now = Date()
            brain.setDate(date: now)
            updateUI()
        }
    }
    
    @IBAction func swipeLeft(_ recognizer: UISwipeGestureRecognizer) {
        // +1일
        if recognizer.state == .ended{
            let date = brain.getDate
            let tomorrow = Date(timeInterval: 86400, since: date)
            brain.setDate(date: tomorrow)
            updateUI()
        }
    }
    
    @IBAction func swipeRight(_ recognizer: UISwipeGestureRecognizer) {
        // -1일
        if recognizer.state == .ended{
            let date = brain.getDate
            let yesterday = Date(timeInterval: -86400, since: date)
            brain.setDate(date: yesterday)
            updateUI()
        }
    }
    
    @IBAction func swipeDown(_ recognizer: UISwipeGestureRecognizer) {
       // +1주
        if recognizer.state == .ended{
            let date = brain.getDate
            let nextWeek = Date(timeInterval: 604800, since: date)
            brain.setDate(date: nextWeek)
            updateUI()
        }
    }
    
    @IBAction func swipeUp(_ recognizer: UISwipeGestureRecognizer) {
        // -1주
        if recognizer.state == .ended{
            let date = brain.getDate
            let lastWeek = Date(timeInterval: -604800, since: date)
            brain.setDate(date: lastWeek)
            updateUI()
        }
    }
}

