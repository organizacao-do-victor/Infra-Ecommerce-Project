import http.server
from http.server import BaseHTTPRequestHandler, HTTPServer

PORT = 8008

class html(BaseHTTPRequestHandler):
    def do_GET (self):
        self.send_response (200)
        self.send_header('Content-type','text/html')
        self.end_headers ()
        message = '<!DOCTYPE html><html><head><title>AAAAAAAAAAAAAAAAAAAAAAAAA</title><meta charset="UTF-8"></head><body>'
        message += '<h1 style="font-family:arial black; font-size:360px;">NADA</h1>'
        message += '</body></html>'
        self.wfile.write (bytes(message, "utf8"))


with HTTPServer (('', PORT), html) as server:
    print("serving at port", PORT)
    server.serve_forever ()