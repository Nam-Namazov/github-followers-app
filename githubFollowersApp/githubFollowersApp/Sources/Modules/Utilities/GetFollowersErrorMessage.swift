//
//  ErrorMessage.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import Foundation

enum GetFollowersErrorMessage: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
