//
//  ViewController.swift
//  APINetworking
//
//  Created by Consultant on 12/29/22.
//

//HW-1: Use any open source api and utilize it in your app, use URLSession networking to fetch data and parse it and show this in your app. Use Swift and MVVM for this tasks.

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //print("Testing Commit")
        var networkingModel = NetworkingModel()
        networkingModel.loadData(fileName: "https://swapi.dev/api/films")
        
    }


}

