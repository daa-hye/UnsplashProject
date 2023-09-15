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

    let list = [User(name: "Hue", age: 23),
                User(name: "Hue", age: 23),
                User(name: "Jack", age: 21),
                User(name: "Bran", age: 20),
                User(name: "Kokojong", age: 20)]

    let list2 = [User(name: "dahye", age: 10),
                User(name: "Hue", age: 23),
                User(name: "Jack", age: 21),
                User(name: "Bran", age: 20),
                User(name: "Kokojong", age: 20)]

    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!

    var dataSource: UICollectionViewDiffableDataSource<Section, User>!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })

        // UICollectoinView.CellRegistration : ios14, 메서드 대신 제네릭 사용, 셀이 생성될 때마다 클로저 호출
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
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

        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        snapshot.appendSections(Section.allCases) //이렇게도됨
        snapshot.appendItems(list, toSection: Section.second)
        snapshot.appendItems(list2, toSection: Section.first)

        dataSource.apply(snapshot)

    }

    static func createLayout() -> UICollectionViewLayout {

        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemTeal
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout

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
