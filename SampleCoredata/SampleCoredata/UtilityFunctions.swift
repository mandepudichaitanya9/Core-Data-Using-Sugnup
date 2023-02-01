//
//  UtilityFunctions.swift
//  SampleCoredata
//
//  Created by chaitanya on 12/14/22.
//

import UIKit
import CoreData

class UtilityFunctions: NSObject {
    
    
    func alertDisplayed(message:String, title:String, handler1: @escaping (_ uialertAction:UIAlertAction? ) -> (Void), onviewController: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { handler in
            handler1(handler)
        }
        alert.addAction(ok)
        onviewController.present(alert, animated: true, completion: nil)
    }
    
    
    
    func deleteData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
       // fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur3")
       
        do
        {
            let test = try managedContext.fetch(fetchRequest)

            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            print(objectToDelete)
            do{
                try managedContext.save()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    
}
}
