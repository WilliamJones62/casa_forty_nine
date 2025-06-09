FactoryBot.define do
  factory :property do
    name { "Casa 49" }
    headline { "Beautiful house in the heart of central Merida" }
    description { "Located in Santa Ana, one block south of the restaurants on Calle 47, one block west of the La Plancha park, you are not far from some of the best attractions Merida has to offe" }
    city { "Merida" }
    state { "Yukatan" }
    country { "Mexico" }
    address { "Calle 49 #456 50y52 Centro" }
    latitude { 20.973236083848708 }
    longitude { -89.61566162017164 }
    price_cents { 30000 }
    price_currency { "USD" }
  end
end
