
import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc2 = UINavigationController(rootViewController: MainViewController())
        let vc3 = UINavigationController(rootViewController: EventsViewController())
//        let vc4 = UINavigationController(rootViewController: MainViewController())
        
        
        
        vc2.tabBarItem.image = UIImage(systemName: "movieclapper")
        vc3.tabBarItem.image = UIImage(systemName: "music.quarternote.3")
//        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        vc2.title = "Фильмы"
        vc3.title = "Концерты"
//        vc4.title = "Downloads"
        
        tabBar.backgroundColor = .black
        
        tabBar.tintColor = .white
        
        setViewControllers([ vc2, vc3], animated: true)

    }


}

