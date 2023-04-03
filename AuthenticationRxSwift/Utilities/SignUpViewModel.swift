//
//  SignUpViewModel.swift
//  AuthenticationRxSwift
//
//  Created by prama niyogi on 23/03/23.
//

import Foundation
import RxCocoa
import RxSwift

class SignUpViewModel {
    
    static let SignUpinstance = SignUpViewModel()

    let nameSubject = BehaviorRelay<String?>(value: "")
    let emailSubject = BehaviorRelay<String?>(value: "")
    let passwordSubject = BehaviorRelay<String?>(value: "")
    let confirmPasswordSubject = BehaviorRelay<String?>(value: "")
    let numberSubject = BehaviorRelay<String?>(value: "")
    
    let disposeBag = DisposeBag()
    
    let minPasswordCharacters = 6
    
  
    var isValidForm: Observable<Bool> {
      
        return Observable.combineLatest(nameSubject, emailSubject, passwordSubject, numberSubject, confirmPasswordSubject) { name, email, password, number , confirmPassword in
            guard name != nil && email != nil && password != nil && number != nil && confirmPassword != nil else {
                return false
            }
        
            return !(name!.isEmpty) && name!.validateName() && email!.validateEmail() && password!.count >= self.minPasswordCharacters && password!.validatePassword()  && number!.validatePhone() && !(confirmPassword!.isEmpty) && confirmPassword!.validateConfirmPassword(firstPassword: self.passwordSubject.value!, confirmPasswod: self.confirmPasswordSubject.value!)
            
            
        }
    }
}
extension String {
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
    
    func validateName() -> Bool {
        let nameRegex = "^[A-Za-z]{3,30}$"
        let namePredicate = NSPredicate(format:"SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: self)
    }
    func validatePassword() -> Bool {
        let passwordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<]{6,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: self)
    }
    
    func validatePhone() -> Bool {
        let phoneRegex = "^[1-9]\\d{9}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: self)
    }
    
    func validateConfirmPassword(firstPassword: String, confirmPasswod: String) -> Bool {
        let firstpassword = firstPassword
        return confirmPasswod == firstPassword ? true : false
    }
}
