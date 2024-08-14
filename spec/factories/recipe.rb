FactoryBot.define do
    factory :recipe do
      title { "World's Best Potato Salad" }
      ingredients { ["6 medium potatoes",
        "1 small onion, finely chopped",
        "1 cup celery, chopped",
        "1 teaspoon salt",
        "6 hard-cooked eggs, diced",
        "2 eggs, beaten",
        "½ cup white sugar",
        "1 teaspoon cornstarch",
        "salt to taste",
        "½ cup vinegar",
        "1 (5 ounce) can evaporated milk",
        "1 teaspoon prepared yellow mustard",
        "¼ cup butter",
        "1 cup mayonnaise"] }
    end
end
