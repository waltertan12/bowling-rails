# Bowling on Rails
Very, very simple bowling app.

### Routing
| Path           | Method | Purpose                                      |
|----------------|--------|----------------------------------------------|
| api/games      |  POST  | Create a new game of bowling                 |
| api/games      |  GET   | View all bowling games                       |
| api/games/:id  |  GET   | View a single bowling game matching :id      |
| api/games/:id  | DELETE | Delete game with id :id                      |
| api/games/bowl |  POST  | Bowls for a given game. Accepts query params |
