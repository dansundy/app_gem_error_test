# Shopify `app_gem` error test

This repo creates a reduced test case for a `500` error that happens at the same time as any invalid token error.

More details can be found in this issue: https://github.com/Shopify/shopify_app/issues/1536

## Setup

To get set up with this repo, clone and then:

1. Run `bundle install`
2. Create an app in the Shopify Partners dashboard
3. Create a `.env` file in the root of the project and add the following credentials

```
HOST=http://localhost:3000
SHOPIFY_API_KEY=<Your Shopify API key>
SHOPIFY_API_SECRET=<Your Shopify API secret>
```

4. Run the migrations with `rails db:migrate`
5. Run the app: `rails server`
6. Go to `http://127.0.0.1:3000`

## Explaination

The app will attempt to fetch a list of products in the `products_controller` that inherit from the `authenticated_controller`. But in `app/views/home/index.html.erb` I am purposely using an invalid token. On the server side, in `authenticated_controller` I am trying to rescue this error and return a `400` error. Eventually, this would be a `401` error that I add a re-authentication header to. Unfortunately, I can't because it gets overridden by a server (`500`) error.

## Notes

I've noticed that sometimes there is another error that happens even before the fetch. If this happens, just refresh.
