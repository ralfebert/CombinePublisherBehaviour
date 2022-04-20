import Combine
import SwiftUI

class Example: ObservableObject {
    var value = CurrentValueSubject<Int, Never>(0)
    var subscriptions = Set<AnyCancellable>()

    @Published var uiValue = 0

    func increment() {
        self.value.send(self.value.value)
    }

    func subscribe() {
        self.value.sink { value in
            self.uiValue = value
        }
        .store(in: &self.subscriptions)
    }

    func removeSubscribers() {
        self.subscriptions.removeAll()
    }
}

struct CombinePublisherBehaviourView: View {
    @StateObject var example = Example()

    var body: some View {
        VStack {
            Text("Hello \(example.uiValue)")
            Button("Subscribe") {
                self.example.subscribe()
            }
            Button("removeSubscribers") {
                self.example.removeSubscribers()
            }
            Button("Increment") {
                self.example.increment()
            }
        }
    }
}

struct CombinePublisherBehaviourView_Previews: PreviewProvider {
    static var previews: some View {
        CombinePublisherBehaviourView()
    }
}
