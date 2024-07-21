syntax match RunDone /\V[DONE]\v( exited with code\=0)@=/
syntax match RunFailed /\V[ERROR]\v( exited with code=[^0])@=/
syntax match RunKilled /\V[SIGKILL]\v( exited with code=[^0])@=/
