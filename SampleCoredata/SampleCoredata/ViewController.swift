//
//  ViewController.swift
//  SampleCoredata
//
//  Created by chaitanya on 12/14/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var mailArray = [String]()
    var passwordArray = [String]()
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = ""
        password.text = ""
    }
    
    @IBAction func deleteData(_ sender: Any) {
        UtilityFunctions().deleteData()
    }
    
    @IBAction func Login(_ sender: Any) {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            
            for result in results as! [NSManagedObject]{
                if let mail = result.value(forKey: "email") as? String{
                    self.mailArray.append(mail)
                    print(mailArray)
                }
                if let password = result.value(forKey: "password") as? String{
                    self.passwordArray.append(password)
                    print(passwordArray)
                }
                
            }
        }
        catch{
            print("error")
        }
        
        if (mailArray.contains(userName.text!)){
            print(mailArray)
            print(passwordArray)
            let mailIndex = mailArray.firstIndex(where: {$0 == userName.text})
            print(mailIndex!)
            if passwordArray[mailIndex!] == password.text{
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
                navigationController?.pushViewController(vc!, animated: true)
            }
        }
        else{
            UtilityFunctions().alertDisplayed(message: "No account found for this e-mail address", title: "Not Found", handler1: { uialertAction in
                
            }, onviewController: self)
        }
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        self.performSegue(withIdentifier: "segue", sender: self)
    }
    
    
    

}

