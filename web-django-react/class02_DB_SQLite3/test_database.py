import unittest
import sqlite3
from unittest.mock import patch, create_autospec
from pathlib import Path
import database


DB_NAME = 'banco-teste'
DB_FILENAME = f'{DB_NAME}.db'
TABLE_NAME = 'note'


class DatabaseTestCase(unittest.TestCase):
    def setUp(self):
        db_file = Path.cwd() / DB_FILENAME
        try:
            db_file.unlink()  # Apaga o arquivo, caso exista
        except FileNotFoundError:
            pass

    def test_connect_on_init(self):
        mock_connection = create_autospec(sqlite3.Connection)
        with patch('sqlite3.connect', return_value=mock_connection) as mock_connect:
            db = database.Database(DB_NAME)

            assert mock_connect.called, 'A função sqlite3.connect não foi chamada'
            assert mock_connect.call_args[0][0] == DB_FILENAME, f'Nome do banco incorreto. Deveria ser {DB_FILENAME}'
            assert hasattr(db, 'conn'), 'Não criou o atributo conn'
            assert db.conn is mock_connection, 'Não armazenou a conexão no atributo conn'

    def test_create_table_on_init(self):
        db_file = Path.cwd() / DB_FILENAME
        db = database.Database(DB_NAME)
        if not db_file.is_file():
            raise NotImplementedError('A conexão com o banco não foi implementada ainda. Ignore se ainda não chegou neste exercício')

        conn = sqlite3.connect(DB_FILENAME)
        cursor = conn.execute(f"SELECT name FROM sqlite_master WHERE type='table' AND name='{TABLE_NAME}';")
        assert len([row for row in cursor]) == 1, f'A tabela {TABLE_NAME} não foi criada. Se você está no primeiro exercício, ignore este erro.'

        cursor = conn.execute(f"PRAGMA table_info({TABLE_NAME});")
        found_count = 0
        for i, (_, name, coltype, notnull, _, pk) in enumerate(cursor):
            if i == 0:
                assert name == 'id', 'Para facilitar os testes, a primeira coluna deve obrigatoriamente ser a coluna id.'
                assert coltype == 'INTEGER', 'A coluna id deveria ser do tipo inteiro'
                assert pk, 'A coluna id deveria ser a chave primária'
            elif i == 1:
                assert name == 'title', 'Para facilitar os testes, a segunda coluna deve obrigatoriamente ser a coluna title.'
                assert coltype == 'STRING' or coltype == 'TEXT', 'A coluna title deveria ser do tipo texto'
                assert not notnull, 'A coluna title deveria poder ser vazia'
                assert not pk, 'A coluna title não deveria ser chave primária'
            elif i == 2:
                assert name == 'content', 'Para facilitar os testes, a terceira coluna deve obrigatoriamente ser a coluna content.'
                assert coltype == 'STRING' or coltype == 'TEXT', 'A coluna content deveria ser do tipo texto'
                assert notnull, 'A coluna content não deveria poder ser vazia'
                assert not pk, 'A coluna content não deveria ser chave primária'
            else:
                raise AssertionError(f'Não deveria existir uma coluna chamada {name}')
            found_count += 1

    def test_add_rows(self):
        db = database.Database(DB_NAME)
        if not hasattr(db, 'add') or not hasattr(database, 'Note'):
            raise NotImplementedError('Método add ou classe Note não foram implementadas ainda. Ignore se ainda não chegou neste exercício')

        data = [
            ('Pão doce', 'Abra o pão e coloque o seu suco em pó favorito.'),
            ('', 'Lembrar de tomar água'),
        ]
        try:
            for title, content in data:
                db.add(database.Note(title=title, content=content))
        except sqlite3.OperationalError:
            raise SyntaxError("Algo deu errado! Veja se não esqueceu as aspas em torno dos valores.")

        conn = sqlite3.connect(DB_FILENAME)
        cursor = conn.execute(f"SELECT * FROM {TABLE_NAME}")
        result = [(title, content) for _, title, content in cursor]
        result.sort(key=lambda r: r[1])
        assert data == result, 'Os dados não foram inseridos corretamente.'

    def test_select_rows(self):
        db = database.Database(DB_NAME)
        if not hasattr(db, 'add') or not hasattr(db, 'get_all') or not hasattr(database, 'Note'):
            raise NotImplementedError('Método add ou get_all ou a classe Note não foram implementadas ainda. Ignore se ainda não chegou neste exercício')

        data = [
            database.Note(title='Hidratação', content='Lembrar de tomar água'),
            database.Note(title='Pão doce', content='Abra o pão e coloque o seu suco em pó favorito.'),
        ]
        for note in data:
            db.add(note)

        try:
            notes = sorted(db.get_all(), key=lambda n: n.title)
        except:
            raise Exception("Verifique se o método get_all está retornando uma lista de Note")

        assert isinstance(notes, list), f'O método get_all deveria devolver uma lista. Obtido: {notes}'
        assert len(data) == len(notes), f'A lista devolvida tem uma quantidade de elementos diferente do esperado. Esperado: {len(data)}. Obtido: {len(notes)}.'
        assert all(d.title == n.title and d.content == n.content for d, n in zip(data, notes)), f'A lista de anotações é diferente da esperada. Esperada: {data}. Obtida: {notes}.'

    # def test_update_row(self):
    #     db = database.Database(DB_NAME)
    #     if not hasattr(db, 'add') or not hasattr(db, 'get_all') or not hasattr(db, 'update') or not hasattr(database, 'Note'):
    #         raise NotImplementedError('Método add, get_all ou update ou a classe Note não foram implementadas ainda. Ignore se ainda não chegou neste exercício')

    #     data = [
    #         database.Note(title='Hidratação', content='Lembrar de tomar água'),
    #         database.Note(title='Pão doce', content='Abra o pão e coloque o seu suco em pó favorito.'),
    #     ]
    #     for note in data:
    #         db.add(note)

    #     notes = sorted(db.get_all(), key=lambda n: n.title)
    #     new_title = 'Zebra'
    #     new_content = 'É um animal que começa com a letra Z.'
    #     updated_row = notes[1]
    #     updated_row.title = new_title
    #     updated_row.content = new_content

    #     try:
    #         db.update(updated_row)
    #     except sqlite3.OperationalError:
    #         raise SyntaxError("Algo deu errado! Veja se não esqueceu as aspas em torno dos valores.")

    #     notes = sorted(db.get_all(), key=lambda n: n.title)


    #     data[1].title = new_title
    #     data[1].content = new_content
    #     assert isinstance(notes, list), f'O método get_all deveria devolver uma lista. Obtido: {notes}'
    #     assert len(data) == len(notes), f'A lista devolvida tem uma quantidade de elementos diferente do esperado. Esperado: {len(data)}. Obtido: {len(notes)}.'
    #     assert all(d.title == n.title and d.content == n.content for d, n in zip(data, notes)), f'A lista de anotações é diferente da esperada. Esperada: {data}. Obtida: {notes}.'

    def test_delete_row(self):
        db = database.Database(DB_NAME)
        if not hasattr(db, 'add') or not hasattr(db, 'get_all') or not hasattr(db, 'delete') or not hasattr(database, 'Note'):
            raise NotImplementedError('Método add, get_all ou delete ou a classe Note não foram implementadas ainda. Ignore se ainda não chegou neste exercício')

        data = [
            database.Note(title='Hidratação', content='Lembrar de tomar água'),
            database.Note(title='Pão doce', content='Abra o pão e coloque o seu suco em pó favorito.'),
        ]
        for note in data:
            db.add(note)

        db.delete(1)
        notes = sorted(db.get_all(), key=lambda n: n.title)
        assert isinstance(notes, list), f'O método get_all deveria devolver uma lista. Obtido: {notes}'
        assert len(notes) == 1, f'A lista devolvida deveria ter apenas 1 elemento. Obtido: {len(notes)}.'
        note = notes[0]
        assert data[1].title == note.title and data[1].content == note.content, f'Foi removido o elemento errado.'

if __name__ == '__main__':
    unittest.main()
