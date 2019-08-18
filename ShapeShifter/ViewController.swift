//
//  ViewController.swift
//  ShapeShifter
//
//  Created by tskim on 18/08/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchCloseView: SearchCloseView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func startTap(_ sender: Any) {
        searchCloseView.toggle()
    }
}

