//
//  StoriesTableViewController.swift
//  NetworkApp
//
//  Created by Oksana Tugusheva on 01.05.2021.
//

import UIKit

class StoriesTableViewController: UITableViewController {
    
    private var stories: [ArtStory] = []
    private var loadingStories = true

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset.top = 24
        fetchStories()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        loadingStories ? 1 : stories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if loadingStories {
            tableView.separatorColor = tableView.backgroundColor
            return tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
        } else {
            tableView.separatorColor = .separator
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath) as? StoryTableViewCell else {
                fatalError()
            }
            cell.configure(with: stories[indexPath.section])
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension StoriesTableViewController {
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
}

// MARK: - Private Methods
extension StoriesTableViewController {
    private func fetchStories() {
        NetworkManager.shared.fetch(
            url: ApiManager.shared.topArtStories,
            handler: { result in
                self.loadingStories = false
                
                switch result {
                case .failure(let error):
                    switch error {
                    case .badResponse(message: let message): self.showErrorAlert(message: message)
                    }
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(ApiResponse.self, from: data)
                        guard let results = response.results else { return }
                        self.stories = results
                    } catch let error {
                        self.showErrorAlert(message: error.localizedDescription)
                    }
                }
                
                DispatchQueue.main.async {
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
