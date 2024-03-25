from audioop import add
import sqlite3
from dataclasses import dataclass

@dataclass
class Note:
    id: int = None
    title: str = None
    content: str = ''

class Database:
    def __init__(self, name):
        self.name = f'{name}.db'
        self.conn = sqlite3.connect(self.name)
        self.conn.execute('CREATE TABLE IF NOT EXISTS note (id INTEGER PRIMARY KEY, title TEXT, content TEXT NOT NULL);')

    def add(self, note):
        self.conn.execute('INSERT INTO note (title, content) VALUES (?, ?);', (note.title, note.content))
        self.conn.commit()
    
    def get_all(self):
        notes, cursor = [], self.conn.execute('SELECT title, content FROM note')
        for title, content in cursor:
            notes.append(Note(title=title, content=content))
        return notes

    def update(self, entry):
        self.conn.execute(f'UPDATE note SET title = "{entry.title}", content = "{entry.content}" WHERE id = {entry.id}')
        self.conn.commit()

    def delete(self, note_id):
        self.conn.execute(f'DELETE FROM note WHERE id = {note_id}')
        self.conn.commit()