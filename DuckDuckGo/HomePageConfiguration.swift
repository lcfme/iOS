//
//  HomePageConfiguration.swift
//  DuckDuckGo
//
//  Copyright © 2018 DuckDuckGo. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
import Core

class HomePageConfiguration {
    
    enum ConfigName: Int {

        case simple
        case centerSearch
        case centerSearchAndFavorites

    }
    
    enum Component: Equatable {
        case privacyProtection
        case navigationBarSearch(withOffset: Bool, fixed: Bool)
        case centeredSearch(fixed: Bool)
        case favorites(withHeader: Bool)
        case padding(withOffset: Bool)
        case empty
    }
    
    let settings: HomePageSettings
    
    func components(withVariantManger variantManger: VariantManager = DefaultVariantManager()) -> [Component] {
       // return settings.homePage.components(withVariantManger: variantManger)

        let fixed = !settings.favorites || BookmarksManager().favoritesCount == 0

        var components = [Component]()
        switch settings.layout {
        case .navigationBar:
            components.append(.navigationBarSearch(withOffset: false, fixed: fixed))

        case .centered:
            components.append(.centeredSearch(fixed: fixed))
        }

        if settings.favorites {
            components.append(.favorites(withHeader: false))
        }

        return components
    }
    
    init(settings: HomePageSettings = HomePageSettings()) {
        self.settings = settings
    }
    
}
