import UIKit

final class HomeViewController: UIViewController {
    private let store = TrendingStore()
    private var bag = Bag()
    private var recipes: [Recipe] = [] { didSet { collectionView.reloadData()}}
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private let searchResult = SearchResultViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        setupSearchBar()
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Get amazing recipes"
        store.sendAction(.get)
        setupObservers()
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font : UIFont.preferredFont(forTextStyle: .largeTitle)
        ]
        
    }
}
//MARK: - Setup Views
private extension HomeViewController {
    func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .done(let recipes):
                    self.recipes = recipes
                }
            }.store(in: &bag)
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: TrendingCell.identifier)
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.identifier)
        collectionView.register(RecentCell.self, forCellWithReuseIdentifier: RecentCell.identifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: searchResult)
        searchController.isActive = true
        searchController.searchBar.placeholder = "Search recipes"
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
}
//MARK: - Layout
private extension HomeViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let section = HomeSection.allCases[sectionIndex]
            switch section {
            case .trending: return self.createTrendingSection()
            case .popular: return self.createPopularSection()
            case .recent: return self.createRecentSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    func createTrendingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .estimated(254))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let section = NSCollectionLayoutSection(group: layoutGroup)
        section.boundarySupplementaryItems = [createSectionHeader()]
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    func createPopularSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let bannerItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let bannerGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(150),
            heightDimension: .absolute(231)
        )
        let bannerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bannerGroupSize, subitems: [bannerItem])
        
        let section = NSCollectionLayoutSection(group: bannerGroup)
        section.boundarySupplementaryItems = [self.createSectionHeader()]
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    func createRecentSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let bannerItem = NSCollectionLayoutItem(layoutSize: itemSize)
        bannerItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let bannerGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(124),
            heightDimension: .absolute(190)
        )
        let bannerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bannerGroupSize, subitems: [bannerItem])
        
        let section = NSCollectionLayoutSection(group: bannerGroup)
        section.interGroupSpacing = 10
        section.boundarySupplementaryItems = [self.createSectionHeader()]
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    func createTeamSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let bannerItem = NSCollectionLayoutItem(layoutSize: itemSize)
        bannerItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let bannerGroupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(110),
            heightDimension: .absolute(136)
        )
        let bannerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bannerGroupSize, subitems: [bannerItem])
        
        let section = NSCollectionLayoutSection(group: bannerGroup)
        section.interGroupSpacing = 10
        section.boundarySupplementaryItems = [self.createSectionHeader()]
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(54)
        )
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        return layoutSectionHeader
    }
}
//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        HomeSection.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipes.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let section = HomeSection.allCases[indexPath.section]
        switch section {
        case .trending:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrendingCell.identifier,
                for: indexPath
            ) as? TrendingCell else { fatalError()}
            cell.configure(with: recipes[indexPath.item])
            return cell
        case .popular:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PopularCell.identifier,
                for: indexPath
            ) as? PopularCell else { fatalError()}
            cell.configure(with: recipes[indexPath.item])
            return cell
        case .recent:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecentCell.identifier,
                for: indexPath
            ) as? RecentCell else { fatalError()}
            cell.configure(with: recipes[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderView.identifier,
            for: indexPath
        ) as? SectionHeaderView else { fatalError()}
        let section = HomeSection.allCases[indexPath.section]
        switch section {
        case .trending: header.configure(with: section.title, target: self, action: #selector(trendingAction))
        case .popular:  header.configure(with: section.title, target: self, action: #selector(popularAction))
        case .recent:   header.configure(with: section.title, target: self, action: #selector(recentAction))
        }
        return header
    }
    
    @objc private func trendingAction() {
        print(#function)
    }
    
    @objc private func popularAction() {
        print(#function)
    }
    
    @objc private func recentAction() {
        print(#function)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchResult.query = searchController.searchBar.text ?? ""
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: HomeViewController())
}
