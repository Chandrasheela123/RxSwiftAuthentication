//
//  SignUpViewController.swift
//  AuthenticationRxSwift
//
//  Created by prama niyogi on 20/03/23.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let data = BehaviorRelay<[Detail]>(value: [])
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var conformPasswordTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Home Dir: \(NSHomeDirectory())")
          setupBindings()
       
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet.clipboard"), style: .plain, target: self, action: #selector(addBtnSelected))
     
        // Do any additional setup after loading the view.
   
    }
    
    @objc func addBtnSelected(){
        
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "detailsList") as! DetailsViewController
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }

    func setupBindings() {
         
        nameTextField.rx.text.bind(to: SignUpViewModel.SignUpinstance.nameSubject).disposed(by: disposeBag)
       
        emailTextField.rx.text.bind(to: SignUpViewModel.SignUpinstance.emailSubject).disposed(by: disposeBag)
       
        passwordTextField.rx.text.bind(to: SignUpViewModel.SignUpinstance.passwordSubject).disposed(by: disposeBag)
    
        phoneTextField.rx.text.bind(to: SignUpViewModel.SignUpinstance.numberSubject).disposed(by: disposeBag)
        
        conformPasswordTextField.rx.text.bind(to: SignUpViewModel.SignUpinstance.confirmPasswordSubject).disposed(by: disposeBag)
          
        SignUpViewModel.SignUpinstance.isValidForm.bind(to: submitButton.rx.isEnabled).disposed(by: disposeBag)
        
        submitButton.rx.tap.flatMap { data -> Completable in
            
            return Details.sharedInstance.saveDetails(name: self.nameTextField.text!, email: self.emailTextField.text!, phoneNum: self.phoneTextField.text!, password: self.passwordTextField.text!)
            
        }.subscribe(onError:{ err in
            print("error: \(err.localizedDescription)")
            
        }, onCompleted: {
            print("data saved")
            
        })
        
       }
    
    @IBAction func signUp(_ sender: Any) {
       
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: "detailsList") as! DetailsViewController
        self.navigationController?.pushViewController(detailsVC, animated: true)

    }
    

}
