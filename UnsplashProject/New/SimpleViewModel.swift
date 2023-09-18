//
//  SimpleViewModel.swift
//  UnsplashProject
//
//  Created by 박다혜 on 2023/09/18.
//

import Foundation

class SimpleViewModel {

    let list: Observable<[User]> = Observable([])

    let list2 = [User(name: "dahye", age: 10),
                User(name: "아냐", age: 9),
                User(name: "피카츄", age: 21),
                User(name: "파이리", age: 20),
                User(name: "꼬부기", age: 20)]

    func append() {
        list.value = [User(name: "Hue", age: 23),
                    User(name: "Hue", age: 23),
                    User(name: "Jack", age: 21),
                    User(name: "Bran", age: 20),
                    User(name: "Kokojong", age: 20)]
    }

    func remove() {
        list.value = []
    }

    func removeUser(idx: Int) {
        list.value.remove(at: idx)
    }

    func insertUser(name: String) {
        let value = User(name: name, age: Int.random(in: 10...70))
        list.value.insert(value, at: Int.random(in: 0...2))
    }
    
}
