//
//  RandomPhotoViewModel.swift
//  UnsplashProject
//
//  Created by 박다혜 on 2023/09/18.
//

import Foundation

class RandomPhotoViewModel {

    var photo = Observable(URL(string: ""))

    func fetchPhoto() {

        APIService.shared.randomPhoto { result in
            guard let result = result else { return }
            self.photo.value = result
        }
    }

}
