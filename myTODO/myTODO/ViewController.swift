//
//  ViewController.swift
//  myTODO
//
//  Created by 山根大生 on 2020/08/27.
//  Copyright © 2020 taisei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let TODO = ["牛乳を買う", "掃除をする", "アプリ開発の勉強をする"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.placeholder = "TODOを入力してください"
        textField.clearButtonMode = .always
        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TODO.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TODOCell" , for: indexPath)
        cell.textLabel!.text = TODO[indexPath.row]
        return cell
    }
}

