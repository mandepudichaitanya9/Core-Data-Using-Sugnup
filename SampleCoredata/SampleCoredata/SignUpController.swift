//
//  SignUpController.swift
//  SampleCoredata
//
//  Created by chaitanya on 12/14/22.
//

import UIKit
import CoreData

class SignUpController: UIViewController {
    
    var mailArray = [String]()
    
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        coredata()
    }
    
    func coredata(){
        let passwordRegPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,9}$"
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let password = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        let mail = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        let userName = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        let confirmpassword = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                if let mail = result.value(forKey: "email") as? String{
                    self.mailArray.append(mail)
                }
            }
        }
        catch{
            print("error")
        }
        if(mailArray.contains(emailTxt.text!)){
            
            UtilityFunctions().alertDisplayed(message: "There is an account with this email address.", title: "Account Exists", handler1: { uialertAction in
                self.navigationController?.popViewController(animated: true)
            }, onviewController: self)
        }else {
            if ((passwordTxt.text?.range(of: passwordRegPattern, options: .regularExpression) != nil)&&(emailTxt.text?.range(of: emailRegEx, options: .regularExpression) != nil)){
                if (passwordTxt.text == confirmPasswordTxt.text){
                    
                    UtilityFunctions().alertDisplayed(message: "You are redirected to the login page", title: "Registration Successfully", handler1: { uialertAction in
                        password.setValue(self.passwordTxt.text, forKey: "password")
                        mail.setValue(self.emailTxt.text, forKey: "email")
                        userName.setValue(self.usernameTxt.text, forKey: "username")
                        confirmpassword.setValue(self.confirmPasswordTxt.text, forKey: "confirmpassword")
//                        print(password)
//                        print(mail)
//                        print(userName)
//                        print(confirmpassword)
                        do {
                            try context.save()
                        } catch let error as NSError {
                            print("Could not save. \(error), \(error.userInfo)")
                        }
                        self.navigationController?.popViewController(animated: true)
                    }, onviewController: self)
                }
                else{
                    UtilityFunctions().alertDisplayed(message: "Passwords do not match", title: "Password Error", handler1: { uialertAction in
                        
                    }, onviewController: self)
                }
            }else{
                UtilityFunctions().alertDisplayed(message: "Check E-Mail and Password again", title: "Invalid Information", handler1: { uialertAction in
                    
                }, onviewController: self)
            }
        }
    }
  
    
}
