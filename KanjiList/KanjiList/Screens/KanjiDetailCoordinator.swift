import UIKit

class KanjiDetailCoordinator: Coordinator {
  private let presenter: UINavigationController
  private var kanjiDetailViewController: KanjiDetailViewController?
  private var wordKanjiListViewController: KanjiListViewController?
  private let kanjiStorage: KanjiStorage
  private let kanji: Kanji

  init(presenter: UINavigationController,
       kanji: Kanji,
       kanjiStorage: KanjiStorage) {

    self.kanji = kanji
    self.presenter = presenter
    self.kanjiStorage = kanjiStorage
  }

  func start() {
    let kanjiDetailViewController = KanjiDetailViewController(nibName: nil, bundle: nil)
    kanjiDetailViewController.delegate = self
    kanjiDetailViewController.title = "Kanji details"
    kanjiDetailViewController.selectedKanji = kanji

    presenter.pushViewController(kanjiDetailViewController, animated: true)
    self.kanjiDetailViewController = kanjiDetailViewController
  }
}

extension KanjiDetailCoordinator: KanjiDetailViewControllerDelegate {
  func kanjiDetailViewControllerDidSelectWord(_ word: String) {
    let wordKanjiListViewController = KanjiListViewController(nibName: nil, bundle: nil)
    let kanjiForWord = kanjiStorage.kanjiForWord(word)
    wordKanjiListViewController.kanjiList = kanjiForWord
    wordKanjiListViewController.title = word
    wordKanjiListViewController.cellAccessoryType = .none

    presenter.pushViewController(wordKanjiListViewController, animated: true)

  }
}
