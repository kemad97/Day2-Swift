//
//  ViewController.swift
//  Day2 swift
//
//  Created by Kerolos on 27/04/2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tf_setSalary: UITextField!
    
    @IBOutlet weak var label_salary: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func btnEmployee(_ sender: Any) {
        
        guard let salText = tf_setSalary.text ,
              let enteredSalary = Double (salText)
                else
        {
            label_salary.text="Inv Salary"
            return
        }
        
        let emp = Employee(salary: enteredSalary)
        label_salary.text = String ( emp.getSalary() )
        
        
    }
    
    @IBAction func btnManager(_ sender: Any) {

        guard let salText = tf_setSalary.text ,
              let enteredSalary = Double (salText)
        else{
            label_salary.text="Inv Salary"
            return

        }
        
        let manger = Manager(salary: enteredSalary)
        label_salary.text = String ( manger.getSalary() )

        
        
    }
}

