//
//  StoriesTableViewController.swift
//  NetworkApp
//
//  Created by Oksana Tugusheva on 01.05.2021.
//

import UIKit

class StoriesTableViewController: UITableViewController {
    
    private var stories: [ArtStory] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset.top = 24
        fetchStories()
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
}

// MARK: - Private Methods
extension StoriesTableViewController {
    private func fetchStories() {
        guard let url = URL(string: ApiManager.shared) else { return }
        
        NetworkManager.fetch(url: url, closure: { (data: Data) in
            do {
                let response = try JSONDecoder().decode(ApiResponse.self, from: data)

                guard let results = response.results else { return }
                self.stories = results

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
    }
}