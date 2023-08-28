import json

def extract_route(request):
    return request.split()[1][1:]

def read_file(filepath):
    with open(filepath, 'rb') as file:
        return file.read()

def load_data(filename):
    filepath = f'data/{filename}'
    with open (filepath, 'r') as file:
        return json.loads(file.read())

def load_template(filename):
    filepath = f'templates/{filename}'
    with open (filepath, 'r') as file:
        return file.read()

def write_json(filename, content):
    data = load_data(filename)
    data.append(content)
    with open (f'data/{filename}', 'w') as file:
        print(data)
        json.dump(data, file)

def build_response(body='', code=200, reason='OK', headers=''):
    #'HTTP/1.1 200 OK\n\n'.encode() + response
    if headers:
        headers=f"\n{headers}"
    response = f"HTTP/1.1 {code} {reason}{headers}\n\n{body}".encode()
    return response