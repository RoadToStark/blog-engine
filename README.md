## Stark - Blog Engine

This application represents a new blog engine distributed as a REST API.

### Routes 

Just add .xml at end of URL to get XML result

* All entities - JSON : **GET** *../api/v1/entity_names*

* Articles 
  * Blog's articles :  **GET** *../api/v1/blogs/:blog_id/articles*
  * User's articles :  **GET** *../api/v1/users/:user_id/articles*
  * Create article :  **POST** *../api/v1/articles*
  
* Comments
  * Article's comments :  **GET** *../api/v1/articles/:article_id/comments*
  * User's comments :  **GET** *../api/v1/users/:user_id/comments*
  * Create comment :  **POST** *../api/v1/articles/:article_id/comments*


