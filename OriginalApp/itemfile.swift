//
//  itemfile.swift
//  OriginalApp
//
//  Created by 金井菜津希 on 2023/07/09.
//

import Foundation
import RealmSwift

class item: Object{
    @Persisted var title: String = ""
    @Persisted var date: Int = 0
    @Persisted var isMarked: Bool = false
}
