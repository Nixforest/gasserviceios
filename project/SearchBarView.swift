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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchBarTableViewCell")! as UITableViewCell
            if(searchActive){
                cell.textLabel?.text = filtered[(indexPath as NSIndexPath).row]
            } else {
                cell.textLabel?.text = data[(indexPath as NSIndexPath).row];
            }
            
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height:CGFloat = 50
        return height
    }

    //search bar action
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        searchBarTable.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    

}
