//
//  RTTabView.swift
//  Romato
//
//  Created by Jithin M on 17/07/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import SwiftUI

enum RTTab : Int {
    
    case Home
    case Search
    case WatchList
    case Favorites
    case Settings
    
    var image : String {
        switch self {
        case .Home:
            return "homeTab"
        case .Search:
            return "searchTab"
        case .WatchList:
            return "watchListTab"
        case .Favorites:
            return "favoriteTab"
        case .Settings:
            return "accountTab"
        }
    }
    
    var tabName : String {
        switch self {
        case .Home:
            return "Home"
        case .Search:
            return "Search"
        case .WatchList:
            return "WatchLater"
        case .Favorites:
            return "Favorites"
        case .Settings:
            return "Account"
        }
    }
    
    func contentView() -> AnyView {
        switch self {
            case .Home:
            return AnyView(HomeView())
            case .Search:
            return AnyView(SearchView())
            case .WatchList:
            return AnyView(WatchListView())
            case .Favorites:
            return AnyView(FavouritesListView())
            case .Settings:
            return AnyView(SettingsView())
        }
    }
    
}

struct RTTabView: View {
    
    @State var tabs : [RTTab]
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(tabs, id: \.self) { tab in
                tab.contentView().tabItem {
                    Image(tab.image)
                    Text(tab.tabName)
                }
            }
        }
    }
}

struct RTTabView_Previews: PreviewProvider {
    static var previews: some View {
        RTTabView(tabs: [.Home,.Search,.Favorites,.WatchList,.Settings])
    }
}
