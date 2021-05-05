//
//  StoriesTableViewController.swift
//  NetworkApp
//
//  Created by Oksana Tugusheva on 01.05.2021.
//

import UIKit

class StoriesTableViewController: UITableViewController {
    
    private let activityIndicatorView = UIActivityIndicatorView()
    private var stories: [ArtStory] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset.top = 24
        setupActivityIndicator(in: tableView)
        fetchStories()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let storyVC = segue.destination as? StoryViewController else { return }
        storyVC.story = sender as? ArtStory
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        stories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath) as? StoryTableViewCell else {
            fatalError()
        }
        cell.configure(with: stories[indexPath.section])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension StoriesTableViewController {
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = stories[indexPath.section]
        performSegue(withIdentifier: "showStory", sender: story)
    }
}

// MARK: - Private Methods
extension StoriesTableViewController {
    private func setupActivityIndicator(in view: UIView) {
        activityIndicatorView.style = .large
        activityIndicatorView.color = .gray
        activityIndicatorView.center = CGPoint(
            x: view.frame.midX,
            y: view.frame.midY - (navigationController?.navigationBar.frame.maxY ?? 0)
        )
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
    }
    
    private func fetchStories() {
        NetworkManager.shared.fetch(
            url: ApiManager.shared.topArtStories,
            handler: { result in
                switch result {
                case .success(let value):
                    self.stories = ArtStory.getStories(from: value)
                case .failure(let error):
                    self.showErrorAlert(message: error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.tableView.reloadData()
                }
            }
        )
    }
    
    private func showErrorAlert(message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Error",
                message: message ?? "No error description",
                preferredStyle: .alert
            )

            let okAction = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}
