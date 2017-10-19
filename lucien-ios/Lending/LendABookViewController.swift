//
//  LendABookViewController.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/19/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

class LendABookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var comicPhoto: UIImageView!
    @IBOutlet weak var seriesTitleLabel: UILabel!
    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableViewDelegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
