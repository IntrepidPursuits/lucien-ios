//
//  LendingViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/9/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

class LendingViewController: UIViewController {

    //    var collectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var myArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
    let rows = 3
    let columnsInFirstPage = 5
    // calculate number of columns needed to display all items
    var columns: Int { return myArray.count<=columnsInFirstPage ? myArray.count : myArray.count > rows*columnsInFirstPage ? (myArray.count-1)/rows + 1 : columnsInFirstPage }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columns*rows
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
        //These three lines will convert the index to a new index that will simulate the collection view as if it was being filled horizontally
        let i = indexPath.item / rows
        let j = indexPath.item % rows
        let item = j*columns+i

        guard item < myArray.count else {
            //If item is not in myArray range then return an empty hidden cell in order to continue the layout
            cell.isHidden = true
            return cell
        }
        cell.isHidden = false

        //Rest of your cell setup, Now to access your data You need to use the new "item" instead of "indexPath.item"
        //like: cell.myLabel.text = "\(myArray[item])"

        return cell
    }
}
