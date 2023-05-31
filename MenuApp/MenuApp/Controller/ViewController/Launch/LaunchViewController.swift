//
//  LaunchViewController.swift
//  MenuApp
//
//  Created by Blu on 2023/05/31.
//

import UIKit

class LoadingViewController: UIViewController {

    lazy var movingView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "AppLogo")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(movingView)
        view.backgroundColor = .white
        movingView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            movingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            movingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movingView.widthAnchor.constraint(equalToConstant: 100),
            movingView.heightAnchor.constraint(equalToConstant: 100)
        ])

        startMovingAnimation()
        finishAnimation()
    }

    private func startMovingAnimation() {
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseInOut, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                self.movingView.transform = CGAffineTransform(rotationAngle: .pi)
                self.movingView.transform = self.movingView.transform.scaledBy(x: 0.2, y: 0.2)

            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.movingView.transform = CGAffineTransform(rotationAngle: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 0.5) {
                self.movingView.transform = CGAffineTransform(rotationAngle: .pi)

            }
            UIView.addKeyframe(withRelativeStartTime: 1.5, relativeDuration: 0.5) {
                self.movingView.transform = CGAffineTransform(rotationAngle: 0)

            }
            UIView.addKeyframe(withRelativeStartTime: 1.9, relativeDuration: 0.1) {
                self.movingView.frame = self.movingView.frame.offsetBy(dx: -300, dy: 0)
                self.movingView.transform = self.movingView.transform.scaledBy(x: 1.5, y: 1.5)
            }
        }, completion: nil)
    }

    private func finishAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            let newViewController = MenuTabBarController()
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true, completion: nil)
        }
        return
    }
}

import SwiftUI

struct ViewController_Previews: PreviewProvider {   // 이름 바꿔도 됨

    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }

    struct Container: UIViewControllerRepresentable {

        func makeUIViewController(context: Context) -> UIViewController {
            return LoadingViewController()    // <- 미리 볼 뷰컨 인스턴스
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

        }

    }

}
