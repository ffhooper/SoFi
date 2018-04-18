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
        print(loadJson())
    }
    
    func loadJson() -> [Member]? {
        //        if let url = Bundle.main.url(forResource: "team", withExtension: "json") {
        //            do {
        //                let data = try Data(contentsOf: url)
        //                let decoder = JSONDecoder()
        //                let jsonData = try decoder.decode([Member].self, from: data)
        //                return jsonData
        //            } catch {
        //                print("error:\(error)")
        //            }
        //        }
        //        return nil
        
//        if let path = Bundle.main.path(forResource: "team", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                //                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//                //                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
//                //                    // do stuff
//                //                }
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode([Member].self, from: data)
//                return jsonData
//            } catch {
//                // handle error
//
//            }
//        }
        
        /////////////////
//        if let path = Bundle.main.path(forResource: "team", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//                if let jsonResult = jsonResult as? <Any> {
//                    // do stuff
//                    print(jsonResult)
//                }
//            } catch {
//                // handle error
//            }
//        }
///////////////////////////////
        do {
            if let file = Bundle.main.url(forResource: "team", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode([Member].self, from: data)
//                print(jsonData)
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    print(object)
                } else if let object = json as? [Any] {
                    // json is an array
                    print(object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        
        
        
        
        
        return nil
    }
    
    
    @IBAction func image1(_ sender: UILongPressGestureRecognizer) {
        print("image1")
    }
    
    
    
}

