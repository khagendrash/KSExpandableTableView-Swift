//
//  MainController.swift
//  KSExpandableTableView-Swift
//
//  Created by Mac on 3/20/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit

class MainController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // outlets
    @IBOutlet weak var tableView: UITableView!
    
    /* --- Data models --- */
    
    // keys that are displayed as section title
    var arrayKeys = [Constants.PLANETS,Constants.INSTRUMENTS,Constants.PHONES,Constants.FRUITS,Constants.SAARC]
    
    // dictionary that contains all the original items
    var dictOriginalItems = [Constants.PLANETS :["Mars","Jupiter","Mercury","Satrun","Venus","Earth","Uranus","Neptune"],
    
    Constants.INSTRUMENTS : ["Guitar","Piano","Violin","Trumpet","Flute","Saxophone"],
    
    Constants.PHONES : ["Iphone","Android","Windows"],
    
    Constants.FRUITS : ["Apple","Orange","Grapes","Mango","Cherry","Banana"],
    
    Constants.SAARC : ["Afganistan","Bangladesh","Bhutan","India","Maldives","Nepal","Pakistan","Sri Lanka"]]
    
    
    // The temporary model to show minimum items. The number of items in each key should be equal to the value set for MIN_ROW_IN_SECTION (see constant variable declaration)
    var dictTempItems = [
        Constants.PLANETS : ["Mars","Jupiter","Mercury"],
        Constants.INSTRUMENTS : ["Guitar","Piano","Violin"],
        Constants.PHONES : ["Iphone","Android","Windows"],
        Constants.FRUITS : ["Apple","Orange","Grapes"],
        Constants.SAARC : ["Afganistan","Bangladesh","Bhutan"]
    ]
    
    // temporary array that stores the indexpath
    var dictOfIndexPaths = [String: Int]()


    override func viewDidLoad() {
        super.viewDidLoad()

        // change the status bar backgound color
        Helpers.setStatusBarBackgroundColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /* pragma mark - pragma mark Table View Data Source Methods */
    func numberOfSections(in tableView: UITableView) -> Int{
        return arrayKeys.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        let key = arrayKeys[section]
        let arrItems = dictTempItems[key]
        
        let curItemCount = arrItems!.count
        let origItemCount = dictOriginalItems[key]!.count
        
        if origItemCount > curItemCount{
            // one extra cell for more tab
            return curItemCount + 1;
        }
        else if origItemCount == curItemCount && curItemCount > Constants.MIN_ROW_IN_SECTION{
            // one extra cell less tab
            return curItemCount + 1;
        }
        else{
            // no extra cell as there is no more and less tab
            return curItemCount;
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return arrayKeys[section];
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell: UITableViewCell = UITableViewCell.init(style: .default, reuseIdentifier: Constants.SimpleTableIdentifier)
        
        let key = arrayKeys[indexPath.section]
        let arrItems = dictTempItems[key]
        let curItemCount: Int = arrItems!.count
        
        if indexPath.row == curItemCount{
            
            cell.textLabel?.textColor = UIColor.init(red: 0.44, green: 0.13, blue: 0.51, alpha: 1.0)
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
            
            if dictOfIndexPaths[String(indexPath.section)] == nil{
                cell.textLabel?.text = "More";
                cell.textLabel?.tag = Constants.TAG_FOR_ROW_MORE;
                
                cell.accessoryView = Helpers.getArrow("down")
            }
            else{
                cell.textLabel?.text = "Less";
                cell.textLabel?.tag = Constants.TAG_FOR_ROW_LESS;
                
                cell.accessoryView = Helpers.getArrow("up")
            }
        }
        else{
            let title = arrItems![indexPath.row]
            cell.textLabel?.text = title
            cell.textLabel?.textColor = UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
        tableView.deselectRow(at: indexPath, animated: false)
        
        let key = arrayKeys[indexPath.section]
        
        // get the cell row selected
        let cell = tableView.cellForRow(at: indexPath)
        let tagValue = cell?.textLabel?.tag;
        
        if tagValue == Constants.TAG_FOR_ROW_LESS || tagValue == Constants.TAG_FOR_ROW_MORE{
            
            // get array of all items
            let arrOriginalItems = dictOriginalItems[key]
            var dictItems = dictTempItems
            
            let maxRange = arrOriginalItems!.count - 1
            let arrayExtraItems = arrOriginalItems![Constants.MIN_ROW_IN_SECTION...maxRange]
            
            var arrayExtraIndexPaths = [IndexPath]()
            for ix in 0...arrayExtraItems.count-1 {
                
                let indexPath = IndexPath.init(row: Constants.MIN_ROW_IN_SECTION + ix, section: indexPath.section)
                arrayExtraIndexPaths.append(indexPath)
            }
            
            // handle when row for more is selected
            if dictOfIndexPaths[String(indexPath.section)] == nil{
                
                cell?.textLabel?.text = "Less";
                cell?.accessoryView? = Helpers.getArrow("up")
                dictOfIndexPaths[String(indexPath.section)] = indexPath.section
                print(dictOfIndexPaths);
                
                // update data source
                dictItems[key] = arrOriginalItems
                dictTempItems = dictItems
                
                // update table by inserting rows
                tableView.beginUpdates()
                tableView.insertRows(at: arrayExtraIndexPaths, with: .automatic)
                tableView.endUpdates()
            }
            else if dictOfIndexPaths[String(indexPath.section)] != nil{
                
                cell?.textLabel?.text = "More";
                cell?.accessoryView = Helpers.getArrow("down")
                dictOfIndexPaths.removeValue(forKey: String(indexPath.section))
                
                // update data source with only the minimum numbers of rows to be displayed
                var arrayWithMinItems = [String]()
                for ix in 0..<Constants.MIN_ROW_IN_SECTION {
                    arrayWithMinItems.append(arrOriginalItems![ix])
                }
                
                dictItems[key] = arrayWithMinItems
                dictTempItems = dictItems
                
                // upadate table by removing rows
                tableView.beginUpdates()
                tableView.deleteRows(at: arrayExtraIndexPaths, with: .automatic)
                tableView.endUpdates()
            }
        }
        else{
            // Statements for row selected other than more/less
            print("Other than more/less row clicked");
        }
    }
}
