

import Foundation

final class InfoViewModel {

    enum Action {
        case initModel
        case initTable
    }

    enum State {
        case loaded
    }

    var statechanged: ((State) -> Void)?
    private(set) var state: State = .loaded {
        didSet {
            statechanged?(state)
        }
    }

    var todoTitle = ObservableObject("")
    var planetModel = [Planet]()
    var residents: [String] = []

    func changeState(_ action: Action) {
        switch action {
        case .initModel:
            let urlString = "https://swapi.dev/api/planets/1"
            PlanetService.shared.fetchPlanet(with: urlString) { [weak self] data in
                switch data {
                case .success(let planet):
                    self?.planetModel.append(planet)
                case .failure(let err):
                    print("Error \(err)")
                }
            }
        case .initTable:
            ResidentService.shared.fetchResident { [weak self] data in
                switch data {
                case .success(let model):
                    self?.residents.append(model)
                    self?.state = .loaded
                case .failure(let err):
                    print(err)
                }
            }
        }
    }

    func getTodo() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/13")
        guard let url = url else { return }
        TodoService.shared.fetchTodo(from: url) { [weak self] data in
            switch data {
            case .success(let todo):
                self?.todoTitle.value = todo.title
            case .failure(let err):
                print("\(err.localizedDescription)")
            }
        }
    }

    func getResident() {
        ResidentService.shared.fetchResident { [weak self] data in
            switch data {
            case .success(let model):
                self?.residents.append(model)
            case .failure(let err):
                print(err)
            }

        }
    }

}
