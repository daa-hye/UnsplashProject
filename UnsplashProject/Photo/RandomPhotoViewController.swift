//
//  RandomPhotoViewController.swift
//  UnsplashProject
//
//  Created by 박다혜 on 2023/09/18.
//

import UIKit
import Kingfisher

class RandomPhotoViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var randomButton: UIButton!

    var viewModel = RandomPhotoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.photo.bind { url in
            guard let url = url else { return }
            DispatchQueue.main.async {
                self.imageView.kf.setImage(with: url)
            }
        }
        viewModel.fetchPhoto()

        randomButton.addTarget(self, action: #selector(randomButtonClicked), for: .touchUpInside)
    }

    @objc func randomButtonClicked() {
        viewModel.fetchPhoto()
    }

}
