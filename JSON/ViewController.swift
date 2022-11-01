//
//  ViewController.swift
//  JSON
//
//  Created by Вадим Сайко on 1.11.22.
//

import UIKit

// MARK: - Comments
struct Comments: Codable {
    let comments: [Comment]
    let total, skip, limit: Int
    
    enum CodingKeys: String, CodingKey {
        case comments
        case total
        case skip
        case limit
    }
//  парсинг руками
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.comments = try container.decode([Comment].self, forKey: .comments)
        self.total = try container.decode(Int.self, forKey: .total)
        self.skip = try container.decode(Int.self, forKey: .skip)
        self.limit = try container.decode(Int.self, forKey: .limit)
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id: Int
    let body: String
    let postID: Int
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case body
        case postID = "postId"
        case user
    }
//    парсинг руками
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.body = try container.decode(String.self, forKey: .body)
        self.postID = try container.decode(Int.self, forKey: .postID)
        self.user = try container.decode(User.self, forKey: .user)
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let username: String
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let mainUrl = Bundle.main.url(forResource: "JSON", withExtension: "json") else {return}
        do {
            let data = try Data(contentsOf: mainUrl)
            let decoder = JSONDecoder()
            let finalData = try decoder.decode(Comments.self, from: data)
            print(finalData)
        } catch {
            print(error)
        }
    }
}

