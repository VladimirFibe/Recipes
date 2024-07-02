import UIKit

class OnboardingViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    
    let pageControl = UIPageControl()
    let skipButton = UIButton()
    let initialPage = 0
    
    // Constraints for animation
    var skipButtonBottomAnchor: NSLayoutConstraint?
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
        
        let page1 = ContentViewController(imageName: "onboarding", titleText: "Best Recipe", subtitleText: "Find best recipes for cooking.", buttonText: "Get started", isFirstPage: true, delegate: self)
        let page2 = ContentViewController(imageName: "onboarding1", titleText: "Recipes from all over the World", subtitleText: "Explore recipes from different cultures.", buttonText: "Continue", isFirstPage: false, delegate: self)
        let page3 = ContentViewController(imageName: "onboarding2", titleText: "Recipes with each and every detail", subtitleText: "Detailed steps to ensure perfect results.", buttonText: "Continue", isFirstPage: false, delegate: self)
        let page4 = ContentViewController(imageName: "onboarding3", titleText: "Cook it now or save it for later", subtitleText: "Save your favorite recipes and cook them anytime.", buttonText: "Start cooking", isFirstPage: false, delegate: self)
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitleColor(.systemBlue, for: .normal)
        skipButton.setTitle("Skip", for: .normal)
        skipButton.addTarget(self, action: #selector(skipTapped(_:)), for: .primaryActionTriggered)
    }
    
    func layout() {
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            skipButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20)
        ])
        
        // for animations
        skipButtonBottomAnchor = skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        pageControlBottomAnchor = pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
        
        skipButtonBottomAnchor?.isActive = true
        pageControlBottomAnchor?.isActive = true
    }
}

// MARK: - DataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return pages.first
        }
    }
}

// MARK: - Delegates
extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        pageControl.currentPage = currentIndex
        animateControlsIfNeeded()
    }
    
    private func animateControlsIfNeeded() {
        let lastPage = pageControl.currentPage == pages.count - 1
        if lastPage {
            hideControls()
        } else {
            showControls()
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideControls() {
        pageControlBottomAnchor?.constant = -80
        skipButtonBottomAnchor?.constant = -80
    }
    
    private func showControls() {
        pageControlBottomAnchor?.constant = 16
        skipButtonBottomAnchor?.constant = 16
    }
}

extension OnboardingViewController: ContentViewControllerDelegate {
    func didTapActionButton(on viewController: ContentViewController) {
        if let currentIndex = pages.firstIndex(of: viewController) {
            if viewController.buttonText == "Start cooking" {
                navigateToTrending()
            } else {
                let nextIndex = currentIndex + 1
                if nextIndex < pages.count {
                    pageControl.currentPage = nextIndex
                    goToSpecificPage(index: nextIndex, ofViewControllers: pages)
                }
            }
        }
    }

    func navigateToTrending() {
        let trendingVC = TrendingViewController()
        trendingVC.modalPresentationStyle = .fullScreen
        present(trendingVC, animated: true, completion: nil)
    }
}

// MARK: - Actions
extension OnboardingViewController {
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        animateControlsIfNeeded()
    }
    
    @objc func skipTapped(_ sender: UIButton) {
        let lastPageIndex = pages.count - 1
        pageControl.currentPage = lastPageIndex
        goToSpecificPage(index: lastPageIndex, ofViewControllers: pages)
        animateControlsIfNeeded()
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
