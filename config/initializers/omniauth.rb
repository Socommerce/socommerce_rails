Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "a0UmBU7AHn0fFneQ10zYwP0Kk", "JZEqUgKJsTrYjjvYv1wO4jtrNpy50pwoTUwr4UAro3pPxS7Hhw",
    {
        :lang => true
    }
end