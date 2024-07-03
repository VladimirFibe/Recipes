import UIKit

class OnboardingViewController: UIPageViewController {
    var pages = [UIViewController]()
    let pageControl = CustomPageControl() // Используем кастомный PageControl
    let initialPage = 0
    
    // Ограничения для анимации
    var pageControlBottomAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension OnboardingViewController {
    func setup() {
        dataSource = self
        delegate = self
        
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
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = pages.count - 1 // не учитываем первую страницу
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
    }
    
    func layout() {
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
        
        // для анимаций
        pageControlBottomAnchor = pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        pageControlBottomAnchor?.isActive = true
    }
}

// MARK: - DataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == 0 {
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return nil
        }
    }
}

// MARK: - Delegates
extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        // Обновляем текущую страницу только если это не первая страница
        if currentIndex > 0 {
            pageControl.currentPage = currentIndex - 1
        }
        
        animateControlsIfNeeded(currentIndex: currentIndex)
    }
    
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
    
    private func hideControls() {
        pageControl.isHidden = true
    }
    
    private func showControls() {
        pageControl.isHidden = false
    }
}

// MARK: - ContentViewControllerDelegate
extension OnboardingViewController: ContentViewControllerDelegate {
    func didTapActionButton(on viewController: ContentViewController) {
        if let currentIndex = pages.firstIndex(of: viewController) {
            if viewController.buttonText == "Start Cooking" {
                navigateToTrending()
            } else {
                let nextIndex = currentIndex + 1
                if nextIndex < pages.count {
                    setViewControllers([pages[nextIndex]], direction: .forward, animated: true, completion: nil)
                    if nextIndex > 0 {
                        pageControl.currentPage = nextIndex - 1
                    }
                    animateControlsIfNeeded(currentIndex: nextIndex)
                }
            }
        }
    }
    
    func didTapSkipButton(on viewController: ContentViewController) {
        let lastPageIndex = pages.count - 1
        setViewControllers([pages[lastPageIndex]], direction: .forward, animated: true, completion: nil)
        pageControl.currentPage = lastPageIndex - 1
        animateControlsIfNeeded(currentIndex: lastPageIndex)
    }
    
    private func navigateToTrending() {
        let trendingVC = TrendingViewController()
        trendingVC.modalPresentationStyle = .fullScreen
        present(trendingVC, animated: true, completion: nil)
    }
}

// MARK: - Actions
extension OnboardingViewController {
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let index = sender.currentPage + 1
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
        animateControlsIfNeeded(currentIndex: index)
    }
    
    @objc func skipTapped(_ sender: UIButton) {
        let lastPageIndex = pages.count - 1
        setViewControllers([pages[lastPageIndex]], direction: .forward, animated: true, completion: nil)
        pageControl.currentPage = lastPageIndex - 1
        animateControlsIfNeeded(currentIndex: lastPageIndex)
    }
}

// MARK: - Extensions
extension UIPageViewController {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}
