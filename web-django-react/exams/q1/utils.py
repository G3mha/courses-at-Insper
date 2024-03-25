from database import Database

db = Database('data/database')

def extract_route(request):
    return request.split()[1][1:]

def read_file(filepath):
    with open(filepath, 'rb') as file:
        return file.read()

def load_data():
    return db.get_all()

def load_template(filename):
    filepath = f'templates/{filename}'
    with open (filepath, 'r') as file:
        return file.read()

def build_response(body='', code=200, reason='OK', headers=''):
    if headers:
        headers=f'\n{headers}'
    return f'HTTP/1.1 {code} {reason}{headers}\n\n{body}'.encode()

def add_note(note):
    db.add(note)

def delete_note(note):
    notes_db = db.get_all() # Pega todas as notas do banco de dados
    for note_db in notes_db: # Para cada nota no banco de dados
        title_is_equal = note_db.title == note.title # Verifica se o titulo da nota da db é igual ao titulo da nota a ser deletada
        content_is_equal = note_db.content == note.content # Verifica se o conteudo da nota da db é igual ao conteudo da nota a ser deletada
        if (title_is_equal and content_is_equal):
            db.delete(note_db.id); break # Deleta a nota selecionada e termina o loop

def update_note(note_to_override, new_note):
    notes_db = db.get_all() # Pega todas as notas do banco de dados
    for note_db in notes_db:
        title_is_equal = note_db.title == note_to_override.title # Verifica se o titulo da nota a atualizar é igual ao titulo da nota a ser deletada
        content_is_equal = note_db.content == note_to_override.content # Verifica se o conteudo da nota a atualizar é igual ao conteudo da nota a ser deletada
        if (title_is_equal and content_is_equal):
            new_note.id = note_db.id; break # Armazena o id da nota a ser atualizada e termina o loop
    db.update(new_note) # Atualiza a nota no banco de dados
