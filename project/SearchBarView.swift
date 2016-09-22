//
//  SearchBarView.swift
//  project
//
//  Created by Lâm Phạm on 9/21/16.
//  Copyright © 2016 admin. All rights reserved.
//

import UIKit

class SearchBarView: UIView, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchBarTable: UITableView!
    @IBOutlet weak var searchBarTableViewCell: UITableViewCell!
    
    var filtered:[String] = []
    var searchActive : Bool = false
    var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("searchBarTableViewCell")! as UITableViewCell
            if(searchActive){
                cell.textLabel?.text = filtered[indexPath.row]
            } else {
                cell.textLabel?.text = data[indexPath.row];
            }
            
            return cell;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height:CGFloat = 50
        return height
    }

    //search bar action
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        searchBarTable.reloadData()
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    

}
