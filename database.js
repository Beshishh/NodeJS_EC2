import mysql from "mysql2"
import dotenv from "dotenv"
dotenv.config()

const pool = mysql.createPool ({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE
}).promise()


export async function getBooks(){
    const [rows] = await pool.query(`
    SELECT 
      books.*,
      GROUP_CONCAT(DISTINCT book_genres.genre_id SEPARATOR ', ') AS genres,
      GROUP_CONCAT(DISTINCT authors.firstname, ' ', authors.lastname SEPARATOR ', ') AS authors,
      genres.genre
    FROM books
    JOIN book_genres ON books.book_id = book_genres.book_id
    JOIN genres ON book_genres.genre_id = genres.genre_id
    JOIN book_author ON books.book_id = book_author.book_id
    JOIN authors ON book_author.author_id = authors.author_id
    GROUP BY books.book_id;`)
    return rows
}

export async function getBooksbyGenre(genre_id){
    const [rows] = await pool.query(`
    SELECT 
  books.*,
  GROUP_CONCAT(DISTINCT book_genres.genre_id SEPARATOR ', ') AS genres,
  GROUP_CONCAT(DISTINCT authors.firstname, ' ', authors.lastname SEPARATOR ', ') AS authors,
  genres.genre
  FROM books
  JOIN book_genres ON books.book_id = book_genres.book_id
  JOIN genres ON book_genres.genre_id = genres.genre_id
  JOIN book_author ON books.book_id = book_author.book_id
  JOIN authors ON book_author.author_id = authors.author_id
  WHERE book_genres.genre_id = ?
  GROUP BY books.book_id;
    `, [genre_id])
    return rows
}
export async function getBooksbyAuthor(authorId){
    const [rows] = await pool.query(`
    SELECT 
      books.*,
      GROUP_CONCAT(DISTINCT book_genres.genre_id SEPARATOR ', ') AS genres,
      GROUP_CONCAT(DISTINCT authors.firstname, ' ', authors.lastname SEPARATOR ', ') AS authors,
      genres.genre
    FROM books
    JOIN book_genres ON books.book_id = book_genres.book_id
    JOIN genres ON book_genres.genre_id = genres.genre_id
    JOIN book_author ON books.book_id = book_author.book_id
    JOIN authors ON book_author.author_id = authors.author_id
    WHERE authors.author_id = ?
    GROUP BY books.book_id;
    `, [authorId])
    return rows
}

export async function postBooks(title, total_pages, rating, isbn, publisher_date, publisher_id, authorIds, genreIds) {
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();
    const [result] = await conn.query(
      'INSERT INTO books (title, total_pages, rating, isbn, publisher_date, publisher_id) VALUES (?, ?, ?, ?, ?, ?)',
      [title, total_pages, rating, isbn, publisher_date, publisher_id]
    );
    const bookId = result.insertId;
    const authorValues = authorIds.map(authorId => [bookId, authorId]);
    const genreValues = genreIds.map(genreId => [bookId, genreId]);
    await conn.query(
      'INSERT INTO book_author (book_id, author_id) VALUES ?',
      [authorValues]
    );
    await conn.query(
      'INSERT INTO book_genres (book_id, genre_id) VALUES ?',
      [genreValues]
    );
    await conn.commit();
    return { bookId, title, total_pages, rating, isbn, publisher_date, publisher_id, authorIds, genreIds };
  } catch (error) {
    await conn.rollback();
    throw error;
  } finally {
    conn.release();
  }
}


export async function deleteBooks(bookId) {
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();

    await conn.query('DELETE FROM book_author WHERE book_id = ?', [bookId]);
    await conn.query('DELETE FROM book_genres WHERE book_id = ?', [bookId]);
    await conn.query('DELETE FROM books WHERE book_id = ?', [bookId]);

    await conn.commit();
  } catch (error) {
    await conn.rollback();
    throw error;
  } finally {
    conn.release();
  }
}

export async function updateBook(bookId, title, total_pages, rating, isbn, publisher_date, publisher_id, authorIds, genreIds) {
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();

    await conn.query(
      'UPDATE books SET title = ?, total_pages = ?, rating = ?, isbn = ?, publisher_date = ?, publisher_id = ? WHERE book_id = ?',
      [title, total_pages, rating, isbn, publisher_date, publisher_id, bookId]
    );
    await conn.query(
      'DELETE FROM book_author WHERE book_id = ?',
      [bookId]
    );
    await conn.query(
      'DELETE FROM book_genres WHERE book_id = ?',
      [bookId]
    );
    const authorValues = authorIds.map(authorId => [bookId, authorId]);
    const genreValues = genreIds.map(genreId => [bookId, genreId]);
    await conn.query(
      'INSERT INTO book_author (book_id, author_id) VALUES ?',
      [authorValues]
    );
    await conn.query(
      'INSERT INTO book_genres (book_id, genre_id) VALUES ?',
      [genreValues]
    );
    await conn.commit();
    return { bookId, title, total_pages, rating, isbn, publisher_date, publisher_id, authorIds, genreIds };
  } catch (error) {
    await conn.rollback();
    throw error;
  } finally {
    conn.release();
  }
}
