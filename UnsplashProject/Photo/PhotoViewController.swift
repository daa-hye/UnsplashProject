//
//  PhotoViewController.swift
//  UnsplashProject
//
//  Created by 박다혜 on 2023/09/12.
//

import UIKit
import Kingfisher

class PhotoViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var viewModel = PhotoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchPhoto()
        tableView.rowHeight = 200

        viewModel.list.bind { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        tableView.delegate = self
        tableView.dataSource = self

    }
}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell")!

        let data = viewModel.cellForRowAt(at: indexPath)
        cell.imageView?.kf.setImage(with: data)
        return cell
    }
}

