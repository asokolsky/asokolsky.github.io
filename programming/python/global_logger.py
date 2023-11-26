
class GlobalLogger:
    '''
    Singleton implementation.
    From https://stackabuse.com/python-specific-design-patterns/
    '''

    _instance = None

    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super(GlobalLogger, cls).__new__(cls, *args, **kwargs)
        return cls._instance

    def __init__(self):
        self.log_level = "INFO"

    def set_log_level(self, level):
        self.log_level = level

    def log(self, message):
        print(f"[{self.log_level}] - {message}")


# Usage:
# logger1 = GlobalLogger()
# logger1.log("This is an info message.")

# logger2 = GlobalLogger()
# logger2.set_log_level("ERROR")
# logger2.log("This is an error message.")

# The log level has been globally updated
# logger1.log("This message also shows as an error.")
