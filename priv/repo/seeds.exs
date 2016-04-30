alias Chowmonger.Repo
alias Chowmonger.API.V1.User
alias Chowmonger.API.V1.Truck

user1 = %{ name: "Admin", email: "admin@chowmonger.com", password: "password" }
user2 = %{ name: "DNuts", email: "dnuts@chowmonger.com", password: "password" }
user3 = %{ name: "Jim", email: "jim@chowmonger.com", password: "password" }

menu_item = %{ name: "Hot Dog", price: 1.50 }

truck = %{
           name: "Jim Bob's Shrimp Stand",
           lat: 41.8820989,
           lng: -87.6242104,
           image: "https://upload.wikimedia.org/wikipedia/commons/8/8d/Seattle_-_Maximus_Minimus_food_truck_03.jpg",
           categories: ["Creole", "Southern"],
           status: true
         }

truck2 = %{
            name: "Don't Nuts",
            lat: 41.8830989,
            lng: -87.6442104,
            image: "https://upload.wikimedia.org/wikipedia/commons/e/e5/Claire_et_Hugo_food_truck.JPG",
            categories: ["Nuts... what else?"],
            status: true
          }

truck3 = %{
            name: "Burgers and Peaches",
            lat: 41.8720989,
            lng: -87.6212104,
            image: "https://upload.wikimedia.org/wikipedia/commons/e/e3/Food_truck_in_London.jpg",
            categories: ["Beef", "Fruit"],
            status: true
          }

User.changeset(%User{}, user1)
|> Repo.insert!

User.changeset(%User{}, user2)
|> Repo.insert!

User.changeset(%User{}, user3)
|> Repo.insert!

Repo.get(User, 3)
|> Ecto.build_assoc(:truck, truck)
|> Repo.insert!

Repo.get(Truck, 1)
|> Ecto.build_assoc(:menu_items, menu_item)
|> Repo.insert!

Repo.get(User, 2)
|> Ecto.build_assoc(:truck, truck2)
|> Repo.insert!

