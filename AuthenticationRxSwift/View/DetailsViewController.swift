//
//  DetailsViewController.swift
//  AuthenticationRxSwift
//
//  Created by Chandrasheela Hotkar on 24/03/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import CoreData

class DetailsViewController: UIViewController {
    
    var detailList : [Detail] = []

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataBinding()
        // Do any additional setup after loading the view.
    }
    
    
    func dataBinding(){
        
        Details.sharedInstance.fetchDetails().bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: DetailsTableViewCell.self)){ [self] (_, list, cell) in
            cell.nameLabel.text = list.name
            cell.emaillabel.text = list.email
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


