//
//  ComicDetailScreenViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/24/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class ComicDetailScreenViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private weak var comicFadeImageView: UIImageView!
    @IBOutlet private weak var comicImageCover: UIImageView!
    @IBOutlet private weak var seriesTitleLabel: UILabel!
    @IBOutlet private weak var storyTitleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
