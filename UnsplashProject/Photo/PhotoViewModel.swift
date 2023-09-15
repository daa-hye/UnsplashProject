//
//  PhotoViewModel.swift
//  UnsplashProject
//
//  Created by 박다혜 on 2023/09/12.
//

import Foundation

class PhotoViewModel {

    var list = Observable(Photo(total: 0, total_pages: 0, results: []))

    func fetchPhoto() {

        APIService.shared.searchPhoto(query: "sea") { photo in
            guard let photo = photo else { return }
            self.list.value = photo
        }

    }

    var rowCount: Int {
        return list.value.results?.count ?? 0
    }

    func cellForRowAt(at indexPath: IndexPath) -> URL {
        return URL(string: list.value.results![indexPath.row].urls.thumb)!
    }

}
