import os
from configobj import ConfigObj


class Config(object):
    _config = None
    
    def __init__(self, confile=None):
        if confile is None:
            base = os.path.abspath(os.path.dirname(os.pardir))
            self._config = ConfigObj("%s/metrics.conf" % base)
        else:
            self._config = ConfigObj(confile)
    
    def __getattr__(self, name):
        return ConfigSection(self._config[name])
 
    def __getitem__(self, name):
        return self._config[name]
 
    def _raw(self):
        return self._config


class ConfigSection(object):
    _section = None

    def __init__(self, section):
        self._section = section

    def __getattr__(self, name):
        return self._section[name]

