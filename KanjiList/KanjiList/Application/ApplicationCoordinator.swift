import UIKit

class ApplicationCoordinator: Coordinator {
  let kanjiStorage: KanjiStorage
  let window: UIWindow
  let rootViewController: UINavigationController

  let allKanjiListCoordinator: AllKanjiListCoordinator

  init(window: UIWindow) {
    self.window = window
    kanjiStorage = KanjiStorage()
    rootViewController = UINavigationController()
    rootViewController.navigationBar.prefersLargeTitles = true

//    let emptyViewController = UIViewController()
//    emptyViewController.view.backgroundColor = .cyan
//    rootViewController.pushViewController(emptyViewController, animated: false)

    allKanjiListCoordinator = AllKanjiListCoordinator(presenter: rootViewController,
                                                      kanjiStorage: kanjiStorage)
  }

  func start() {
    window.rootViewController = rootViewController
    allKanjiListCoordinator.start()
    
    window.makeKeyAndVisible()
  }
}
