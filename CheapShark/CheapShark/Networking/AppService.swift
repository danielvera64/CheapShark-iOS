//
//  AppService.swift
//  CheapShark
//
//  Created by Daniel Vera on 13/1/21.
//

import Foundation
import Combine

class AppService {
   
   private let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
   private let decoder = JSONDecoder()
   private let baseURL = "https://www.cheapshark.com"
   
   func getDeals(request: DealListRequest) -> AnyPublisher<[Deal], Error> {
      var components = URLComponents(string: baseURL + "/api/1.0/deals")
      components?.queryItems = request.getUQueryItems()
      
      var request = URLRequest(url: components!.url!)
      request.httpMethod = "GET"
      AppService.log(request: request)
      return session.dataTaskPublisher(for: request)
         .tryMap({ [unowned self] result -> [Deal] in
            AppService.log(response: result.response as? HTTPURLResponse, data: result.data, error: nil)
            return try self.decoder.decode([Deal].self, from: result.data)
         })
         .receive(on: DispatchQueue.main)
         .eraseToAnyPublisher()
   }
   
   func getStores() -> AnyPublisher<[Store], Error> {
      var request = URLRequest(url: URL(string: baseURL + "/api/1.0/stores")!)
      request.httpMethod = "GET"
      AppService.log(request: request)
      return session.dataTaskPublisher(for: request)
         .tryMap({ [unowned self] result -> [Store] in
            AppService.log(response: result.response as? HTTPURLResponse, data: result.data, error: nil)
            return try self.decoder.decode([Store].self, from: result.data)
         })
         .receive(on: DispatchQueue.main)
         .eraseToAnyPublisher()
   }
   
   func getDealInfo(dealId: String) -> AnyPublisher<DealLookup, Error> {
      var components = URLComponents(string: baseURL + "/api/1.0/deals")
      components?.percentEncodedQuery = "id=\(dealId)"
      var request = URLRequest(url: components!.url!)
      request.httpMethod = "GET"
      AppService.log(request: request)
      return session.dataTaskPublisher(for: request)
         .tryMap({ [unowned self] result -> DealLookup in
            AppService.log(response: result.response as? HTTPURLResponse, data: result.data, error: nil)
            return try self.decoder.decode(DealLookup.self, from: result.data)
         })
         .receive(on: DispatchQueue.main)
         .eraseToAnyPublisher()
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
