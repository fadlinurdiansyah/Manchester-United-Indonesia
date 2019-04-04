//
//  PertandinganVC.swift
//  Manchester United Indonesia
//
//  Created by NDS on 28/02/19.
//  Copyright © 2019 NDS. All rights reserved.
//

import UIKit

class PertandinganVC: UITableViewController {

    /*
     -----------------------------------------------------
     Declaration
     -----------------------------------------------------
     */
    
    
    /*---------Declaration Variable-----------------*/
    
    let cellId = "cellId"
    let headerId = "headerId"
    var currentSelection: Int?
    var currentSection: Int?
    var newCellHeight: CGFloat?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentSelection = -1
        currentSection = -1

        navigationItem.title = "PERTANDINGAN"
        view.backgroundColor = UIColor.white

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Pemain"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showPemain))
        navigationItem.leftBarButtonItem?.tintColor = .red
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = UIColor.rgb(red: 153, green: 154, blue: 155)
        tableView.sectionHeaderHeight = 50
        tableView.register(PertandinganTVC.self, forCellReuseIdentifier: cellId)
        tableView.register(PertandinganHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let table = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PertandinganTVC
        table.selectionStyle = .none
//        print("Table Select \(indexPath.section) \(indexPath.row)")
        return table
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! PertandinganHeader
        header.contentView.backgroundColor = UIColor.rgb(red: 232, green: 234, blue: 237)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight: CGFloat
        if indexPath.row == self.currentSelection && indexPath.section == self.currentSection {
            rowHeight = self.newCellHeight!
        } else {
            rowHeight = 50
        }
        
        return rowHeight
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if indexSelected != -1 {
//            let oldCell = tableView.cellForRow(at: NSIndexPath(row: indexSelected, section: 0) as IndexPath) as! CustomDemoTableViewCell
//            oldCell.imageViewDemo.isHidden = false
//        }
//
//
//        indexSelected = indexPath.row //update selected row
//        let cell = tableView.cellForRow(at: indexPath as IndexPath) as! CustomDemoTableViewCell
//        cell.imageViewDemo.isHidden = true
//
//        tableView.beginUpdates()
//        tableView.endUpdates()
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.currentSelection = indexPath.row
        self.currentSection = indexPath.section
        self.newCellHeight = 120
        
//        if indexPath.row == self.currentSelection && indexPath.section == self.currentSection {
//                let cell = tableView.cellForRow(at: IndexPath(row: self.currentSelection!, section: self.currentSection!)) as! PertandinganTVC
//                cell.showItem(hidden: false)
//                print("Show \(indexPath.section) -- \(indexPath.row)")
//           
//        }
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    
    /*
     -----------------------------------------------------
     FUNCTION
     -----------------------------------------------------
     */
    
    @objc func showPemain() {
        print("Pemain")
    }

}
