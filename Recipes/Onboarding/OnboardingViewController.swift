import UIKit

class OnboardingViewController: UIPageViewController {
    
    private var pages = [UIViewController]()
    private let pageControl = CustomPageControl()
    private let initialPage = 0
    
    // Ограничения для анимации
    private var pageControlBottomAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

// MARK: - Настройка, стилизация и компоновка
private extension OnboardingViewController {
    // Метод для настройки контроллера
    func setup() {
        dataSource = self
        delegate = self
        
        // Создание страниц онбординга
        let page1 = ContentViewController(
            imageName: "onboarding",
            titleText: "Best Recipe",
            subtitleText: "Find best recipes for cooking.",
            buttonText: "Get started",
            showSkipButton: false,
            isFirstPage: true,
            delegate: self
        )
        
        let page2 = ContentViewController(
            imageName: "onboarding1",
            titleText: "Recipes from all over the World",
            subtitleText: "",
            buttonText: "Continue",
            showSkipButton: true,
            isFirstPage: false,
            delegate: self
        )
        
        let page3 = ContentViewController(
            imageName: "onboarding2",
            titleText: "Recipes with each and every detail",
            subtitleText: "",
            buttonText: "Continue",
            showSkipButton: true,
            isFirstPage: false,
            delegate: self
        )
        
        let page4 = ContentViewController(
            imageName: "onboarding3",
            titleText: "Cook it now or save it for later",
            subtitleText: "",
            buttonText: "Start Cooking",
            showSkipButton: false,
            isFirstPage: false,
            delegate: self
        )
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        
        // Установка начальной страницы
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    // Метод для стилизации элементов
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = pages.count - 1 // не учитываем первую страницу
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
    }
    
    // Метод для установки ограничений (констрейнтов) на элементы
    func layout() {
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
        
        // Установка ограничения для анимаций
        pageControlBottomAnchor = pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        pageControlBottomAnchor?.isActive = true
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    // Метод для получения предыдущей страницы
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        return currentIndex == 0 ? nil : pages[currentIndex - 1]
    }
    
    // Метод для получения следующей страницы
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        return currentIndex < pages.count - 1 ? pages[currentIndex + 1] : nil
    }
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDelegate {
    // Метод, вызываемый при завершении анимации перехода между страницами
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let viewControllers = pageViewController.viewControllers, let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        // Обновляем текущую страницу только если это не первая страница
        pageControl.currentPage = currentIndex > 0 ? currentIndex - 1 : 0
        animateControlsIfNeeded(currentIndex: currentIndex)
    }
    
    // Метод для анимации элементов в зависимости от текущей страницы
    private func animateControlsIfNeeded(currentIndex: Int) {
        if currentIndex == 0 {
            hideControls()
        } else {
            showControls()
        }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // Метод для скрытия элементов управления
    private func hideControls() {
        pageControl.isHidden = true
    }
    
    // Метод для показа элементов управления
    private func showControls() {
        pageControl.isHidden = false
    }
}

// MARK: - ContentViewControllerDelegate
extension OnboardingViewController: ContentViewControllerDelegate {
    // Метод, вызываемый при нажатии на кнопку действия на странице онбординга
    func didTapActionButton(on viewController: ContentViewController) {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return }
        if viewController.buttonText == "Start Cooking" {
            navigateToTrending()
        } else {
            let nextIndex = currentIndex + 1
            if nextIndex < pages.count {
                setViewControllers([pages[nextIndex]], direction: .forward, animated: true, completion: nil)
                pageControl.currentPage = nextIndex - 1
                animateControlsIfNeeded(currentIndex: nextIndex)
            }
        }
    }
    
    // Метод, вызываемый при нажатии на кнопку пропуска
    func didTapSkipButton(on viewController: ContentViewController) {
        let lastPageIndex = pages.count - 1
        setViewControllers([pages[lastPageIndex]], direction: .forward, animated: true, completion: nil)
        pageControl.currentPage = lastPageIndex - 1
        animateControlsIfNeeded(currentIndex: lastPageIndex)
    }
    
    // Метод для перехода к экрану Trending
    private func navigateToTrending() {
        let trendingVC = TrendingViewController()
        trendingVC.modalPresentationStyle = .fullScreen
        present(trendingVC, animated: true, completion: nil)
    }
}

// MARK: - Actions
private extension OnboardingViewController {
    // Метод, вызываемый при нажатии на pageControl
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let index = sender.currentPage + 1
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
        animateControlsIfNeeded(currentIndex: index)
    }
    
    // Метод, вызываемый при нажатии на кнопку пропуска
    @objc func skipTapped(_ sender: UIButton) {
        let lastPageIndex = pages.count - 1
        setViewControllers([pages[lastPageIndex]], direction: .forward, animated: true, completion: nil)
        pageControl.currentPage = lastPageIndex - 1
        animateControlsIfNeeded(currentIndex: lastPageIndex)
    }
}

// MARK: - UIPageViewController Extensions
private extension UIPageViewController {
    // Метод для перехода на следующую страницу
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?.first, let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    // Метод для перехода на предыдущую страницу
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?.first, let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        setViewControllers([prevPage], direction: .reverse, animated: animated, completion: completion)
    }
    
    // Метод для перехода на конкретную страницу
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}
