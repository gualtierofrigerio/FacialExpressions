//
//  ExpressionsTableVC.swift
//  FacialExpressions
//
//  Created by Gualtiero Frigerio on 13/03/21.
//

import Combine
import UIKit

class ExpressionsTableVC: UITableViewController {
    var expressions:FacialExpressions = FacialExpressions()
    
    func setPublisher(_ publisher:FacialExpressionsPublisher) {
        cancellable = publisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { expressions in
                self.expressions = expressions
                self.tableView.reloadData()
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tracker = FaceTrackerAR()
        addChild(tracker)
        tracker.start()
        setPublisher(tracker.expressionsPublisher)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let (text, color) = textAndColor(forIndexPath: indexPath)
        cell.textLabel?.text = text
        cell.textLabel?.textColor = color
        
        return cell
    }
    
    // MARK: - Private
    private var cancellable:AnyCancellable?
    
    private func textAndColor(forIndexPath indexPath:IndexPath) -> (String, UIColor) {
        func colorForValue(_ value:Bool) -> UIColor {
            value ? .green : .red
        }
        
        var color = UIColor.red
        var text = ""
        switch indexPath.row {
        case 0:
            text = "left blink"
            color = colorForValue(expressions.leftBlink())
        case 1:
            text = "right blink"
            color = colorForValue(expressions.righBlink())
        case 2:
            text = "mouth close"
            color = colorForValue(expressions.mouthClose)
        case 3:
            text = "jaw open"
            color = colorForValue(expressions.jawOpen)
        case 4:
            text = "tongue out"
            color = colorForValue(expressions.toungueOut)
        case 5:
            text = "look left"
            color = colorForValue(expressions.lookLeft)
        case 6:
            text = "look right"
            color = colorForValue(expressions.lookRight)
        case 7:
            text = "look up"
            color = colorForValue(expressions.lookUp)
        case 8:
            text = "look down"
            color = colorForValue(expressions.lookDown)
        case 9:
            text = "nodding"
            color = expressions.isNodding ? .green : .red
        case 10:
            text = "shaking"
            color = expressions.isShaking ? .green : .red
        default:
            ()
        }
        
        return (text, color)
    }
}
