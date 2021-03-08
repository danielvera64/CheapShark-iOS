//
//  NetworkProvider.swift
//  CheapShark
//
//  Created by Daniel Vera on 3/1/21.
//

import Foundation
import Combine

public struct HTTPResponse<T> {
  let value: T
  let response: URLResponse
}

public class NetworkProvider<Target: AppTargetType>: NSObject, URLSessionDelegate {

  public lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

  private let decoder: JSONDecoder = JSONDecoder()

  public func perform<T: Codable>(
    _ target: Target,
    completionHandler: @escaping (Result<T, AppError>) -> Void
  ) {
    let request = getRequest(target: target)
    NetworkProvider.log(request: request)
    session
      .dataTask(with: request, completionHandler: { data, response, error in
        if let error = error {
          completionHandler(.failure(AppError.custom(description: error.localizedDescription)))
          return
        }
        if
          let httpResponse = response as? HTTPURLResponse,
          !(200...299).contains(httpResponse.statusCode)
        {
          let description = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)
          completionHandler(.failure(AppError.custom(description: description)))
        }
        guard let data = data else {
          completionHandler(.failure(AppError.custom(description: nil)))
          return
        }
        do {
          let value = try self.decoder.decode(T.self, from: data)
          NetworkProvider.log(response: response as? HTTPURLResponse, data: data, error: nil)
          completionHandler(.success(value))
          return
        } catch {
          completionHandler(.failure(AppError.custom(description: error.localizedDescription)))
        }
      })
      .resume()
  }

  private func getRequest(target: Target) -> URLRequest {
    var url = target.baseURL
    url.appendPathComponent(target.path)

    var components = URLComponents(string: url.absoluteString)
    if !target.parameters.isEmpty {
      components?.queryItems = target.parameters
    }
    if !target.percentEncodedQuery.isEmpty {
      components?.percentEncodedQuery = target.percentEncodedQuery
    }
    var request = URLRequest(url: components?.url ?? url)
    target.headers?.forEach({ header in
      request.setValue(header.value, forHTTPHeaderField: header.key)
    })
    request.httpMethod = target.method.rawValue
    request.httpBody = target.data
    return request
  }

  private static func log(request: URLRequest) {
    print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
    defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
    let urlAsString = request.url?.absoluteString ?? ""
    let urlComponents = URLComponents(string: urlAsString)
    let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
    let path = "\(urlComponents?.path ?? "")"
    let query = "\(urlComponents?.query ?? "")"
    let host = "\(urlComponents?.host ?? "")"
    var output = """
      \(urlAsString) \n\n
      \(method) \(path)?\(query) HTTP/1.1 \n
      HOST: \(host)\n
      """
    for (key,value) in request.allHTTPHeaderFields ?? [:] {
      output += "\(key): \(value) \n"
    }
    if let body = request.httpBody {
      output += "\n \(String(data: body, encoding: .utf8) ?? "")"
    }
    print(output)
  }

  private static func log(response: HTTPURLResponse?, data: Data?, error: Error?) {
    print("\n - - - - - - - - - - INCOMMING - - - - - - - - - - \n")
    defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
    let urlString = response?.url?.absoluteString
    let components = NSURLComponents(string: urlString ?? "")
    let path = "\(components?.path ?? "")"
    let query = "\(components?.query ?? "")"
    var output = ""
    if let urlString = urlString {
      output += "\(urlString)"
      output += "\n\n"
    }
    if let statusCode =  response?.statusCode {
      output += "HTTP \(statusCode) \(path)?\(query)\n"
    }
    if let host = components?.host {
      output += "Host: \(host)\n"
    }
    for (key, value) in response?.allHeaderFields ?? [:] {
      output += "\(key): \(value)\n"
    }
    if let body = data {
      output += "\n\(String(data: body, encoding: .utf8) ?? "")\n"
    }
    if error != nil {
      output += "\nError: \(error!.localizedDescription)\n"
    }
    print(output)
  }

}

