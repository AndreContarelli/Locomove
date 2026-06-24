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
    @Published var busLines: [LineModel] = []

    private let baseUrl = "https://api.olhovivo.sptrans.com.br/v2.1"
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        configuration.httpShouldSetCookies = true
        return URLSession(configuration: configuration)
    }()

    func autenticar(token: String) async -> Bool {
        let urlString = "\(baseUrl)/Login/Autenticar?token=\(token)"
        guard let url = URL(string: urlString) else { return false }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("0", forHTTPHeaderField: "Content-Length")

        do {
            let (data, response) = try await session.data(for: request)
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200,
               let body = String(data: data, encoding: .utf8),
               body.trimmingCharacters(in: .whitespacesAndNewlines) == "true" {
                print("Autenticação com sucesso")
                return true
            }
        } catch {
            print("Erro de conexão: \(error.localizedDescription)")
        }
        print("Falha na autenticação.")
        return false
    }

    func fetch(termo: String) async {
        let termoEncoded = termo.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? termo
        let urlString = "\(baseUrl)/Linha/Buscar?termosBusca=\(termoEncoded)"
        guard let url = URL(string: urlString) else { return }

        do {
            let (data, response) = try await session.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code do Fetch: \(httpResponse.statusCode)")
            }
            let parsed = try JSONDecoder().decode([LineModel].self, from: data)
            await MainActor.run {
                self.busLines = parsed
                print("Sucesso! Linhas carregadas: \(parsed.count)")
            }
        } catch {
            print("Erro no Decoder: \(error)")
        }
    }
    
    func fetchParadas(codigoLinha: Int) async -> Int {
        let urlString = "\(baseUrl)/Parada/BuscarParadasPorLinha?codigoLinha=\(codigoLinha)"
        guard let url = URL(string: urlString) else { return 0 }

        do {
            let (data, _) = try await session.data(from: url)
            let paradas = try JSONDecoder().decode([StopModel].self, from: data)
            return paradas.count
        } catch {
            print("Erro ao buscar paradas para linha \(codigoLinha): \(error)")
            return 0
        }
    }
}
