# News Aggregator App

A Flutter-based news aggregation application that fetches news from the [News API](https://newsapi.org/v2/) and displays headlines, categories, and keyword-based search results. The app is built using **Clean Architecture** and utilizes **Bloc Cubit** for state management.

## Features

- **Clean Architecture**: Organized project structure for scalability and maintainability.
- **Bloc Cubit for State Management**: Efficient state handling with reactive UI updates.
- **Flutter Frontend**: Beautiful and responsive UI built with Flutter.
- **News API Integration**: Fetch news using different endpoints:
  - Search news by keyword
  - Fetch news by category
  - Get top headlines
  - Retrieve all articles based on keywords
- **Dark & Light Mode**: Supports theme switching.
- **Error Handling & Caching**: Handles API failures gracefully and caches results for offline access.

## Screenshots
![WhatsApp Image 2025-02-27 at 2 48 38 AM](https://github.com/user-attachments/assets/abadf428-5883-4b61-ad3f-14630ee1c9cf)

![WhatsApp Image 2025-02-27 at 2 48 38 AM (1)](https://github.com/user-attachments/assets/62919908-179e-49a0-b644-9ac7aec2059f)

## Installation

1. Clone the repository:
   ```
   https://github.com/BharatWakade-code/news_aggregator_app.git
   
   ```
2. Navigate to the project directory:
   ```sh
   cd news_aggregator_app
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Get API Key from [News API](https://newsapi.org/) and add it to `.env` file:
   ```sh
   API_KEY= your_news_api_key_here
   ```
5. Run the app:
   ```sh
   flutter run

   ```

## Project Structure

```
lib/
│── models/
│ 
│── Scrrens/
│     │ 
      │── data/
      │── screen_name/
      │── screen_cubit/
      │── screen_state/
│── services/
│
│── utils/
│ 
│── main.dart
```

## API Endpoints Used

- **Search by keyword**: `https://newsapi.org/v2/everything?q={keyword}&apiKey={API_KEY}`
- **Category-based news**: `https://newsapi.org/v2/top-headlines?category={category}&apiKey={API_KEY}`
- **Top headlines**: `https://newsapi.org/v2/top-headlines?country=us&apiKey={API_KEY}`
- **Everything by keyword**: `https://newsapi.org/v2/everything?q={keyword}&apiKey={API_KEY}`

## Contributing

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Create a pull request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contact

For any inquiries, reach out at [your.email@example.com](mailto:bharatwakade012.com).

