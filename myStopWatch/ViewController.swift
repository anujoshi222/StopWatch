//
//  ViewController.swift
//  myStopWatch
//
//  Created by Anu Joshi on 2019-01-16.
//  Copyright © 2019 Anu Joshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    var timer = Timer()
    var min:Int = 00
    var sec:Int = 00
    var tenth:Int = 00
    var startStopWatch = true
    var Lap = false
    
    var startstopString: String = ""
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var lapsTableView: UITableView!
    @IBOutlet weak var stopwatchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopwatchLabel.text = "00:00.00"
    }


    @IBAction func resetButtonAction(_ sender: Any) {
        if Lap == true{
            Lap = false
            
        }
        
        else{
            Lap=true;
            resetButton.setImage(UIImage(named: "reset.png"), for: UIControl.State.normal)
            tenth = 0
            sec = 0
            min = 0
            stopwatchLabel.text = "00:00:00"
            
        }
        
    }
    
    @IBAction func startStopAction(_ sender: Any) {
        if startStopWatch{
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateStopWatch), userInfo: nil, repeats: true)
            
            startStopWatch=false;
            startStopButton.setImage(UIImage(named: "stop.png"), for: UIControl.State.normal)
            resetButton.setImage(UIImage(named: "laps.png"), for: UIControl.State.normal)
            Lap = true
        }else{
            timer.invalidate()
            startStopWatch = true
            startStopButton.setImage(UIImage(named: "start.png"), for: UIControl.State.normal)
            resetButton.setImage(UIImage(named: "reset.png"), for: UIControl.State.normal)
            Lap = false
        }
        
    }
 
    @objc func updateStopWatch(){
        tenth += 1
        if tenth == 100{
            sec += 1
            tenth = 0
            
        }
        
        if sec == 60{
            min += 1
            sec = 0
        }
        let tenthString = tenth > 9 ? "\(tenth)" : "0\(tenth)"
        let minString = min > 9 ? "\(min)" : "0\(min)"
        let secString = sec > 9 ? "\(sec)" : "0\(sec)"
        stopwatchLabel.text = "\(minString):\(secString).\(tenthString)"

        
            
    }
        
    // table view for adding laps in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        //        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = "Lap"
        cell.detailTextLabel?.text = "00:00:00"
        return cell
        
    }
    
    
    
}

