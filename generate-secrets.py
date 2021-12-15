#!/usr/bin/env python3

import json
import random
import string

if __name__ == '__main__':
    server_key = ''.join(random.choice(string.ascii_letters) for _ in range(64))
    
    secrets = {"server-key": server_key}
    
    with open("secrets.json", 'w') as secrets_file:
        json.dump(secrets, secrets_file)
