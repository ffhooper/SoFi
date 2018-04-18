//
//  ViewController.swift
//  SoFi
//
//  Created by Riley Hooper on 3/31/18.
//  Copyright © 2018 Riley Hooper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var profileInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let members = loadJson4Test()
        profileInfoLabel.text = members?.first?.bio
        
        print(loadJson4Test())
    }
    
    func loadJson4Test() -> [Member]? {
        if let url = Bundle.main.url(forResource: "team", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Member].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    
    @IBAction func image1(_ sender: UILongPressGestureRecognizer) {
        print("image1")
    }
    
    
    
}

