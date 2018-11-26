//
//  TableViewController.swift
//  NoterCoreData
//
//  Created by Asem Qaffaf on 11/21/18.
//  Copyright © 2018 Asem Qaffaf. All rights reserved.
//
import UIKit
import CoreData


class TableViewController: UITableViewController {
    

    var arr2 = [Category]()
    var isEnabledEditMode: Bool = false
    var indexItems = 0
    let contax = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
            fetch()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr2.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tabelID", for: indexPath)
       let item = arr2[indexPath.row]
        cell.textLabel?.text = arr2[indexPath.row].menu

        if item.isSelected == true{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }


        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVc = segue.destination as! ViewController
       
        if let indexPath = tableView.indexPathForSelectedRow{
            secondVc.data = "\(arr2[indexPath.row].menu)\(indexPath.row)"
        }
    }
    @IBAction func addPressedButton(_ sender: UIBarButtonItem) {
        alertFunc(actionTitle: "Add")
    }
    func alertFunc(actionTitle: String) {
        var textItem = UITextField()
        let alert = UIAlertController(title: "Please \(actionTitle) a new element here", message: "", preferredStyle: .alert)
        alert.addTextField { (UITextField) in
            textItem = UITextField
        }
        if actionTitle == "Add"{
        let addAction = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            if textItem.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true{
                self.isEditing = false
            }else{
                
                let itemsForAdd = Category(context: self.contax)
                itemsForAdd.menu = textItem.text
                itemsForAdd.isSelected = false

                self.arr2.append(itemsForAdd)
                self.save()
                self.tableView.reloadData()
            }
        }
        alert.addAction(addAction)
        }else if actionTitle == "Edit"{
       
            let editAction = UIAlertAction(title: "Edit", style: .default) { (UIAlertAction) in
                if textItem.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true{
                    self.isEditing = false
                }else{
                self.arr2[self.indexItems].setValue(textItem.text, forKey: "menu")
                self.save()
                self.tableView.reloadData()
                
            }
            }
                   alert.addAction(editAction)
        }

       
        
        present(alert, animated: true, completion: nil)
    }
    func save()  {
        do{
            try contax.save()
        }catch{
            print(error)
        }
    }
    func fetch(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            arr2 = try contax.fetch(request)
            
        }catch{
            print(error)
        }
    }
    @IBAction func editPressedButton(_ sender: UIBarButtonItem) {
        if isEnabledEditMode == false{
            isEnabledEditMode = true
            tableView.setEditing(true, animated: true)
        }else{
            isEnabledEditMode = false
            tableView.setEditing(false, animated: false)
        }
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let removeAction = UITableViewRowAction(style: .default, title: "Remove") { (UITableViewRowAction, IndexPath) in
            self.contax.delete(self.arr2[indexPath.row])
            self.arr2.remove(at: indexPath.row)
            self.save()
            tableView.reloadData()

        }
        let EditAction = UITableViewRowAction(style: .normal, title: "Edit") { (UITableViewRowAction
            , IndexPath) in

            self.alertFunc(actionTitle: "Edit")
            self.indexItems = IndexPath.row
            
        }
        return [removeAction, EditAction]
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    

}
