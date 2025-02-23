from dotenv import load_dotenv
import os

class EnvLoader:
    def __init__(self):
        load_dotenv()

    def get_env(self, key):
        return os.getenv(key)
