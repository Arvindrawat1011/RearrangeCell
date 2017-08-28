//
//  ExtensionFile.swift
//  TableViewTesting
//
//  Created by Appinventiv Technologies on 23/08/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import UIKit

extension FirstPage : UITableViewDataSource, UITableViewDelegate{
    
   
            // Returns Table Cell count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("image count is \(Image.count)")
        return Image.count
        
    }
    
    
        // Returns cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! TextFieldCell
        
        cell.lblOne.text = labelOne[indexPath.row]
        cell.lblTwo.text = labelTwo[indexPath.row]
        
        cell.imgView.image = UIImage(named : Image[indexPath.row])
        let text = indexPath.row
        print(text)
        cell.lblCounter.text = String(text+1)
        
        
        return cell
        
    }
    
    
    //   Selected row or cell
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
        
        let currentCell = tableView.cellForRow(at: indexPath!) as! TextFieldCell
        
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "SecondPage") as! SecondPage
        print(indexPath!)
        obj.transferImage =  Image[(indexPath?.row)!]
        
        obj.transferLabel = currentCell.lblOne.text!
        
        obj.smallImageArr = smallImage
        obj.smallLabel = labelOne
        
        self.navigationController?.pushViewController(obj, animated: true)
        

        
        
    
}
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
         let cell = self.firstPageTableView.cellForRow(at: indexPath) as! TextFieldCell
        
        let editAction = UITableViewRowAction(style: .default,title : "Delete" ,handler:{(ACTION,indexPath) in
            
            print("Row deleted\(indexPath.row)")
            
            self.Image.remove(at: indexPath.row )
            self.labelOne.remove(at: indexPath.row )
            self.labelTwo.remove(at: indexPath.row )
            tableView.deleteRows(at: [indexPath], with: .right)
            tableView.reloadData()
        })
        
        editAction.backgroundColor = UIColor.init(red: 0.5, green: 1, blue: 0.5, alpha: 0.5)
        
        
        let MoreAction = UITableViewRowAction(style: .default,title : "More" ,handler:{(ACTION,indexPath) in
            
             cell.lblOne.text =  " More Button Clicked"
            
            
        })
        
        let ShareAction = UITableViewRowAction(style: .default,title : "Image" ,handler:{(ACTION,indexPath) in
            
            
               cell.lblOne.text =  " ImageButton Button Clicked"
            print("Image Button is Tapped")
        })
        
        ShareAction.backgroundColor = UIColor.init(red: 0.8, green: 0.5, blue: 0, alpha: 0.5)
        return [editAction,MoreAction,ShareAction]
        
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        //  For Image Calibration
        var itemToMove = Image[sourceIndexPath.row]
        Image.remove(at: sourceIndexPath.row)
        Image.insert(itemToMove, at: destinationIndexPath.row)
        
         //  For labelOne Calibration
         itemToMove = labelOne[sourceIndexPath.row]
       labelOne.remove(at: sourceIndexPath.row)
       labelOne.insert(itemToMove, at: destinationIndexPath.row)
         //  For labelTwo Calibration
        itemToMove = labelTwo[sourceIndexPath.row]
        labelTwo.remove(at: sourceIndexPath.row)
        labelTwo.insert(itemToMove, at: destinationIndexPath.row)
         //  For counter Calibration
       
        firstPageTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
        
    }
    // Return String Named
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Erase"
    }
}
