# Moonshot
<img src="../../assets/moonshot.gif" width="200" />

## Goal

Moonshot - Grid x List layout of Apollo Missions using decoded data from JSON

## Changelog

* GeometryReader, Image, .resizable, .scaleToFit, .frame,
  <details>
    <summary>Center center an image</summary>

    ```swift
    GeometryReader { geo in
        Image("Example")
            .resizable()
            .scaledToFit()
            .frame(width: geo.size.width * 0.8)
            .frame(width: geo.size.width, height: geo.size.height)
    }
    ```
  </details>

* ScrollView, LazyVStack, LazyHStack
  <details>
    <summary>ScrollView 100 items w/ full width: all rows are made on show of the screen</summary>

    ```swift
      ScrollView {
          VStack(spacing: 10) {
              ForEach(0..<100) {
                  Text("Item \($0)")
                      .font(.title)
              }
          }
          .frame(maxWidth: .infinity)
      }
    ```
  </details>

  <details>
    <summary>Lazily load the rows of the ScrollView (Vertical/Horizontal)</summary>

    ```swift
      struct CustomText: View {
          let text: String

          var body: some View {
              Text(text)
          }

          init(_ text: String) {
              print("Creating a new CustomText")
              self.text = text
          }
      }

      struct ContentView: View {
          var body: some View {
            ScrollView { // ScrollView(.horizontal)
              LazyVStack(spacing: 10) { // LazyHStack
                  ForEach(0..<100) {
                      CustomText("Item \($0)")
                          .font(.title)
                  }
              }
              .frame(maxWidth: .infinity)
            }
          }
      }
    ```
  </details>

* NavigationView and NavigationLink
  <details>
    <summary>List of items to details screen</summary>

    > NavigationLink is for showing details about the user’s selection, like you’re digging deeper into a topic

    ```swift
      struct ContentView: View {
          var body: some View {
              NavigationView {
                  List(0..<100) { row in
                      NavigationLink {
                          Text("Detail \(row)") // the details to be shown on the new screen
                      } label: {
                          Text("Row \(row)") // the row label to show for the list. This automatically has a chevron-right since it's a List within a NavigationView
                      }
                  }
                  .navigationTitle("SwiftUI")
              }
          }
      }
    ```
  </details>

* Working with hierarchical Codable data
  <details>
    <summary>Decoding a JSON</summary>

    ```swift
    struct User: Codable {
        let name: String
        let address: Address
    }

    struct Address: Codable {
        let street: String
        let city: String
    }

    struct ContentView: View {
        var body: some View {
            Button("Decode JSON") {
                // the stringed JSON
                let input = """
                {
                    "name": "Taylor Swift",
                    "address": {
                        "street": "555, Taylor Swift Avenue",
                        "city": "Nashville"
                    }
                }
                """

                let data = Data(input.utf8)
                let decoder = JSONDecoder()
                if let user = try? decoder.decode(User.self, from: data) {
                    print(user.address.street)
                }
            }
        }
    }
    ```
  </details>

* GridItem, LazyHGrid, LazyVGrid
  <details>
    <summary>How to lay out views in a scrolling grid</summary>

    ```swift
    struct ContentView: View {
        let layout = [
            GridItem(.fixed(80)), // GridItem(.adaptive(minimum: 80, maximum: 120)), let swiftui fit as many columns that is possible in this config
            GridItem(.fixed(80)),
            GridItem(.fixed(80))
        ]

        var body: some View {
            ScrollView { // for horizontal: ScrollView(.horizontal) {
                LazyVGrid(columns: layout) { // for horizontal: LazyHGrid(rows: layout) {
                    ForEach(0..<1000) {
                        Text("Item \($0)")
                    }
                }
            }
        }
    }
    ```
  </details>

* Loading a specific kind of Codable data
* Using generics to load any kind of Codable data
* Styling items
  * Using Date formatter when decoding data
  * Using an extension to create new color combinations
  * .preferredColorScheme(.dark)

* Divider
  <details>
    <summary>alternative</summary>

    ```swift
      Rectangle()
        .frame(height: 2)
        .foregroundColor(.black.opacity(0.2))
        .padding(.vertical)
    ```
  </details>

* Toggle: Grid vs List