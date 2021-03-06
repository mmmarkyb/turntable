//
//  SearchResultsViewController.swift
//  turntable
//
//  Created by Mark Brown on 10/03/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import UIKit
import LBTAComponents

class SearchResultsController: DatasourceController, UISearchResultsUpdating {

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchData = SearchData()
        self.datasource = searchData
        collectionView.backgroundColor = .backgroundDarkBlack
    }
    
    // Use the current search string when an update to the search bar is made
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else { return }
        // Call the search API method and update view.
        SpotifyAPIHandler.shared.searchTracks(query: searchString) { (results) in
            SearchResultsManager.shared().searchResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 16 + 48)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // sets the cell style to highlight/unhighlighted
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? SearchResultCell
        cell?.didInteract(state: "highlight")
    }

    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? SearchResultCell
        cell?.didInteract(state: "unhighlight")
    }

    // when selecting an item add it to the queue and set the state to highlight until the call completes.
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? SearchResultCell
        if let track = cell?.searchItem {
            cell?.didInteract(state: "highlight")
            SessionQueue.shared().addToQueue(track: track) { (Bool) in
                cell?.itemStatusIndicator.image = UIImage(named: "inQueue")
                cell?.didInteract(state: "unhighlight")
            }
        }
    }

}
