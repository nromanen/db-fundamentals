class Base:
    def __init__(self, **kwargs):
        for key, value in kwargs.items():
            setattr(self, key, value)

    def __str__(self):
        result = {}
        for key, value in self.__dict__.items():
            result[key] = value
        return f"{result}"
