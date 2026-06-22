//
//  APIViewModel.swift
//  Checkin
//
//  Created by André Contarelli Lima on 22/06/26.
//

import Foundation
import SwiftUI
import Combine

class APIViewModel: ObservableObject {
    @Published var busLines : [LineModel] = []
    
    private let baseUrl = "https://sptrans.com.br"
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.httpShouldSetCookies = true
        return URLSession(configuration: configuration)
    }()
    
    func fetch(){
        let urlString = "\(baseUrl)/Linha/Buscar?termosBusca=8000"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = session.dataTask(with: url){ [weak self] data, response, error in
            guard let data = data, error == nil else{
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code do Fetch: \(httpResponse.statusCode)")
            }
            
            do {
                let parsed = try JSONDecoder().decode([LineModel].self, from: data)
                
                DispatchQueue.main.async {
                    self?.busLines = parsed
                    print("Sucesso! Linhas carregadas: \(parsed.count)")
                }
            }catch{
                print("Erro no Decoder: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON bruto recebido: \(jsonString)")
                }
            }
        }
        task.resume()
    }
    
    // NENHUMA linha lógica mudou aqui, apenas usa a nova 'session' persistente
    func autenticar(token: String) async {
        let urlString = "\(baseUrl)/Login/Autenticar?token=\(token)"
        
        guard let url = URL(string: urlString) else {
            print("URL inválida.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("0", forHTTPHeaderField: "Content-Length")
        
        do {
            let (data, response) = try await session.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200,
                   let respostaString = String(data: data, encoding: .utf8),
                   respostaString.trimmingCharacters(in: .whitespacesAndNewlines) == "true" {
                    
                    print("Autenticação com sucesso")
                    
                } else {
                    print("Falha na autenticação.")
                }
            }
        } catch {
            print("Erro de conexão: \(error.localizedDescription)")
        }
    }
}
