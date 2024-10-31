[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![Powered by Docker](https://img.shields.io/badge/Powered%20by-Docker-2496ED?style=flat&logo=docker&logoColor=white)](https://www.docker.com/)
[![Heroku](https://img.shields.io/badge/Heroku-Deployed-430098?style=flat&logo=heroku)](https://guarded-dusk-82007-3d4643b2b311.herokuapp.com/)

# Mini Blog Platform

## 🐳 Running with Docker

> This setup will run your Rails application in a Docker container with a
> PostgreSQL database, Redis and Sidekiq.

To run the application using Docker, follow these steps:

1. **Set up environment variables**
   ```shell
   cp .env.example .env
   ```
2. **Build the Docker containers**:
   ```shell
   docker compose build
   ```
3. **Start the Docker containers**:
   ```shell
   docker compose up
   ```
4. **Access the application**: Open your browser and navigate to
   [http://localhost:3000](http://localhost:3000).

**Note**: The application will be seeded with the entities at `db/seeds.rb`

## 🚀 Deployment

The app is deployed
at [Heroku](https://guarded-dusk-82007-3d4643b2b311.herokuapp.com/).

![Screenshot](https://github.com/user-attachments/assets/a2b687f6-b1b0-4d62-9ebd-19457e28ae5f)

✉️ **Note**: Emails might be sent to the spam folder.

## 📝 Public API Documentation

### Base URL

```
https://guarded-dusk-82007-3d4643b2b311.herokuapp.com/api/v1
```

### Endpoints

#### 1. List Posts

**Endpoint:** `/posts`
**Method:** `GET`
**Description:** Retrieves a list of posts with pagination.

**Parameters:**

- `page` (optional): Page number for pagination.
- `ids` (optional): Comma-separated list of post IDs to filter.

**Example Request:**

```sh
curl -X GET "https://guarded-dusk-82007-3d4643b2b311.herokuapp.com/api/v1/posts?page=1"
```

**Example Response:**

```json
[
  {
    "id": 2,
    "title": "Apple",
    "body": "Apple",
    "author_id": 24,
    "created_at": "2024-10-30T02:31:29.804Z",
    "updated_at": "2024-10-30T02:31:29.804Z",
    "comments": [
      {
        "id": 6,
        "body": "Commenting on someone else",
        "post_id": 2,
        "author_id": 23,
        "created_at": "2024-10-30T18:37:11.378Z",
        "updated_at": "2024-10-30T18:37:11.378Z"
      },
      {
        "id": 7,
        "body": "Yes!",
        "post_id": 2,
        "author_id": 23,
        "created_at": "2024-10-30T19:24:28.963Z",
        "updated_at": "2024-10-30T19:24:28.963Z"
      },
      {
        "id": 9,
        "body": "Email to icloud.",
        "post_id": 2,
        "author_id": 23,
        "created_at": "2024-10-30T19:46:15.411Z",
        "updated_at": "2024-10-30T19:46:15.411Z"
      }
    ]
  }
]
```

#### 2. Get Post

**Endpoint:** `/posts/:id`
**Method:** `GET`
**Description:** Retrieves a specific post by ID.

**Parameters:**

- `id` (required): ID of the post.

**Example Request:**

```sh
curl -X GET "https://guarded-dusk-82007-3d4643b2b311.herokuapp.com/api/v1/posts/1"
```

**Example Response:**

```json
{
  "id": 1,
  "title": "Gmail",
  "body": "Testing with Gmail.",
  "author_id": 23,
  "created_at": "2024-10-30T02:29:10.790Z",
  "updated_at": "2024-10-31T03:54:25.045Z",
  "comments": [
    {
      "id": 2,
      "body": "Amazing! - edited\r\n",
      "post_id": 1,
      "author_id": 23,
      "created_at": "2024-10-30T02:29:33.392Z",
      "updated_at": "2024-10-30T02:29:42.549Z"
    },
    {
      "id": 4,
      "body": "Beautiful! - edited",
      "post_id": 1,
      "author_id": 24,
      "created_at": "2024-10-30T02:33:20.506Z",
      "updated_at": "2024-10-30T02:33:27.330Z"
    },
    {
      "id": 5,
      "body": "Commenting on myself",
      "post_id": 1,
      "author_id": 23,
      "created_at": "2024-10-30T18:31:46.875Z",
      "updated_at": "2024-10-30T18:31:46.875Z"
    },
    {
      "id": 8,
      "body": "Email to myself.",
      "post_id": 1,
      "author_id": 23,
      "created_at": "2024-10-30T19:45:47.462Z",
      "updated_at": "2024-10-30T19:45:47.462Z"
    }
  ]
}
```

#### 3. Create Post

**Endpoint:** `/posts`
**Method:** `POST`
**Description:** Creates a new post.

**Parameters:**

- `title` (required): Title of the post.
- `body` (required): Body of the post.
- `author_id` (required): ID of the author.

**Example Request:**

```sh
curl -X POST "https://guarded-dusk-82007-3d4643b2b311.herokuapp.com/api/v1/posts" -d '{ "post": { "title": "New Post", "body": "This is the body of the new post.", "author_id": 23 } }'
```

**Example Response:**

```json
{
  "id": 5,
  "title": "New Post",
  "body": "This is the body of the new post.",
  "author_id": 23,
  "created_at": "2024-10-31T05:32:42.686Z",
  "updated_at": "2024-10-31T05:32:42.686Z"
}
```

#### 4. Update Post

**Endpoint:** `/posts/:id`
**Method:** `PUT`
**Description:** Updates an existing post.

**Parameters:**

- `id` (required): ID of the post.
- `title` (optional): New title of the post.
- `body` (optional): New body of the post.

**Example Request:**

```sh
curl -X PUT "https://guarded-dusk-82007-3d4643b2b311.herokuapp.com/api/v1/posts/5" -d '{ "post": { "title": "New Post - Edited" } }'
```

**Example Response:**

```json
{
  "title": "New Post - Edited",
  "author_id": 23,
  "id": 5,
  "body": "This is the body of the new post.",
  "created_at": "2024-10-31T05:32:42.686Z",
  "updated_at": "2024-10-31T05:35:21.944Z"
}
```

#### 5. Delete Post

**Endpoint:** `/posts/:id`
**Method:** `DELETE`
**Description:** Deletes a specific post by ID.

**Parameters:**

- `id` (required): ID of the post.

**Example Request:**

```sh
curl -X DELETE "https://yourdomain.com/api/v1/posts/5"
```
