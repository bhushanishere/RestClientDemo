//
//  ViewController.swift
//  RestClientDemo
//
//  Created by Bhushan  Borse on 18/07/20.
//  Copyright © 2020 Bhushan  Borse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getEmployeeDetailsFromServer()
    }
    
    func getEmployeeDetailsFromServer() {
        RestClient().callApi(api: "http://dummy.restapiexample.com/api/v1/employees", completion: { (result) in
            
            /// Do stuff after got responce...
            
        }, type: .GET, data: nil, isAbsoluteURL: true, headers: nil, isSilent: false, jsonSerialize: false)
    }



}

