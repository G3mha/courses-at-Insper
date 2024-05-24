import socket
import threading
import colorama
from time import time
import json
from concurrent.futures import ThreadPoolExecutor


def scan_port(host, port): # Scans a single port
  try:
    # Create the TCP socket
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
      sock.settimeout(0.5) # timeout in 500ms
      sock.connect((host, port)) # Try to connect to the port
      color = colorama.Fore.GREEN
      try:
        service = socket.getservbyport(port) # Get the service name
      except OSError:
        service = "Unknown"
      print(f"Port {port}: {color}{service}{colorama.Fore.RESET}")
      with open("port_scan_results.json", "a") as file:
        json.dump(dict(host=host, port=port, service=service), file)
  except socket.error:
    if only_open == "n":
      color = colorama.Fore.RED
      print(f"Port {port}: {color}Closed{colorama.Fore.RESET}")
      with open("port_scan_results.json", "a") as file:
        json.dump(dict(host=host, port=port, service="Closed"), file)

def scan_ports(host, ports): # Scans multiple ports
  # Single-threaded scanning
  for port in ports:
    scan_port(host, port)

def main():
  # Clear the output file
  with open("port_scan_results.json", "w") as file:
    file.write("")

  # Print the banner
  print(colorama.Fore.BLUE + "-" * 35)
  print(" " * 3 + "PORT SCANNER by Enricco Gemha")
  print("-" * 35 + colorama.Fore.RESET)

  host = input(f"{colorama.Fore.BLUE}Enter the IP address or hostname to scan: {colorama.Fore.RESET}")
  start_port = int(input(f"{colorama.Fore.BLUE}Enter the start port number: {colorama.Fore.RESET}"))
  end_port = int(input(f"{colorama.Fore.BLUE}Enter the end port number: {colorama.Fore.RESET}"))
  global only_open
  only_open = input(f"{colorama.Fore.BLUE}Only show open ports? (y/n): {colorama.Fore.RESET}").lower()
  
  # Print a separator
  print("-" * 35)

  ports = range(start_port, end_port + 1)

  start_time = time()

  scan_ports(host, ports)

  # Print a separator
  print("-" * 35)
  print(f"Execution time: {time() - start_time:.2f} seconds")
  print("The output has been saved to port_scan_results.json")

if __name__ == "__main__":
  colorama.init()
  main()
