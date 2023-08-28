from utils import build_response, delete_note, load_data, load_template, add_note, delete_note, update_note
import urllib.parse as urlparse
from database import Note


def index(request, route = ''):
    # A string de request sempre começa com o tipo da requisição (ex: GET, POST)
    if route != 'notas':
        if request.startswith('POST'):
            request = request.replace('\r', '')  # Remove caracteres indesejados
            partes = request.split('\n\n')
            corpo = partes[1]
            params = {}
            for chave_valor in corpo.split('&'):
                chave, valor = chave_valor.split('=')
                valor = urlparse.unquote_plus(valor, encoding='utf-8')
                params[chave] = valor
            note = Note(title=params['titulo'], content=params['detalhes']); add_note(note)
            return build_response(code=303, reason='See Other', headers='Location: /')
    note_template = load_template('components/note.html')
    notes_lista = []
    for dados in load_data():
        try:
            print(dados)
            note = note_template.format(id=dados.id, title=dados.title, content=dados.content)
            notes_lista.append(note)
        except:
            print('error')
            continue
    notes = '\n'.join(notes_lista)
    body = load_template('index.html').format(notes=notes, quantity=f'{len(notes_lista)} notas cadastradas')
    if route == 'notas':
        body = load_template('just_notes.html').format(notes=notes, quantity=f'{len(notes_lista)} notas cadastradas')
    return build_response() + body.encode()