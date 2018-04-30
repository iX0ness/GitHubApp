//
//  Owner.swift
//  GitHubApp
//
//  Created by Levchuk Misha on 29.04.2018.
//  Copyright © 2018 Levchuk Misha. All rights reserved.
//

import Foundation

struct Owner : Codable {
	let login : String?
	let id : Int?
	let avatar_url : String?
	let gravatar_id : String?
	let url : String?
	let html_url : String?
	let followers_url : String?
	let following_url : String?
	let gists_url : String?
	let starred_url : String?
	let subscriptions_url : String?
	let organizations_url : String?
	let repos_url : String?
	let events_url : String?
	let received_events_url : String?
	let type : String?
	let site_admin : Bool?

	enum CodingKeys: String, CodingKey {

		case login = "login"
		case id = "id"
		case avatar_url = "avatar_url"
		case gravatar_id = "gravatar_id"
		case url = "url"
		case html_url = "html_url"
		case followers_url = "followers_url"
		case following_url = "following_url"
		case gists_url = "gists_url"
		case starred_url = "starred_url"
		case subscriptions_url = "subscriptions_url"
		case organizations_url = "organizations_url"
		case repos_url = "repos_url"
		case events_url = "events_url"
		case received_events_url = "received_events_url"
		case type = "type"
		case site_admin = "site_admin"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		login = try values.decodeIfPresent(String.self, forKey: .login)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		avatar_url = try values.decodeIfPresent(String.self, forKey: .avatar_url)
		gravatar_id = try values.decodeIfPresent(String.self, forKey: .gravatar_id)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		html_url = try values.decodeIfPresent(String.self, forKey: .html_url)
		followers_url = try values.decodeIfPresent(String.self, forKey: .followers_url)
		following_url = try values.decodeIfPresent(String.self, forKey: .following_url)
		gists_url = try values.decodeIfPresent(String.self, forKey: .gists_url)
		starred_url = try values.decodeIfPresent(String.self, forKey: .starred_url)
		subscriptions_url = try values.decodeIfPresent(String.self, forKey: .subscriptions_url)
		organizations_url = try values.decodeIfPresent(String.self, forKey: .organizations_url)
		repos_url = try values.decodeIfPresent(String.self, forKey: .repos_url)
		events_url = try values.decodeIfPresent(String.self, forKey: .events_url)
		received_events_url = try values.decodeIfPresent(String.self, forKey: .received_events_url)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		site_admin = try values.decodeIfPresent(Bool.self, forKey: .site_admin)
	}

}
