//
//  SimpleCollectionViewController.swift
//  UnsplashProject
//
//  Created by 박다혜 on 2023/09/14.
//

import UIKit
import SnapKit

class SimpleCollectionViewController: UIViewController {

    enum Section: Int, CaseIterable {
        case first = 2000
        case second = 1
    }

    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

    var dataSource: UICollectionViewDiffableDataSource<Section, User>!

    let viewModel = SimpleViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        collectionView.delegate = self

        configureDataSource()

        viewModel.list.bind { user in
            self.updateSnapshot()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
            self.viewModel.append()
        }

    }

    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()

        snapshot.appendSections(Section.allCases) //이렇게도됨
        snapshot.appendItems(viewModel.list2, toSection: Section.second)
        snapshot.appendItems(viewModel.list.value, toSection: Section.first)

        dataSource.apply(snapshot)
    }

    static private func createLayout() -> UICollectionViewLayout {

        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemTeal
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout

    }

    private func configureDataSource() {

        // UICollectoinView.CellRegistration : ios14, 메서드 대신 제네릭 사용, 셀이 생성될 때마다 클로저 호출
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, User>(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.textProperties.color = .blue
            content.secondaryText = "\(itemIdentifier.age)"
            content.image = UIImage(systemName: "star.fill")
            content.imageProperties.tintColor = .yellow
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 20
            cell.contentConfiguration = content

            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2
            backgroundConfig.strokeColor = .cyan
            cell.backgroundConfiguration = backgroundConfig

        })

        //CellForItemAt
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in

            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })

    }

}

extension SimpleCollectionViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.insertUser(name: searchBar.text!)
    }

}

extension SimpleCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let user = dataSource.itemIdentifier(for: indexPath) else {
            return
        }

        dump(user)
        //viewModel.removeUser(idx: indexPath.row)
    }

}


//extension SimpleCollectionViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
//        return cell
//    }
//
//}
