//
//  PhotoViewController.swift
//  UnsplashProject
//
//  Created by 박다혜 on 2023/09/12.
//

import UIKit
import Kingfisher

class PhotoViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!

    var viewModel = PhotoViewModel()

    var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()

        viewModel.list.bind { _ in
            self.updateSnapshot()
        }
    }

    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.list.value.results!)
        dataSource.apply(snapshot)
    }

    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemTeal
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout

    }

    private func configureDataSource() {

        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, PhotoResult> { cell, indexPath, itemIdentifier in

            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)"

            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)!
                let data = try? Data(contentsOf: url)

                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
        }

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in

            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
}

extension PhotoViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchPhoto(text: searchBar.text!)
    }

}
