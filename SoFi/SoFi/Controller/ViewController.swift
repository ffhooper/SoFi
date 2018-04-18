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
    
    var imageURLS = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let members = loadJson4Test()
        print(members)
        profileInfoLabel.text = members?.first?.bio
        if let members = members {
            for member in members {
                if let url = member.avatar {
                    imageURLS.append(url)
                }
            }
        }
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

