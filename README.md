# E-Commerce Store (Flutter)

This is a Flutter e-commerce app integrated with [Fake Store API](https://fakestoreapi.com).

## How To Run The App

1. Make sure Flutter SDK `3.29.3` is installed and configured.
2. From the project root, install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

4. Login with test credentials:
- Username: `mor_2314`
- Password: `83r5^_`

## Working Features

- Authentication
- Login with API integration (`/auth/login`)
- Session/token storage using secure storage
- Logout

- Product Browsing
- Load all products from API
- Category chips filter products by category
- Search bar filters products by title/category
- Pull-to-refresh on product list
- Product detail screen

- Cart
- Add product to cart from product grid and detail screen
- View cart items
- Increase/decrease quantity
- Remove item
- Total price display

- Profile
- Load and display user profile data
- Logout from profile screen

- Theme
- Light and dark mode support
- Theme toggle button in home top bar
- Theme-aware colors across major screens/components

## Notes

- API base URL: `https://fakestoreapi.com`
- Routes used: login, home, cart, profile, product detail
