//
//  ViewController.swift
//  myStopWatch
//
//  Created by Anu Joshi on 2019-01-16.
//  Copyright © 2019 Anu Joshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var laps: [String] = [] //Array for storing laps
    var timer = Timer() //timer variable to start the timer
    var min:Int = 0 //mins variable
    var sec:Int = 0
    var tenth:Int = 0
    var startStopWatch = true //bool variable to keep track of start/stop functions
    var Lap = false //bool variable to keep track of lap/reset functionalities
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var lapsTableView: UITableView!
    @IBOutlet weak var stopwatchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopwatchLabel.text = "00:00.00" //Setting the value of the timer label on load
    }
    
    // Start and stop function
    @IBAction func startStopAction(_ sender: Any) {
        if startStopWatch{
            //Start fuctionality
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateStopWatch), userInfo: nil, repeats: true)
            
            startStopWatch=false;
            //replacing custom icons on single button
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
        //ternary operator
        let tenthString = tenth > 9 ? "\(tenth)" : "0\(tenth)"
        let minString = min > 9 ? "\(min)" : "0\(min)"
        let secString = sec > 9 ? "\(sec)" : "0\(sec)"
        stopwatchLabel.text = "\(minString):\(secString).\(tenthString)"
        
        }
    
    //reset and Lap function
    @IBAction func resetButtonAction(_ sender: Any) {
        // Laps functionality
        if Lap == true{
            //populating the laps array with stopwatch label text
            laps.insert(stopwatchLabel.text ?? "no value", at: 0)
            // reload the table data instantly
            lapsTableView.reloadData()
            
        }else{ //Reset functionality
            Lap=false;
            resetButton.setImage(UIImage(named: "reset.png"), for: UIControl.State.normal)
            timer.invalidate()
            tenth = 0
            sec = 0
            min = 0
            stopwatchLabel.text = "00:00:00"
            //clear table from the data
            laps.removeAll(keepingCapacity: false)
            lapsTableView.reloadData()
          }
    }
    
    // table view for adding laps in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count //returns the array count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        //        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = "Lap\(laps.count-indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        return cell
        
    }
    
    
    
}

