//
//  ViewController.swift
//  NoterCoreData
//
//  Created by Asem Qaffaf on 11/21/18.
//  Copyright © 2018 Asem Qaffaf. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
   
    
    var data: String?

    var leftColomStr: String = ""
    var righColomStr: String = ""
    var defaults = UserDefaults.standard
    @IBOutlet var arabicParagraph: UITextView!
    @IBOutlet var englishParagraph: UITextView!
    var arr = [NoteText]()
    let contax = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let leftItem = defaults.string(forKey: "leftColom\(data!)"){
            leftColomStr = leftItem
            englishParagraph.text = leftColomStr
        }
        if let rightItem = defaults.string(forKey: "righColom\(data!)"){
            righColomStr = rightItem
            arabicParagraph.text = righColomStr
        }
        
    
    }
    func test123()  {
        let request: NSFetchRequest<NoteText> = NoteText.fetchRequest()
        print(leftColomStr)
        do{
          arr =  try contax.fetch(request)
        }catch{
            print(error)
        }
    }
   
    @IBAction func buttonDonePressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
print("done")
        leftColomStr =  englishParagraph.text!
         defaults.setValue(leftColomStr, forKey: "leftColom\(data!)")
        
        righColomStr = arabicParagraph.text!
        defaults.setValue(righColomStr, forKey: "righColom\(data!)")
    }
        

}

