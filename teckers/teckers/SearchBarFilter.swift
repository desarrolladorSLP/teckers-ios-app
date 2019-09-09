//
//  SearchBarFilter.swift
//  teckers
//
//  Created by Maggie Mendez on 9/4/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import UIKit

class SearchBarFilter: NSObject, UISearchBarDelegate{
    var messagesList : [MessagesUser]?
    var searchList : [MessagesUser]?
    var reload : () -> Void
    var searching : Bool = false
    init(reload : @escaping () -> Void) {
        self.reload = reload
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchList = messagesList
            reload()
            return
        }
        searchList = messagesList?.filter({ (message) -> Bool in
            searching = true
            if (message.containsInMessages(text: searchText).count != 0 ) || message.containsInFriend(text: searchText){
                return true
            }
            else{
                return false
            }
        })
        reload()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        reload()
    }
}
