import express from "express"

import { getBooksbyGenre, getBooks, getBooksbyAuthor, postBooks, deleteBooks, updateBook } from "./database.js"

const app = express()

app.use(express.json())

app.get("/books", async (req, res) => {
    const books = await getBooks()
    res.send(books)
})
app.get("/booksbygenre/:genre_id", async (req, res) => {
    const genre_id = req.params.genre_id
    const books = await getBooksbyGenre(genre_id)
    res.send(books)
})
app.get("/booksbyauthor/:author_id", async (req, res) => {
    const author_id = req.params.author_id
    const books = await getBooksbyAuthor(author_id)
    res.send(books)
})
app.post('/postbook', async (req, res) => {
  const { title, total_pages, rating, isbn, publisher_date, publisher_id, authors, genres } = req.body;

  try {
    const book = await postBooks(title, total_pages, rating, isbn, publisher_date, publisher_id, authors, genres);
    res.status(201).json(book);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

app.delete('/deleteBook/:book_id', async (req, res) => {
    const book_id = req.params.book_id
    const books = await deleteBooks(book_id)
    res.send("Book deleted")
 })

 app.put('/putbooks/:id', async (req, res) => {
  const bookId = req.params.id;
  const { title, total_pages, rating, isbn, publisher_date, publisher_id, authors, genres } = req.body;

  try {
    const book = await updateBook(bookId, title, total_pages, rating, isbn, publisher_date, publisher_id, authors, genres);
    res.json(book);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Could not update book' });
  }
});
 

app.use((err, req, res, next) => {
    console.error(err.stack)
    res.status(500).send('Error')
}) 

app.listen(3000, () => {
    console.log('Server is running on 3000 port')
})