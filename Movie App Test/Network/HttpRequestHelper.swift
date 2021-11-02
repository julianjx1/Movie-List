
import Foundation


class HttpRequestHelper {
    
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    func getSearchResults(search:String, complete: @escaping (Bool, Data?) -> ()){
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/search/movie") {
          urlComponents.query = "api_key=38e61227f85671163c275f9bd95a8803&query=\(search)"
          guard let url = urlComponents.url else {
            return
          }
          dataTask =
            defaultSession.dataTask(with: url) { data, response, error in
                
                guard error == nil else {
                    print("Error: problem calling GET")
                    print(error!)
                    complete(false, nil)
                    return
                }
                guard let data = data else {
                    print("Error: did not receive data")
                    complete(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    complete(false, nil)
                    return
                }
                complete(true, data)
          }
          dataTask?.resume()
        }

    }
}
