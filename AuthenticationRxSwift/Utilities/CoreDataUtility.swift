//
//  CoreDataUtility.swift
//  AuthenticationRxSwift
//
//  Created by Chandrasheela Hotkar on 24/03/23.
//

import Foundation
import CoreData
import RxSwift
import RxCocoa

class Details{
    
    static let sharedInstance = Details()
    
    let detailContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveDetails(name: String, email: String, phoneNum: String, password: String) -> Completable {
        
        return Completable.create{ observer in
            let detail = Detail(context: self.detailContext)

            detail.name = name
            detail.email = email
            detail.mobile = phoneNum
            detail.password = password
            do{
                try self.detailContext.save()
                print("Details added")
            }
            catch{
                print("Unable to add details: \(error.localizedDescription)")
                self.detailContext.delete(detail)
            }
            
            return Disposables.create()
            
        }
    }

    
    func fetchDetails() -> Observable<[Detail]>{
        return Observable<[Detail]>.create{ observer -> Disposable in
            
            let fReq : NSFetchRequest<Detail> = Detail.fetchRequest()
            do{
                let detailList = try self.detailContext.fetch(fReq)
                observer.onNext(detailList)
                print("Detail Added")
                //return detailList
            }
            catch{
                print("Unable to load : \(error.localizedDescription)")
            }
            return Disposables.create {
                
            }
        }
            
        }
}


