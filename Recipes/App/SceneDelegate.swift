import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        start()
    }
    
    func start() {
        if onboarding {
            setRootViewController(makeTabbar())
        } else {
            onboarding = true
            setRootViewController(makeIntro())
        }
    }
    
    func setRootViewController(_ controller: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = controller
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
    private func makeIntro() -> UIViewController {
        let controller = IntroViewController(callback: { [weak self] in
            guard let self else {return}
            self.setRootViewController(self.makeOnboarding())
        })
        return controller
    }
    
    private func makeOnboarding() -> UIViewController {
        let controller = OnboardingViewController()
        controller.callback = { [weak self] in
            guard let self else {return}
            self.setRootViewController(self.makeTabbar())
        }
        return controller
    }
    
    private func makeTabbar() -> UIViewController {
        return TabBarViewController()
    }
    
    var onboarding: Bool {
        get {
            UserDefaults.standard.bool(forKey: "onboarding")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "onboarding")
        }
    }
}
